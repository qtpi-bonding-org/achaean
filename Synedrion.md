# Synedrion Reference

A synedrion is the index/computation layer of the Koinon protocol. It crawls user git repos, indexes trust declarations and post metadata, computes polis membership from the trust graph, and serves query endpoints to clients.

**The synedrion never stores or serves content.** It only indexes metadata. Post content lives in user repos and is fetched directly by clients. This means a synedrion operator has no liability for user content — they're running a search index, not a hosting platform.

Anyone can run a synedrion. The protocol doesn't mandate a single implementation.

## Architecture

```
Git Repos (Archeion)          Synedrion                    Clients
┌─────────────────┐     ┌──────────────────────┐     ┌─────────────┐
│ alice/koinon     │────▶│ Webhook / Crawler     │     │ Flutter app │
│   koinon.json    │     │         │              │     │ Web app     │
│   trust/*.json   │     │    ┌────▼─────┐        │◀────│ CLI tool    │
│   posts/*.json   │     │    │ PostgreSQL│        │     └─────────────┘
│ bob/koinon       │────▶│    │ + AGE     │        │
│   ...            │     │    └──────────┘        │
└─────────────────┘     └──────────────────────┘
```

The synedrion has two jobs:

1. **Indexing** — Watch for changes in user repos (via webhooks or polling), read `koinon.json` manifests and `post.json` files, store metadata in the database.
2. **Querying** — Serve endpoints that clients call to discover poleis, compute feeds, look up relationships, and resolve membership.

## Data Model

### Relational Tables

| Table | Purpose | Key Fields |
|-------|---------|------------|
| `politai_users` | Known users | pubkey, repo_url |
| `trust_declarations` | Trust graph edges | from_pubkey, to_pubkey, level |
| `observe_declarations` | Non-structural follows | from_pubkey, to_pubkey |
| `polis_definitions` | Known communities | repo_url, name, membership_threshold, flag_threshold |
| `readme_signatures` | Who signed which polis README | signer_pubkey, polis_repo_url |
| `post_references` | Metadata pointers to posts | author_pubkey, post_url, timestamp |
| `flag_records` | Moderation signals | flagged_by_pubkey, post_url, polis_repo_url |

Full schema with indexes: [`synedrion/schema.sql`](synedrion/schema.sql)

### Trust Graph (Apache AGE)

The trust graph is stored in PostgreSQL using the [Apache AGE](https://age.apache.org/) extension, which adds Cypher graph query support to PostgreSQL. This allows both relational and graph queries in a single database.

```
Node labels:
  Polites  { pubkey }                    -- a user
  Polis    { repo_url, membership_threshold }  -- a community

Edge labels:
  (Polites)-[:TRUSTS {level}]->(Polites) -- trust declaration
  (Polites)-[:SIGNED]->(Polis)           -- README cosignature
```

The graph mirrors the relational trust/signature data but enables efficient traversal queries — particularly the membership computation, which requires counting mutual trust edges within a set of signers.

**Why AGE and not a separate graph database?** One database, one deployment, one backup. PostgreSQL + AGE gives you relational queries for feeds and graph queries for membership in the same transaction.

**Can I skip AGE?** Yes. Every graph query has a relational equivalent (see `queries.sql`). AGE is an optimization for trust graph traversal, not a requirement. A synedrion implementation using pure SQL joins will work — it'll just be slower for large poleis with complex trust graphs.

## Endpoints

A synedrion should expose these query endpoints. The wire protocol doesn't matter (REST, GraphQL, RPC) — what matters is the data contract.

### User

| Endpoint | Input | Output | Description |
|----------|-------|--------|-------------|
| `register` | repo_url | void | Register a repo for indexing (bootstrap) |
| `getUser` | pubkey | User? | Look up user by public key |

### Polis

| Endpoint | Input | Output | Description |
|----------|-------|--------|-------------|
| `listPoleis` | — | List\<Polis> | All known poleis |
| `getPolis` | repo_url | Polis? | Single polis by repo URL |
| `getPolisMembers` | repo_url | List\<PolisMember> | Signers + trust connection count |

`PolisMember` includes:
- `pubkey` — the user's public key
- `repo_url` — the user's repo URL
- `is_signer` — whether they signed the README
- `trust_connections` — number of mutual trust edges from other signers

The client compares `trust_connections >= membership_threshold` to determine full member vs provisional.

### Relationships

| Endpoint | Input | Output | Description |
|----------|-------|--------|-------------|
| `getRelationships` | pubkey | Relationships | All trust/observe, both directions |

`Relationships` contains four lists:
- `outgoing_trust` — people this user trusts
- `incoming_trust` — people who trust this user
- `outgoing_observe` — people this user observes
- `incoming_observe` — people who observe this user

### Feeds

| Endpoint | Input | Output | Description |
|----------|-------|--------|-------------|
| `getPersonalFeed` | (caller auth) | List\<PostRef> | Posts from trusted + observed + self |
| `getAgora` | polis_repo_url | List\<PostRef> | Posts from computed polis members |
| `getThread` | root_post_url | List\<PostRef> | Root post + direct replies |

### Moderation

| Endpoint | Input | Output | Description |
|----------|-------|--------|-------------|
| `getFlagsForPolis` | polis_repo_url | List\<Flag> | All flags in a polis |
| `getFlaggedPostsForVouchers` | (caller auth) | List\<Flag> | Flags on posts by people I trust |

## Indexing

The synedrion watches for changes in user repos — either via webhooks (push events from the forge) or by polling.

### What triggers indexing

1. **Manifest change** — `.well-known/koinon.json` is modified. Re-index all trust declarations, observe declarations, polis signatures, and flags for that user.
2. **Post change** — `posts/*/post.json` is created or modified. Upsert the post reference.

### Manifest indexing (atomic)

When a user's `koinon.json` changes:

1. Read `.well-known/koinon.json` from the user's repo
2. Parse the manifest
3. In a single transaction:
   - Upsert the user in `politai_users`
   - Delete + re-insert `trust_declarations` where `from_pubkey = user`
   - Delete + re-insert `observe_declarations` where `from_pubkey = user`
   - Delete + re-insert `readme_signatures` where `signer_pubkey = user`
   - Delete + re-insert `flag_records` where `flagged_by_pubkey = user`
4. Update the AGE graph (outside the transaction — AGE manages its own):
   - Upsert the `Polites` node
   - Replace `TRUSTS` edges from this user
   - Replace `SIGNED` edges from this user

The "delete + re-insert" pattern ensures the index always mirrors the repo. No drift, no stale data.

### Post indexing

When a `post.json` file changes:

1. Read the post file from the repo
2. Upsert into `post_references` by `post_url`
3. Do NOT store post content — only the metadata reference

## Membership Computation

The core algorithm: given a polis, who are its members?

1. Find all signers of the polis README (`readme_signatures` where `polis_repo_url = X`)
2. For each signer, count mutual trust connections from other signers
   - "Mutual" = A trusts B AND B trusts A, both with `level = 'trust'`
   - Only count connections where the other party is also a signer of this polis
3. A signer is a full member if `trust_connections >= membership_threshold`

This can be computed with relational SQL joins or AGE Cypher queries. See [`synedrion/queries.sql`](synedrion/queries.sql) for both approaches.

## Building Your Own Synedrion

To build a synedrion in any language:

1. Set up PostgreSQL with the tables from [`synedrion/schema.sql`](synedrion/schema.sql)
2. Optionally install Apache AGE for graph queries
3. Implement a webhook receiver or repo crawler that indexes `koinon.json` and `post.json` files
4. Implement the query endpoints listed above
5. Expose them over whatever protocol you prefer (REST, GraphQL, gRPC, etc.)

The reference queries in [`synedrion/queries.sql`](synedrion/queries.sql) are copy-pasteable SQL. The only language-specific part is your web framework and database driver.

## Reference Implementation

The Achaean synedrion (`achaean_server/`) is built with:
- **Serverpod** (Dart backend framework with type-safe RPC)
- **PostgreSQL** + **Apache AGE**
- **Forgejo webhooks** for real-time indexing

It's one possible implementation. The protocol doesn't require Serverpod, Dart, or even AGE — any stack that can run the queries and expose the endpoints will work.
