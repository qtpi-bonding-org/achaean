# Achaean

## The first implementation of the [Koinon Protocol](Koinon.md).

---

## The Stack

Dart top to bottom. One language, one ecosystem, shared models between client and server.

- **Flutter** — cross-platform client (mobile + desktop). Talks to Serverpod via type-safe RPC — no REST boilerplate.
- **Serverpod** — Dart backend. Handles auth, API endpoints, RSS subscription, crosspost bridges, and all server-side logic. Built-in Postgres ORM for relational data, raw SQL with Apache AGE for graph queries.
- **PostgreSQL + Apache AGE** — one database. Serverpod's ORM handles relational data (user accounts, feed subscriptions, post cache, crosspost configs). AGE extension handles graph queries (trust traversal, membership computation, agora building) via raw Cypher-in-SQL.
- **Forgejo** — git storage. Dumb pipe. The client and server talk to it via HTTPS/REST API. All git operations — commits, pushes, file reads — are API calls. No git binary anywhere.
- **RSS** — the notification layer. Each polites's repo contains a `feed.xml` that advertises new posts and trust changes. RSS doesn't contain content — it points to it. The Serverpod backend subscribes to feeds to know when something changed, then fetches actual content via forge APIs. Forge-agnostic, trivial to generate (templated from `post.json` metadata). Regenerated on every push.

---

## Key Management

The private key is stored in the platform keychain — **iCloud Keychain** on iOS/macOS, **Android Keystore** on Android. Automatic, encrypted, syncs across devices. The user never sees or manages their key directly.

- **New phone, same account**: sign into iCloud/Google, key is already there.
- **Optional encrypted export**: power user feature in settings — download a passphrase-protected key file as a backup. For the 1% who don't use cloud keychains.

Key recovery is a client concern, not a protocol concern. The protocol only requires that you have a keypair. How you back it up is your problem.

---

## The Client

A Flutter app (cross-platform, mobile + desktop). The user sees a social media app.

| Action | What the user sees | What happens under the hood |
|---|---|---|
| Create account | "Welcome. You're in." | Keypair generated and stored in platform keychain, repo initialized, pushed to forge, registered with Serverpod |
| Join polis | "Request sent." | README signature committed, waiting for vouch |
| Trust someone | A follow/friend button | Trust declaration committed |
| Vouch | "You vouched for Alice." | PROVISIONAL trust declaration committed |
| Revoke trust | An unfriend button | Trust file deleted, committed |
| Post | A text box | JSON committed to repo, crossposted to connected platforms |
| Post (rich) | A visual editor | JSON + HTML+CSS presentation committed to repo via presentation hook |
| Fork polis | "New polis created." | New README with parent pointer committed |
| Read feed | A filtered, personalized feed | Agora fetched from Serverpod API, content fetched from forge, rendered, optionally filtered by on-device preferences |
| Discover poleis | Browse/search page | Serverpod search API + trust graph navigation |

---

## Client-Side Resilience

The Flutter client maintains a complete local copy of your repo on-device — every post, image, trust declaration, README signature, and asset. The client is your repo. When you create content, it writes locally first, then pushes to the forge. If the server dies, the client has everything and re-pushes to a new forge on next launch. The user never thinks about backups.

Modern phones have 128GB+ storage. An active user's entire repo — posts, images, HTML+CSS layouts, trust declarations — is typically under 500MB. This is negligible.

This gives Koinon a better resilience story than any existing platform. If Twitter dies, your tweets are gone. If your Koinon managed service dies, the client rebuilds everything automatically.

---

## Dual-Mode Hosting

Repos can be mirrored to any number of forges simultaneously. In the client, adding a mirror is as simple as "Add backup mirror" and entering a GitHub/Codeberg username. The client pushes to all remotes on every action. Users don't need to know what a git remote is.

- **Managed Forgejo** (default) — the primary forge, provided by the managed service.
- **GitHub / Codeberg / Gitea** — optional mirrors. Free, easy to add.
- **Radicle** — P2P, fully sovereign. Discovery via gossip. No central dependency.

If the primary goes down, any mirror already has everything. Switch primary and keep going. The protocol doesn't care where the repo lives.

---

## Interoperability via Crossposting

The Flutter client crossposts directly to other platforms from the canonical JSON using platform SDKs. No git hooks involved — the client talks to each platform's API natively.

- **Nostr** — post JSON text as a Nostr event, signed with Nostr key.
- **Bluesky** — post JSON text as an AT Protocol record.
- **Mastodon** — POST JSON text to ActivityPub outbox.
- **RSS** — `feed.xml` in the repo, regenerated on every push.

Replies to crossposted content happen natively on whatever platform the conversation is on. The client posts directly to Bluesky/Nostr/Mastodon APIs — replies on other platforms don't go through the git repo. The repo is for canonical Koinon content, not a sync engine.

---

## Two Roles: Storage and Computation

Forgejo and Serverpod are architecturally independent. They are not 1:1. One Serverpod instance can crawl repos across hundreds of forges (Forgejo, GitHub, Codeberg — any forge with an API). One Forgejo instance can be crawled by multiple Serverpod instances. They never overlap.

Think of it like web servers and Google. Forges host the data. Serverpod crawls, indexes, computes, and serves.

**The Flutter client talks to both:**
- **Writes to Forgejo** — posting content, trust declarations, README signatures (via forge HTTPS API). This is the canonical data.
- **Reads from Serverpod** — pre-computed agoras (as references), search, discovery, membership data. This is the index.
- **Reads content from Forgejo** — when the client receives post references from Serverpod, it fetches the actual content (text, images, HTML) directly from the author's repo on the forge. Content flows forge → client. Serverpod never touches it.

```
Flutter writes → Forgejo (canonical data, any forge)
                    ↓
              RSS notification
                    ↓
              Serverpod reads metadata → Postgres+AGE (trust graph, post references)
                    ↓
Flutter reads ← Serverpod (post references, search)
Flutter reads ← Forgejo (actual content, directly from author's repo)
```

---

## Serverpod Is a Metadata Index, Not a Content Store

Serverpod never fetches, stores, or serves actual content. It only stores:
- **Trust declarations** — who trusts whom
- **README signatures** — who signed which polis README
- **Post references** — who posted, which polis, when, path to the post in their repo

When the client asks for the agora, Serverpod returns a list of references ("repo X, path Y, commit Z"). The client fetches the actual files — text, images, HTML — directly from the author's repo on the forge.

This means:
- **No content replication.** Content lives only in the author's repo on their forge. Serverpod never has a copy.
- **No unwanted hosting.** Illegal content never touches Serverpod. It only has a pointer. The forge hosting the repo has the legal obligation (and existing DMCA/CSAM mechanisms).
- **Trust revocation is instant.** The moment trust is revoked, Serverpod stops including that person's references in the agora. The client never fetches their content. It vanishes from every feed.

For the managed service, you run both. But a user could use GitHub as their forge and someone else's Serverpod instance for discovery. Or run their own Serverpod. No coupling.

---

## The Serverpod Backend

One Dart codebase, shared models with the Flutter client.

**Responsibilities:**

- **RSS subscriber** — discovers polites repos across any forge (via forge search or trust graph traversal), subscribes to their `feed.xml`. Processes updates only when something changes. The only expensive job is finding new repos to subscribe to — everything after that is listening.
- **Trust graph computation** — Postgres + AGE stores the trust graph. Cypher queries compute membership and build agoras. Serverpod's ORM handles everything else (accounts, sessions, feed subscriptions, post cache).
- **API endpoints** — type-safe RPC to the Flutter client. Serves pre-computed agoras, polis search, polites lookup, membership data. No REST boilerplate — Serverpod generates the client bindings.
- **Crosspost bridges** — transforms canonical JSON posts and sends to Nostr/Bluesky/Mastodon APIs.
- **Auth** — Serverpod's built-in auth module. Users sign up with email/OAuth, mapped to Forgejo accounts under the hood.
- **Registration endpoint** — `POST /register` with `{ "repo": "<repo-url>" }`. Fetches `.well-known/koinon.json`, subscribes to RSS. Bootstrap for self-hosted forges.

**Anyone can run their own Serverpod instance.** All the data is public. Multiple competing instances can crawl the same network. The Flutter client can be configured to point at any instance. No lock-in. To make this practical, existing Serverpod instances publish periodic **bootstrapped dataset snapshots** — a Postgres dump of the metadata index (trust graph, post references, polis list). A new instance imports the snapshot and starts crawling from there instead of from zero. Cheap to generate, trivial to distribute.

---

## Server-Side Agora Computation

The agora is always computed server-side by Serverpod. The client never computes the trust graph — it fetches pre-computed agoras from the Serverpod API. This avoids duplicating graph computation logic in both client and server, and keeps the Flutter client thin: keypair management, posting to forge APIs, rendering content, calling Serverpod for feeds.

The protocol still guarantees that anyone *could* independently verify the agora — all trust declarations and content are public. But in practice, Serverpod does the work.

---

## Scaling

The protocol is simple. Scaling it requires optional infrastructure on top — the same way HTTP is simple but the web at scale requires CDNs, caches, and search engines.

### Where the Bottlenecks Are

**Individual operations are cheap.** A trust declaration is a few hundred bytes. A post is a small directory. A reply reference is a hash. Git is extremely efficient at storing and diffing small files.

**Computing the agora is expensive.** To build the feed for a large polis, a naive client would need to fetch many repos, walk trust directories, verify mutual trust, collect tagged posts, and resolve reply chains across repos.

### Scaling Tiers

**Early ($10-20/mo VPS):** Single Serverpod instance, Postgres + AGE, Forgejo. All on one box. Handles thousands of users.

**Medium (dedicated hosting):** Separate Postgres instance, Serverpod on its own box, Forgejo on its own box. Real-time RSS processing.

**Large (real infrastructure):** Managed Postgres (with AGE), multiple Serverpod instances, CDN in front of the API, sharded by trust graph regions.

### What Makes This Tractable

**`.well-known/koinon.json`** — aggregators don't need to clone full repos. They poll lightweight manifests, check for changes, fetch only what's new.

**RSS feeds** — this is what makes the indexer scalable. The crawler doesn't poll — it subscribes. Once it discovers a polites's repo, it subscribes to their `feed.xml` and only processes updates when something changes. Most checks are a single `If-Modified-Since` header with zero bandwidth. The crawler's only expensive job is discovering new repos to subscribe to. Everything after that is listening. RSS turns polling into subscription — a solved problem at any scale.

**Immutable commit hashes** — reply threads and content references are pinned to commit hashes. Once resolved, they can be cached permanently. Thread structure can't change retroactively.

**The agora is deterministic** — given the same trust graph and tagged content, any client or aggregator computes the same agora. Results are independently verifiable.

This is the same tradeoff the web made. HTTP is simple. At scale you need CDNs, caches, and search engines. Those are infrastructure on top of the protocol, not changes to the protocol. Koinon stays pure. Scaling is an infrastructure concern.

---

## Open Questions

- **On-device model requirements** — minimum viable model for client-side moderation, fallback for low-power devices
- **Agora sorting** — how does Serverpod sort/rank content? Chronological, reply count, trust-weighted signals? Per-polis configuration?
- **Reverse bridges** — pulling replies from other networks back into the agora
- **Post templates** — shareable layout templates for non-technical users
- **Visual editor** — WYSIWYG post editor that generates HTML + CSS
- **Serverpod API spec** — exact RPC endpoints, response formats, pagination
- **Trust revocation urgency** — in large poleis, there's a visibility window between a bad actor posting and their vouchers revoking trust. Serverpod could implement flagging, auto-hide thresholds, or circuit breakers to shrink this window. Protocol-clean — purely an aggregator-level concern.

---

*Achaean is the first implementation of the [Koinon Protocol](Koinon.md). This document is version 1.0.*
