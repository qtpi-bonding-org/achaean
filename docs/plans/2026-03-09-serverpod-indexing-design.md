# Serverpod Indexing & Membership Computation Design

## Scope

Serverpod Phase 2.4 + 3.1: webhook indexing, Apache AGE trust graph, membership computation, stateless keypair-signed request auth. Plus `dart_koinon` manifest update (add `trust` array to `KoinonManifest`) and Flutter `TrustService` update to maintain it.

## Key Decisions

- **Auth (query endpoints):** Stateless keypair auth. Client sends `X-Koinon-Pubkey`, `X-Koinon-Timestamp`, `X-Koinon-Signature` headers. Serverpod verifies ECDSA P-256 signature of timestamp bytes using `CryptoAuth.verifySignature()` from `anonaccount_server`. Rejects timestamps older than 5 minutes. No accounts, no sessions.
- **Auth (webhook):** Shared secret header (`X-Webhook-Secret`) between Forgejo and Serverpod. Private infra channel only. Third-party aggregators crawl public repos directly.
- **Indexing strategy:** Webhook sees `.well-known/koinon.json` changed → reads that one file via `IGitClient` + `GitPublicAuth` → gets complete trust + polis state. Atomic replace: delete all trust declarations and readme signatures for this pubkey, re-insert from manifest. Wrapped in a database transaction.
- **Storage:** Relational tables for koinon primitives (existing). AGE graph for trust traversal and membership computation.
- **Membership function:** Signed current README + N mutual TRUST edges with other signers. N = polis `threshold` from README frontmatter, default 1 if not specified.

---

## `dart_koinon` Changes

**Add `trust` array to `KoinonManifest`:**

```json
{
  "protocol": "koinon",
  "version": "1.0",
  "pubkey": "abc123...",
  "repo_https": "http://localhost:3000/alice/koinon",
  "poleis": [
    { "repo": "alice/polis-democracy", "name": "Democracy", "stars": 3, "role": "member" }
  ],
  "trust": [
    { "subject": "def789...", "repo": "http://localhost:3000/bob/koinon", "level": "trust" }
  ]
}
```

- New `TrustEntry` freezed model: `subject` (String), `repo` (String), `level` (TrustLevel)
- Add `@Default([]) List<TrustEntry> trust` to `KoinonManifest`
- Remove `trustIndex` field

---

## Flutter `TrustService` Update

On `declareTrust()`: add a `TrustEntry` to `koinon.json`'s `trust` array (same pattern as `PolisService._addPolisToManifest()`).

On `revokeTrust()`: remove the entry from `koinon.json`'s `trust` array (same pattern as `PolisService._removePolisFromManifest()`).

---

## Webhook Indexing

When webhook receives a push event:

1. Parse via `ForgejoWebhookParser` → `NormalizedPushEvent` (existing)
2. Check changed files for `.well-known/koinon.json`:
   - Read file from Forgejo via `IGitClient` + `GitPublicAuth`
   - Parse `KoinonManifest`
   - In a single transaction:
     - Upsert `PolitaiUser` (pubkey, repoUrl)
     - Delete all `trust_declarations` rows where `fromPubkey` = this pubkey
     - Insert new rows from manifest `trust` array
     - Delete all `readme_signatures` rows where `signerPubkey` = this pubkey
     - Insert new rows from manifest `poleis` array
     - Drop AGE edges for this pubkey, re-create from current state
3. Check changed files for `posts/*/post.json`:
   - Upsert `PostReference` from file path + commit metadata (existing behavior)

Webhook is protected by `X-Webhook-Secret` header checked against an environment variable.

---

## AGE Graph Schema

**Graph name:** `koinon`

**Nodes:**
- `Polites` — properties: `pubkey` (unique identifier)
- `Polis` — properties: `repo_url` (unique identifier), `threshold`

**Edges:**
- `(:Polites)-[:TRUSTS {level: 'trust'|'provisional'}]->(:Polites)`
- `(:Polites)-[:SIGNED]->(:Polis)`

**Setup:** Migration creates the graph via `SELECT * FROM ag_catalog.create_graph('koinon')`. Nodes and edges managed via Cypher `MERGE`/`DELETE` in raw SQL from Dart.

---

## Membership Query (Cypher)

Given polis P with threshold N:

```cypher
-- Find signers of P who have >= N mutual TRUST edges with other signers
MATCH (signer:Polites)-[:SIGNED]->(p:Polis {repo_url: $polisRepoUrl})
WHERE EXISTS {
  MATCH (signer)-[:TRUSTS {level: 'trust'}]->(other:Polites)-[:TRUSTS {level: 'trust'}]->(signer)
  WHERE (other)-[:SIGNED]->(p)
  WITH count(other) AS mutual_count
  WHERE mutual_count >= $threshold
}
RETURN signer.pubkey
```

N comes from `PolisDefinition.threshold`, defaulting to 1 if null.

---

## Endpoints

**Auth middleware:** All endpoints except webhook extract `X-Koinon-Pubkey`, `X-Koinon-Timestamp`, `X-Koinon-Signature` from headers. Verify signature using `CryptoAuth.verifySignature()` from `anonaccount_server`. Reject if timestamp > 5 minutes old.

**Existing (updated):**
- `getAgora(polisRepoUrl, limit, offset)` → Compute members via AGE → query `post_references` for posts from members tagged for this polis → return `List<PostReference>`
- `getUser(pubkey)` → `PolitaiUser?` (unchanged)
- `listPoleis()` → `List<PolisDefinition>` (unchanged)
- `getPolis(repoUrl)` → `PolisDefinition?` (unchanged)
- `getPolisSigners(polisRepoUrl)` → `List<ReadmeSignatureRecord>` (unchanged)
- `getTrustDeclarations(pubkey)` → `List<TrustDeclarationRecord>` (unchanged)

**New:**
- `getPolisMembers(polisRepoUrl)` → AGE membership query → `List<PolitaiUser>` who meet the threshold

**Webhook:**
- `handlePush(payload)` — protected by shared secret, not keypair auth

---

## Signature Format

Flutter `IKeyService.signBytes()` returns raw bytes encoded as base64url. `CryptoAuth.verifySignature()` expects hex-encoded 64-byte r||s signature. Reconcile during implementation — either adapt Flutter to send hex or adapt the verification middleware to accept base64url and convert.

---

## Data Flow Summary

> **NOTE:** The read path has been updated. See `2026-03-10-serverpod-rss-aggregation-design.md`.
> Serverpod now caches full post content (from RSS feeds) and serves it directly.
> Flutter no longer fetches post content from the forge — it reads from Serverpod.
> The forge is the write layer; Serverpod is the read layer.

```
User action (Flutter)
  → writes to Forgejo (direct, via IGitClient)
  → regenerates feed.xml with full post.json content
  → Forgejo fires system webhook
  → Serverpod webhook endpoint
    → reads koinon.json from Forgejo (GitPublicAuth)
    → atomic replace: relational tables + AGE edges
    → reads feed.xml, upserts new/updated posts

Flutter query
  → sends pubkey + signed timestamp to Serverpod
  → Serverpod verifies signature (CryptoAuth)
  → resolves user's trust graph (cached set of trusted pubkeys)
  → returns full post content filtered by trust + polis
```
