# Achaean Build Plan

## Existing Code

| Package | Path | What we use |
|---|---|---|
| **dart_jwk_duo** | `openops/project/quanitya/.independent-repos/dart_jwk_duo` | Identity layer. ECDSA P-256 signing keypair = polites identity. `signBytes()` for post/trust signing. `exportPublicKeyHex()` for public key in declarations. JWK serialization for key storage. Drop encryption side (public-only v1). |
| **serverpod_anonaccred** | `openops/project/quanitya/.independent-repos/serverpod_anonaccred` | Fork for Achaean. Keep account + device auth (challenge-response, multi-device, zero-PII). Strip commerce/entitlements layer. Add Koinon-specific endpoints. |
| **flutter_starter_template** | `openops/project/quanitya/.independent-repos/flutter_starter_template` | App scaffold. Cubit + GoRouter + get_it DI + theming + error handling + l10n. Add feature modules on top. |

## What We Build

| Component | Description |
|---|---|
| **Forgejo API package** | Pure Dart package — create repos, commit files, read content via REST API. Used directly by Flutter client for reads and writes. No Serverpod dependency. |
| **RSS** | Generate `feed.xml` from post metadata (client-side), parse feeds (Serverpod-side) |
| **Apache AGE queries** | Cypher-in-SQL for trust graph traversal, membership computation, agora building |
| **Koinon endpoints** | Serverpod endpoints — agora, polis search, trust graph, registration, discovery, notify (post/trust/polis indexing) |
| **Feature modules** | Flutter — feed, post composer, trust management, polis browser |
| **Crossposting** | Nostr/Bluesky/Mastodon SDK integration (deferred, figure out later) |

## Architecture Decision: Client-Direct Writes

The client writes directly to Forgejo rather than going through Serverpod. Rationale:
- **User sovereignty** — users write to their own repo, no intermediary
- **Resilience** — posting works even if Serverpod is down
- **No lock-in** — client talks to standard Git forge API, portable to GitHub/Codeberg
- **Simpler infrastructure** — Serverpod is the aggregator/indexer, not a write proxy
- **Same code either way** — Forgejo API calls are identical regardless of where they run

After writing, Forgejo fires a system webhook to the aggregator (Serverpod) so it can index immediately. The system webhook applies globally to all repos — no per-user registration needed. The aggregator discovers new users automatically when it sees a repo with `.well-known/koinon.json`. RSS serves as a fallback for cross-instance discovery where webhooks aren't available.

---

## Phase 1: First Post

**Goal:** A user can sign up, get a repo, and publish a signed post.

### 1.1 Project setup
- Fork flutter_starter_template → `achaean_flutter`
- Fork serverpod_anonaccred → `achaean_server` (strip commerce/entitlements)
- Add dart_jwk_duo as dependency to both client and server
- Set up Forgejo instance (managed or local Docker)
- Set up Postgres + Apache AGE

### 1.2 Forgejo API package (pure Dart)
- Standalone Dart package, no Serverpod dependency — usable from client, server, or CLI
- `createRepo(username)` → initialize polites repo with directory structure
- `commitFile(repo, path, content)` → write files to repo
- `readFile(repo, path)` → read file content
- `listFiles(repo, path)` → list directory contents
- Scaffold the repo on creation:
  ```
  .well-known/koinon.json
  identity/pubkey.json
  posts/
  trust/
  poleis/
  feed.xml
  ```

### 1.3 Account creation flow
- Client generates ECDSA P-256 keypair via dart_jwk_duo
- Store private key in platform keychain (iCloud Keychain / Android Keystore)
- Register with Serverpod via anonaccred challenge-response
- Client creates Forgejo repo directly via Forgejo API package
- Client scaffolds repo and pushes `identity/pubkey.json` and `.well-known/koinon.json`
- Forgejo system webhook fires → Serverpod auto-discovers the new user

### 1.4 Post creation
- Client writes `post.json` with content, routing, timestamp
- Client signs the post with keypair → `signature` field
- Client commits to `posts/<date>-<slug>/post.json` directly via Forgejo API
- Client regenerates `feed.xml` and commits it
- Forgejo webhook fires → Serverpod indexes immediately
- Client can view own posts by reading from repo

**Milestone: user signs up, posts, sees their own content.**

---

## Phase 2: Trust & Membership

**Goal:** Users can trust each other. Poleis can be created and joined.

### 2.1 Trust declarations
- Client writes `trust/<name>.json` with subject pubkey, repo URL, level, signature
- Client commits directly to Forgejo via API package
- Forgejo webhook fires → Serverpod indexes trust declaration in Postgres + AGE
- RSS serves as backup indexing path for cross-instance discovery

### 2.2 Polis creation
- Client creates a new repo (the polis repo) directly via Forgejo API package
- README contains: description, norms, membership threshold, parent pointer
- Creator signs the README
- Client commits signature to own repo at `poleis/<polis-repo-id>/signature.json`
- Forgejo webhook fires → Serverpod indexes new polis

### 2.3 Polis joining
- Client reads the polis README
- Client signs it → commits `poleis/<polis-repo-id>/signature.json` to own repo directly via Forgejo API
- Forgejo webhook fires → Serverpod indexes the signature

### 2.4 Membership computation (AGE)
- Cypher query: find all politai who signed this polis README AND have N mutual TRUST edges with other signers
- Store computed membership as materialized view or cached result
- Expose via Serverpod endpoint

### 2.5 Flutter trust UI
- Trust/untrust button on user profiles
- Polis browser — list, search, create, join, fork
- Member list per polis

**Milestone: users trust each other, create/join poleis, membership is computed.**

---

## Phase 3: The Agora

**Goal:** Users see a feed of posts from trusted members of a polis.

### 3.1 Webhook receiver + RSS fallback (Serverpod)
- Webhook endpoint receives push events from Forgejo → parses changed files → indexes in Postgres
- Store post references (author, polis, path, commit, timestamp)
- RSS fallback for discovering repos on foreign forge instances (no webhook access)
- On new trust declaration, follow repo URL → if foreign forge, subscribe to RSS feed

### 3.2 Agora computation (AGE)
- Given a polis: get members (from Phase 2.4) → get their post references tagged for this polis → sort → return
- Expose as Serverpod endpoint: `getAgora(polisId, page, sort)`
- Returns list of references, not content

### 3.3 Content fetching (client)
- Client receives post references from Serverpod
- Client fetches actual `post.json` + presentation files directly from author's repo on forge
- Client renders posts using PostSchema rendering rules

### 3.4 Flutter feed UI
- Feed screen per polis (the agora)
- Pull-to-refresh
- Post detail view (with thread/replies)
- Post composer (text, optional title, URL, media, tags, polis selection)
- Reply composer

### 3.5 User discovery
- Forgejo system webhook fires on every push → Serverpod checks for `.well-known/koinon.json`
- If found, Serverpod auto-indexes the user (pubkey, repo URL, metadata)
- No explicit registration step needed — users are discovered by pushing to Forgejo
- For foreign forge instances (no system webhook), RSS crawling discovers new users

**Milestone: working social network. Users post, see each other's content in polis feeds.**

---

## Phase 4: Rich Features

**Goal:** Presentation layer, discovery, crossposting.

### 4.1 Rich presentation
- Post composer option: add HTML+CSS layout
- Visual editor (or simple template picker) that generates HTML+CSS
- Client renders `index.html` in sandboxed webview (JS disabled)

### 4.2 Discovery
- `.well-known/koinon.json` auto-generated on every change
- Serverpod search endpoint: search poleis by name, topic, size
- Trust graph navigation UI: "people you trust are in these poleis"
- Bootstrapped dataset snapshots: periodic Postgres dump for new instances

### 4.3 Crossposting (deferred details)
- Integrate Dart SDKs for Nostr, Bluesky, Mastodon
- Client-side: user connects accounts in settings
- On post: client reads crosspost layer from post.json → sends to each platform
- Replies on other platforms stay native

### 4.4 Client-side moderation
- On-device model (Gemma or similar) for content filtering
- User preferences: what categories to filter
- Runs on feed content before rendering

### 4.5 Forking
- Fork polis button → creates new repo with parent pointer
- New README, user signs it
- Fork appears in discovery with lineage visible

**Milestone: full-featured platform.**

---

## Phase 5: Polish & Launch

### 5.1 Dual-mode hosting
- Mirror management UI: add GitHub/Codeberg as backup
- Client pushes to all remotes on every action

### 5.2 Client-side resilience
- Full local repo copy on device
- Detect forge downtime → switch to mirror
- Re-push to new forge on recovery

### 5.3 Key management
- iCloud Keychain / Android Keystore integration
- Optional encrypted key export in settings

### 5.4 Onboarding
- First-run experience: generate key, create repo, join first polis
- Invite links: share polis link → opens app → joins polis

---

## Tech Stack Summary

```
Flutter (Cubit + GoRouter + get_it)
    ├── → Forgejo (REST API) — direct reads AND writes via Forgejo API package
    └── ← Serverpod (query) — agora, trust graph, discovery, search
Serverpod (forked anonaccred)
    ├── ← Forgejo webhooks — real-time indexing on push
    ├── ← Forgejo RSS — fallback for cross-instance discovery
    └── ↕ PostgreSQL + Apache AGE — trust graph, membership, agora

Forgejo → Radicle (system webhook → radicle-mirror → P2P replication)

Forgejo API package (pure Dart, no Serverpod dependency)
dart_jwk_duo (ECDSA P-256 signing)
```

## What's Deferred

- Crossposting platform details (Phase 4, figure out SDKs later)
- Commerce/billing for managed service (keep original anonaccred, revisit if needed)
- Encrypted poleis (future protocol version)
- ~~Radicle integration~~ ✓ Done — auto-mirrors all repos via system webhook
- On-device moderation model selection
