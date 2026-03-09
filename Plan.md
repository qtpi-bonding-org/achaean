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
| **Forgejo API service** | Dart HTTP client — create repos, commit files, read content via REST API |
| **RSS** | Generate `feed.xml` from post metadata (client-side), parse feeds (Serverpod-side) |
| **Apache AGE queries** | Cypher-in-SQL for trust graph traversal, membership computation, agora building |
| **Koinon endpoints** | Serverpod endpoints — agora, polis search, trust graph, registration, discovery |
| **Feature modules** | Flutter — feed, post composer, trust management, polis browser |
| **Crossposting** | Nostr/Bluesky/Mastodon SDK integration (deferred, figure out later) |

---

## Phase 1: First Post

**Goal:** A user can sign up, get a repo, and publish a signed post.

### 1.1 Project setup
- Fork flutter_starter_template → `achaean_flutter`
- Fork serverpod_anonaccred → `achaean_server` (strip commerce/entitlements)
- Add dart_jwk_duo as dependency to both client and server
- Set up Forgejo instance (managed or local Docker)
- Set up Postgres + Apache AGE

### 1.2 Forgejo API service (Dart)
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
- Serverpod creates Forgejo account + repo via API
- Client pushes `identity/pubkey.json` and `.well-known/koinon.json`

### 1.4 Post creation
- Client writes `post.json` with content, routing, timestamp
- Client signs the post with keypair → `signature` field
- Client commits to `posts/<date>-<slug>/post.json` via Forgejo API
- Client regenerates `feed.xml` and commits it
- Client can view own posts by reading from repo

**Milestone: user signs up, posts, sees their own content.**

---

## Phase 2: Trust & Membership

**Goal:** Users can trust each other. Poleis can be created and joined.

### 2.1 Trust declarations
- Client writes `trust/<name>.json` with subject pubkey, repo URL, level, signature
- Client commits via Forgejo API
- Serverpod RSS subscriber picks up the change
- Serverpod indexes trust declaration in Postgres + AGE

### 2.2 Polis creation
- Client creates a new repo (the polis repo) with README
- README contains: description, norms, membership threshold, parent pointer
- Creator signs the README
- Client commits signature to own repo at `poleis/<polis-repo-id>/signature.json`

### 2.3 Polis joining
- Client reads the polis README
- Client signs it → commits `poleis/<polis-repo-id>/signature.json` to own repo
- Serverpod indexes the signature

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

### 3.1 RSS subscriber (Serverpod)
- On startup, subscribe to known feeds
- On new trust declaration, follow repo URL → discover + subscribe to new feeds
- On RSS update, fetch post metadata from forge → index in Postgres
- Store post references (author, polis, path, commit, timestamp)

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

### 3.5 Registration endpoint
- `POST /register` with `{ "repo": "<repo-url>" }`
- Serverpod fetches `.well-known/koinon.json`, subscribes to RSS
- Client calls this automatically on account setup

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
    ↕ type-safe RPC
Serverpod (forked anonaccred)
    ↕ ORM + raw SQL
PostgreSQL + Apache AGE

Forgejo (REST API)
    ↕ HTTPS
Flutter (direct content reads)

dart_jwk_duo (ECDSA P-256 signing)
```

## What's Deferred

- Crossposting platform details (Phase 4, figure out SDKs later)
- Commerce/billing for managed service (keep original anonaccred, revisit if needed)
- Encrypted poleis (future protocol version)
- Radicle integration (optional mirror, not critical path)
- On-device moderation model selection
