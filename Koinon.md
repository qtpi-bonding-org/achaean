# The Koinon Protocol

## A protocol for sovereign identity, voluntary community, and client-side moderation.

### Achaean is the first implementation.

*Koinon (Greek: κοινόν, "the common thing") was the word the ancient Greeks used for their confederacies — voluntary leagues of sovereign city-states. The Achaean League (5th century BC — 146 BC) was the most successful of these, balancing collective action with local autonomy. Through the writings of the Achaean statesman Polybius, this structure influenced the constitution of the United States and other modern federal states.*

---

## Terminology

| Term | Meaning |
|---|---|
| **Koinon** | The protocol. The shared specification that defines how identity, trust, communities, and content work. |
| **Achaean** | The first implementation of the Koinon protocol. A Flutter client app. |
| **Polis** (plural: poleis) | A community. A self-governing, voluntary group bound by a shared document and mutual trust. |
| **Polites** (plural: politai) | A citizen. A user identified by their cryptographic keypair. |
| **Agora** | The community feed. The computed index of content from trusted members. The public square. |

---

## Core Philosophy

Social problems should be solved by social mechanisms, not technical enforcement. The protocol does not govern. It makes trust relationships legible and gets out of the way. Everything else — moderation, governance, community boundaries, schism, reconciliation — is emergent.

A polis is not an actor. It does not sign things, hold keys, or take actions. Only politai are actors. A polis is what you see when a group of sovereign individuals trust each other around a shared document.

---

## Three Pillars

### 1. Sovereign Identity

- Identity is a cryptographic keypair generated via the Web Crypto API in the browser.
- No server owns your identity. No admin can delete you. You exist independent of any polis, relay, or platform.
- You are responsible for your own key. Key recovery (Shamir's secret sharing, social recovery, encrypted backups) is an application-layer concern, not a protocol concern.

### 2. Voluntary Community (Confederation)

- A polis is **not** a server, a channel, an admin-controlled space, or an entity with its own key.
- A polis is a **git repo** containing a signed, versioned document (the README) — a social contract. The polis identity is the repo, not any single version of the README.
- Members cosign the README — each member signs the README content with their keypair and stores the signature in their own repo. This is a literal act of agreement: "I agree to these terms."
- Membership is the intersection of: having signed the current README version, and having mutual trust relationships with other signers above the polis's defined threshold.
- No one is trapped. No one is owned. Membership is always voluntary. Exit is always free.

### 3. Client-Side Moderation

- Subjective content moderation happens **on-device**, not on the server.
- Users run a local model (e.g., Gemma) that filters content according to their personal preferences.
- Everything — politics, NSFW, opinions, vibes — is the user's choice to see or not see.

---

## Mental Model

**Politai are git repos.** Each polites has a signed log of their content — posts, messages, media. Signed by their Web Crypto keypair. This is theirs forever.

**Poleis are git repos.** A polis is a repo containing a README — the social contract. Members cosign it. The agora is **computed** by the aggregator from the trust graph: collect all content that trusted, signed members have tagged for this polis.

**Forks are just forked repos.** Anyone forks the polis repo, writes a new README, signs it. People sign the fork or they don't. The fork inherits the old agora by default (minus any exclusions). No permission needed. No vote required.

### Community Health: Two Numbers

**Stars** = how many individual keypairs have signed the current README. **Breadth.**

**Edges** = how many mutual trust relationships exist between signers of this polis's README. **Depth.**

- High stars, low edges → loose audience, broadcast polis, public forum.
- High edges relative to stars → tight-knit crew, everyone knows each other.
- Fork health: high stars but low edges is fragile. High edges means cohesive.

---

## Polis Structure

### The README

A polis is defined by its git repo. The repo contains a signed, versioned document — the README. The polis identity is the repo (stable URL/ID), not any single README hash. The README can be updated by the repo owner without breaking the polis identity. It contains:

- **What the polis is about** — could be a paragraph, a manifesto, or just "shitposting about linux."
- **Norms and expectations** — social conventions, not enforced rules.
- **Membership threshold** — how many mutual trust links are required for full membership.
- **Parent pointer** — the repo this was forked from (null for genesis).
- **Optional metadata** — recommended client-side moderation defaults, founding signers, etc.

The README is signed by its author (the repo owner). It is a social contract. When the README changes, members review and re-sign. A member who hasn't signed the current version is flagged as stale — not revoked, but not current. If the repo owner pushes something the community rejects, nobody re-signs, and someone forks the repo. The owner has commit access, not authority. Authority comes from member signatures.

### The Agora (Computed, Not Signed)

The agora is computed by any client from two inputs:

1. **The trust graph** — who is a trusted member of this polis?
2. **Tagged content** — what content have those trusted politai tagged for this polis?

No central authority maintains it. The agora is emergent.

### The Web of Trust

Three trust states:

| State | Meaning |
|---|---|
| **No Trust** | Default. No one has vouched for you. |
| **Provisional** | Someone has vouched for you. You can participate but cannot vouch for others. |
| **Trust** | Full mutual trust. You can vouch for new provisional members. Revocable at any time. |

A trust declaration is between two individuals: **I trust this polites.** Trust is not scoped to any polis — you either trust someone or you don't. Poleis are lenses over the trust graph, not containers for it.

#### How membership works:

- Everyone starts at **No Trust**.
- An existing trusted polites vouches for you → **Provisional**.
- Existing members independently decide to upgrade you to **Trust**.
- Mutual trust links meeting the README's threshold → **full member**.
- Trust revoked, below threshold → out. No one banned you. You stopped being trusted.

#### Accountability:

Vouching has social cost. Vouch for a bad actor, it reflects on you.

### Forking

No consensus process. As free as forking a repo — because it literally is forking a repo.

- **Anyone can fork at any time for any reason.**
- To fork: fork the polis repo, write a new README, sign it, publish. The parent pointer is the original repo.
- The fork succeeds only if people actually sign the new README. You can see exactly who signed which fork — it's a vote with cryptographic receipts.
- The "real" polis is whichever fork the trust graph follows. Dead forks wither.

Bad actors: the polis repo forks. The bad actor is left behind. They can't meet the membership threshold in the new fork because no one trusts them.

### History Continuity

Forks inherit the entire old agora by default. The fork specifies an exclusion list — specific content or author keypairs to drop. The default is to keep everything. Full version history visible like `git log`.

---

## Protocol Primitives

The Koinon protocol defines four primitives:

### 1. README

The polis's social contract. A signed, versioned document in the polis's git repo. The polis identity is the repo (stable URL/ID). Contains: parent pointer (forked-from repo), membership threshold, exclusion list, author signature, optional metadata. Updated by the repo owner; validated by member signatures.

### 2. Trust Declaration

A signed file: author keypair, subject keypair, trust level (`TRUST` or `PROVISIONAL`). Trust is between individuals — not scoped to any polis. Poleis compute membership from the global trust graph. Revocable by deletion.

### 3. README Signature

A signed file in the polites's own repo: the README content (or its hash), the polis repo ID, the README commit hash, and the polites's signature. This is the act of cosigning the social contract. Signatures are decentralized — scattered across member repos — and assembled by the aggregator.

### 4. Membership Function

Computed, not stored. Member = signed the current README version + mutual `TRUST` declarations (from the global trust graph) with N other signers (N = threshold). The agora is also computed from this. Trust exists between individuals independent of any polis; poleis are just lenses that filter the trust graph by who has signed their README.

---

## Post Format

Posts in the Koinon protocol are not flat text in a box. Every social platform today forces content into the same cookie-cutter template — the same text box, the same card layout, the same visual identity for everyone. Koinon gives content back to the creator.

### A Post Is a Directory

Each post is a directory in the polites's repo containing:

- **`post.json`** — metadata: signature, polis tags, timestamp, content type.
- **`index.md` or `index.html`** — the actual content.
- **Any supporting assets** — images, CSS, fonts, data files.

### Two Formats

**Markdown (default)** — for most posts. Clean, readable, universal. Every developer knows it, every LLM speaks it natively, it converts to HTML trivially. Zero friction. A simple post is just a `.md` file.

**HTML + CSS (power mode)** — for full creative control. Custom layouts, typography, colors, grids, CSS animations, responsive design. Make your post look like a magazine spread, a poster, a photo essay. Your visual identity is part of your expression.

**JavaScript is not allowed.** HTML + CSS is rendered in a sandboxed view with JS disabled. This is the security boundary. HTML without JS is a safe document format — no code execution, no injection attacks, no security risk. All the expressiveness, none of the danger.

### Why This Matters

On Instagram, your post looks like everyone else's post. On Twitter, your thoughts are in the same text box as everyone else's thoughts. The platform owns the visual identity. You just fill in the content.

On Koinon, the presentation is yours. How your post looks is part of what you're saying. This is how the web was supposed to work — everyone had their own page, their own style, their own identity. Social media flattened all of that. Koinon brings it back.

### Post Metadata (`post.json`)

```json
{
  "type": "post",
  "format": "md",
  "poleis": ["<polis-repo-id>"],
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

For replies, the `reply_to` field pins the reply to an exact version of the parent post via its git commit hash:

```json
{
  "type": "post",
  "format": "md",
  "poleis": ["<polis-repo-id>"],
  "reply_to": {
    "author": "<their-public-key>",
    "repo": "rad:z3gqcJ...",
    "path": "posts/2026-03-08-why-i-love-rust/post.json",
    "commit": "a1b2c3d4..."
  },
  "timestamp": "2026-03-08T13:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

The commit hash is immutable. Even if the original author edits or deletes their post, your reply still points to the exact version you were responding to. Git gives you receipts for free. Threading is just a linked list of signed files across repos — a reply to a reply has its own `reply_to` pointing to the reply's commit hash. The client walks the chain and renders a thread.

Cross-polis replies work naturally. Your reply lives in your repo, tagged for your polis, but it references a post in a different repo and potentially a different polis.

The `format` field tells the client how to render: `"md"` for markdown, `"html"` for HTML + CSS.

### Examples

A simple markdown post:

```
posts/
  2026-03-08-hello/
    post.json
    index.md
```

A rich HTML + CSS post with custom styling and images:

```
posts/
  2026-03-08-why-i-love-rust/
    post.json
    index.html
    style.css
    hero.png
    diagram.svg
```

### Rendering Pipeline

1. Client reads `post.json` for metadata and routing.
2. If `format: "md"` → render markdown to HTML → display.
3. If `format: "html"` → render HTML + CSS in sandbox (JS disabled) → display.
4. Both end up as HTML in the render layer. Markdown is a convenient shorthand for simple HTML.

### Authoring

Most people will write markdown. Power users will write HTML + CSS. The Achaean client can provide a visual editor — drag and drop blocks, pick colors, choose layouts — that generates HTML + CSS under the hood. LLMs can generate either format. But the output is always just files in a git repo.

---

## Repo Structure

Everything lives in the polites's git repo. One repo per person.

```
my-repo/
  .well-known/
    koinon.json               # discovery manifest
  identity/
    pubkey.json               # your public key (Web Crypto)
  posts/
    2026-03-08-hello/
      post.json               # metadata, signature, polis tags
      index.md                # simple markdown post
    2026-03-08-fancy-essay/
      post.json
      index.html              # rich HTML + CSS post
      style.css
      hero.png
  trust/
    alice.json                # trust declaration (individual, not polis-scoped)
    bob.json
  poleis/
    <polis-repo-id>/
      signature.json          # your signature of the current README
  feed.xml                    # RSS feed
```

### Trust Declaration Format

```json
{
  "type": "trust-declaration",
  "subject": "<their-public-key>",
  "level": "TRUST",
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

### README Signature Format

```json
{
  "type": "readme-signature",
  "polis": "<polis-repo-id>",
  "readme_commit": "<commit-hash-of-readme-version>",
  "readme_hash": "<content-hash-of-readme>",
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

---

## Discovery via `.well-known`

The `.well-known/koinon.json` file is a directory inside the git repo — not a web domain endpoint. No domain or hosting required. It sits in the repo alongside `posts/` and `trust/`, and is auto-generated by the client. The indexer finds it by searching forges for repos containing this file path, or by following trust graph links between repos.

Optionally, a polites with their own domain can also host `https://theirdomain.com/.well-known/koinon.json` pointing to their repo — useful for verification and vanity, but not required.

Every polites's repo hosts a `.well-known/koinon.json` manifest:

```json
{
  "protocol": "koinon",
  "version": "1.0",
  "pubkey": "<web-crypto-public-key>",
  "repo_radicle": "rad:z3gqcJ...",
  "repo_https": "https://github.com/alice/my-repo",
  "poleis": [
    {
      "repo": "<polis-repo-id>",
      "name": "Linux Shitposters",
      "stars": 47,
      "role": "TRUST"
    }
  ],
  "trust_index": "/trust/index.json"
}
```

### Discovery Layers

**Onboarding discovery (how new users find Koinon):**

1. **Crossposting** — the primary growth engine. Koinon posts crossposted to Nostr/Bluesky/Mastodon link back to the source. People discover the network through content they already see on other platforms.
2. **Forge search** — repos live on GitHub/Codeberg, so they're searchable by anyone with a browser. Zero-friction early discovery with no extra infrastructure.
3. **The Koinon Index** — a lightweight crawler/search engine that indexes `koinon.json` manifests across the network. Seeded by forge search (query for repos containing `.well-known/koinon.json`), then follows the trust graph to discover more repos. Serves a search API and browse UI for finding poleis by topic, size, and activity. Cheap to run — small JSON manifests over HTTPS, SQLite index, single VPS. Anyone can run a competing indexer since all the data is public and the manifest format is standardized.

**In-network discovery (once you're in):**

4. **Trust graph navigation** — discover poleis through people you already trust. The strongest mechanism once you have connections.
5. **Radicle gossip** — nodes tell each other about repos.
6. **RSS** — subscribe to trusted politai, discover their poleis through their activity.

---

## Integrity, Lying, and Sybil Resistance

Lying is mostly useless because the trust graph is multi-party. You can rewrite your repo but you can't rewrite other people's. Every interesting claim requires corroboration. Signed commits provide tamper evidence. Clients flag suspicious re-signed history.

### Sybil Resistance

The trust graph is the sybil defense. Creating 50 fake keypairs is easy. Getting real members to independently grant mutual `TRUST` to all of them is not — each trust decision is a human social judgment. Sock puppets that nobody has interacted with get stuck at `PROVISIONAL` or `No Trust` permanently.

Vouching has social cost. If someone vouches for 50 strangers nobody recognizes, it reflects on the voucher. Other members notice. Trust in the voucher erodes. The attack burns the attacker's social capital.

The membership threshold is the tuning knob. A polis with a threshold of 1 is easy to game. A polis with a threshold of 5 requires a sybil to fool five independent people. If a polis is getting gamed, it forks with a higher threshold. Social problem, social solution.

This mirrors how real communities work. You cannot fake being 50 different people that everyone personally knows.

---

## Content Accountability and Moderation

### Ownership Solves Moderation

Every piece of content is signed and hosted in the author's own repo. You signed it. It's yours.

**Illegal content** — cryptographically signed evidence in your own repo.
**Bad actors** — trust revoked → content vanishes from every agora.
**Subjective moderation** — on-device AI. You decide what you see.

### Why This Avoids the Fediverse CSAM Problem

Federated platforms automatically replicate content across servers. Koinon is pull-based. Content lives in the author's repo only. The agora just points to it. Nobody unknowingly hosts anyone else's content.

### No Protocol-Level Moderation

The protocol has no moderation layer. Content is signed (cryptographic accountability). Hosting providers have existing legal obligations. Community moderation is the trust graph. Subjective moderation is on-device.

---

## Visibility: Public or Encrypted

Every polis is either **public** or **encrypted**. There is no middle ground. The README declares which.

### Public Poleis (Default)

Your repo, trust graph, and posts are public. Transparency is what makes the trust graph work. Most poleis are public.

### Encrypted Poleis

For communities that need privacy, a polis can declare itself encrypted. Content is readable only by current trusted members.

**How it works — envelope encryption:**

Each post is encrypted using a random **per-post AES content key**. The content files (`index.md`, `index.html`, assets) are encrypted with this key. Then the AES key itself is encrypted once per trusted member using their public key (RSA/ECDH). The result is one encrypted content blob plus N tiny encrypted copies of the content key — one per member.

```
posts/
  2026-03-08-private-update/
    post.json                   # metadata (unencrypted — polis tag, timestamp, signature)
    keys.json                   # per-member encrypted content keys
    content.enc                 # AES-encrypted content blob
```

**`keys.json`:**

```json
{
  "algorithm": "AES-GCM-256",
  "recipients": {
    "<alice-public-key>": "<AES-key-encrypted-with-alice-pubkey>",
    "<bob-public-key>": "<AES-key-encrypted-with-bob-pubkey>"
  }
}
```

**Why per-post, not per-polis keys:**

- When a member loses trust, nothing needs to be re-keyed. They simply stop appearing in `recipients` for new posts.
- Old posts they could already read remain readable — revoking access to ciphertext they already decrypted is security theater.
- Each post is a self-contained encrypted unit. No shared secret to leak or rotate.

**The polis still holds no keys.** Encryption is author-to-recipients. The author encrypts to the current trusted member set at time of posting. Sovereignty is preserved — the polis is not an actor, even in encrypted mode.

**Trust graph remains public.** Even in encrypted poleis, trust declarations and the README are unencrypted. Who trusts whom is visible. Only content is encrypted. This is necessary — membership must be computable by anyone for the protocol to work.

For truly private one-to-one or small-group conversations, use Signal, Matrix, etc. Encrypted poleis are for community-scoped privacy, not secret channels.

---

## Achaean: The Reference Implementation

### The Stack

- **Web Crypto API** — identity and signing. Browser-native.
- **Git** — the canonical data format. Content storage, history, hash-linking, forking. Git is the protocol's substrate, but the client never runs git directly. The Flutter app talks to git forges via their HTTPS/REST APIs (GitHub, Codeberg, Gitea) and to Radicle via its HTTP API. All git operations — commits, pushes, file reads — happen through API calls. No git binary on the device.
- **Radicle + Git Forges (dual mode)** — P2P hosting AND traditional forge hosting simultaneously.
- **RSS** — the notification layer. Each polites's repo contains a `feed.xml` that advertises new posts and trust changes. RSS doesn't contain content — it points to it. Aggregators and other clients subscribe to feeds to know when something changed, then fetch the actual content (markdown or HTML+CSS post directories) via forge APIs. RSS is forge-agnostic, trivial to generate (templated from `post.json` metadata), and means aggregators never need to understand specific forge APIs — they just subscribe to feeds. Regenerated on every push.
- **Gemma (or similar) on-device** — client-side moderation.

### Dual-Mode Hosting

Repos live on both Radicle's P2P network and a traditional git forge simultaneously.

- **Radicle** — P2P, fully sovereign. Discovery via gossip. No central dependency.
- **Forge** — easy HTTPS access, web UI, familiar on-ramp. GitHub, Codeberg, Gitea.

Push to both. If one fails, the other works. The protocol doesn't care where the repo lives.

### The Client

A Flutter app (cross-platform, mobile + desktop). The user sees a social media app.

| Action | What the user sees | What happens under the hood |
|---|---|---|
| Create account | "Welcome. You're in." | Keypair generated, repo initialized, published to Radicle + forge |
| Join polis | "Request sent." | README committed, waiting for vouch |
| Trust someone | A follow/friend button | Trust declaration committed |
| Vouch | "You vouched for Alice." | PROVISIONAL trust declaration committed |
| Revoke trust | An unfriend button | Trust file deleted, committed |
| Post (simple) | A markdown editor | Signed post directory committed, RSS regenerated, pushed |
| Post (rich) | A visual editor / HTML+CSS | Rich post directory with custom layout committed, pushed |
| Fork polis | "New polis created." | New README with parent pointer committed |
| Read feed | A filtered, personalized feed | Agora fetched from aggregator API, content rendered, optionally filtered by on-device preferences |
| Discover poleis | Browse/search page | Aggregator search API + trust graph navigation |

### Interoperability via Crossposting

Git repo is canonical. Git hook crossposts on every push:

- **Nostr** — sign as Nostr event.
- **Bluesky** — create AT Protocol record.
- **Mastodon** — POST to ActivityPub outbox.
- **RSS** — already handled.

Reverse bridges can pull replies back. But that's an optimization.

---

## Scaling

The protocol is simple. Scaling it requires optional infrastructure on top — the same way HTTP is simple but the web at scale requires CDNs, caches, and search engines.

### Where the Bottlenecks Are

**Individual operations are cheap.** A trust declaration is a few hundred bytes. A post is a small directory. A reply reference is a hash. Git is extremely efficient at storing and diffing small files.

**Computing the agora is expensive.** To build the feed for a large polis, a naive client would need to fetch many repos, walk trust directories, verify mutual trust, collect tagged posts, and resolve reply chains across repos.

### Server-Side Agora Computation

The agora is always computed server-side by the aggregator. The client never computes the trust graph — it fetches pre-computed agoras from the aggregator API. This avoids duplicating graph computation logic in both client and server, and keeps the Flutter client thin: keypair management, posting to forge APIs, rendering content, calling the aggregator for feeds.

The protocol still guarantees that anyone *could* independently verify the agora — all trust declarations and content are public. But in practice, the aggregator does the work.

### The Aggregator

A Go service with two responsibilities: **discovery** (indexing poleis and politai for search) and **computation** (building agoras from the trust graph).

**Architecture:**

- **RSS subscriber** — discovers polites repos (via forge search or trust graph traversal), subscribes to their `feed.xml`. Processes updates only when something changes. The only expensive job is finding new repos to subscribe to — everything after that is listening.
- **Graph database** — stores the trust graph and computes membership/agoras. LadybugDB (embedded, columnar, Cypher queries, zero ops) is the default. The DB sits behind a Go interface (`GraphStore`) so it can be swapped to Postgres + Apache AGE or any other backend without changing the aggregator logic.
- **REST API** — serves pre-computed agoras, polis search, polites lookup, membership data to the Flutter client.

**The `GraphStore` interface:**

```go
type GraphStore interface {
    UpsertPolis(polis Polis) error
    GetPolis(readmeHash string) (*Polis, error)
    SearchPoleis(query string) ([]Polis, error)
    UpsertPolites(polites Polites) error
    GetPolites(pubkey string) (*Polites, error)
    SetTrust(from, to string, level TrustLevel) error
    RevokeTrust(from, to string) error
    GetMembers(polisHash string, threshold int) ([]Polites, error)
    ComputeAgora(polisHash string) ([]Post, error)
    AddFeed(pubkey string, feedURL string) error
    GetStaleFeeds(since time.Time) ([]Feed, error)
}
```

Start with `LadybugStore`. If LadybugDB doesn't hold up, write a `PostgresAGEStore`. The aggregator never knows the difference.

**Anyone can run an aggregator.** All the data is public. Multiple competing aggregators can exist for the same polis. The client can be configured to use any aggregator, or compare results across multiple. No lock-in.

### Scaling Tiers

**Early (free tier):** Single aggregator instance, LadybugDB embedded, GitHub Actions cron for initial repo discovery.

**Medium ($5-20/mo VPS):** Persistent aggregator service, real-time RSS processing, serves API to clients.

**Large (real infrastructure):** Postgres + AGE, multiple aggregator instances, sharded by trust graph regions, CDN in front of the API.

### What Makes This Tractable

**`.well-known/koinon.json`** — aggregators don't need to clone full repos. They poll lightweight manifests, check for changes, fetch only what's new.

**RSS feeds** — this is what makes the indexer scalable. The crawler doesn't poll — it subscribes. Once it discovers a polites's repo, it subscribes to their `feed.xml` and only processes updates when something changes. Most checks are a single `If-Modified-Since` header with zero bandwidth. The crawler's only expensive job is discovering new repos to subscribe to. Everything after that is listening. RSS turns polling into subscription — a solved problem at any scale.

**Immutable commit hashes** — reply threads and content references are pinned to commit hashes. Once resolved, they can be cached permanently. Thread structure can't change retroactively.

**The agora is deterministic** — given the same trust graph and tagged content, any client or aggregator computes the same agora. Results are independently verifiable.

This is the same tradeoff the web made. HTTP is simple. At scale you need CDNs, caches, and search engines. Those are infrastructure on top of the protocol, not changes to the protocol. Koinon stays pure. Scaling is an infrastructure concern.

---

## Design Principles

1. **The protocol does not enforce. It mirrors.** Trust relationships exist between humans. Koinon makes them machine-readable.
2. **Sovereignty is non-negotiable.** Your keypair. Your repo. Your content. Your layout.
3. **Poleis are not actors.** Emergent patterns, not entities.
4. **Content is owned.** Every post is signed. Accountability is cryptographic.
5. **Content is expressive.** Your post, your design. Markdown for simplicity, HTML + CSS for full creative control. No cookie-cutter templates.
6. **Forking is a feature.** Poleis split. History carries forward.
7. **Moderation is personal.** The protocol doesn't moderate. People do.
8. **Public or encrypted.** Poleis are either fully public or envelope-encrypted to members. No middle ground.
9. **Simplicity is strength.** Four primitives. Three trust states. Everything else is emergent.
10. **No central dependencies.** Dual-mode hosting. No single point of failure.
11. **Lying is futile.** Multi-party trust graph. Signed commits. Tamper evidence.
12. **Scale is infrastructure, not protocol.** The protocol stays simple. Aggregators, caches, and indexers are optional layers anyone can provide.

---

## Open Questions

- **On-device model requirements** — minimum viable model, fallback for low-power devices
- **Large media** — git + large binaries. Git LFS? External hosting with hash references?
- **Reverse bridges** — pulling replies from other networks back into the agora
- **`.well-known` standardization** — exact schema, update frequency
- **Post templates** — shareable layout templates for non-technical users
- **Visual editor** — WYSIWYG post editor that generates HTML + CSS
- **Aggregator API spec** — exact REST endpoints, response formats, pagination

---

*This document is version 3.0 of the Koinon Protocol specification. Achaean is the first implementation. This is itself a README. Fork it freely.*
