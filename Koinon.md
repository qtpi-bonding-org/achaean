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
- A polis is a **signed versioned document (the README)**, identified by its hash, bound to a **web of mutual trust**.
- Membership is the intersection of: having signed the README, and having mutual trust relationships with other signers above the polis's defined threshold.
- No one is trapped. No one is owned. Membership is always voluntary. Exit is always free.

### 3. Client-Side Moderation

- Subjective content moderation happens **on-device**, not on the server.
- Users run a local model (e.g., Gemma) that filters content according to their personal preferences.
- Everything — politics, NSFW, opinions, vibes — is the user's choice to see or not see.

---

## Mental Model

**Politai are git repos.** Each polites has a signed log of their content — posts, messages, media. Signed by their Web Crypto keypair. This is theirs forever.

**Poleis are git repos of pointers.** A polis is a README document (identified by its hash) plus a manifest of references to polites content. The manifest is not signed by the polis (poleis don't sign things). It is **computed** by any client from the trust graph: collect all content that trusted politai have tagged for this polis.

**Forks are just new READMEs.** A polites writes a new README pointing to the old one as its parent. People follow or they don't. The new fork inherits the old agora by default (minus any exclusions). No permission needed. No vote required.

### Community Health: Two Numbers

**Stars** = how many individual keypairs have active trust declarations pointing at this README hash. **Breadth.**

**Edges** = how many mutual trust relationships exist between members within the polis. **Depth.**

- High stars, low edges → loose audience, broadcast polis, public forum.
- High edges relative to stars → tight-knit crew, everyone knows each other.
- Fork health: high stars but low edges is fragile. High edges means cohesive.

---

## Polis Structure

### The README

A polis is defined by a signed, versioned document — the README, identified by its content hash. It contains:

- **What the polis is about** — could be a paragraph, a manifesto, or just "shitposting about linux."
- **Norms and expectations** — social conventions, not enforced rules.
- **Membership threshold** — how many mutual trust links are required for full membership.
- **Parent pointer** — the hash of the README this was forked from (null for genesis).
- **Optional metadata** — recommended client-side moderation defaults, founding signers, etc.

The README is signed by its author. It is a social contract. The polis's identity IS the README hash.

### The Agora (Computed, Not Signed)

The agora is computed by any client from two inputs:

1. **The trust graph** — who is a trusted member of this polis?
2. **Tagged content** — what content have those trusted politai tagged for this polis?

No central authority maintains it. The agora is emergent.

### The Web of Trust

Three trust states:

| State | Meaning |
|---|---|
| **No Trust** | Default. You are unknown to this polis. |
| **Provisional** | Someone has vouched for you. You can participate but cannot vouch for others. |
| **Trust** | Full mutual trust. You are a member. You can vouch for new provisional members. Revocable at any time. |

A trust declaration is a three-way binding: **I trust this polites, with respect to this polis (README hash), and all trusted politai must mutually trust each other.**

#### How membership works:

- Everyone starts at **No Trust**.
- An existing trusted polites vouches for you → **Provisional**.
- Existing members independently decide to upgrade you to **Trust**.
- Mutual trust links meeting the README's threshold → **full member**.
- Trust revoked, below threshold → out. No one banned you. You stopped being trusted.

#### Accountability:

Vouching has social cost. Vouch for a bad actor, it reflects on you.

### Forking

No consensus process. As free as forking a repo.

- **Anyone can fork at any time for any reason.**
- To fork: new README, parent pointer to old hash, sign it, publish.
- The "real" polis is whichever fork the trust graph follows. Dead forks wither.

Bad actors: the polis forks. The bad actor is left behind. They can't meet the membership threshold in the new fork because no one trusts them.

### History Continuity

Forks inherit the entire old agora by default. The fork specifies an exclusion list — specific content or author keypairs to drop. The default is to keep everything. Full version history visible like `git log`.

---

## Protocol Primitives

The Koinon protocol defines three primitives:

### 1. Polis Document (README)

A signed, versioned document: content hash (the polis identity), parent pointer, membership threshold, exclusion list, author signature, optional metadata.

### 2. Trust Declaration

A signed file: author keypair, subject keypair, README hash (three-way binding), trust level (`TRUST` or `PROVISIONAL`). Revocable by deletion.

### 3. Membership Function

Computed, not stored. Member = signed the README + mutual `TRUST` declarations with N other signers (N = threshold). The agora is also computed from this.

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
  "poleis": ["<readme-hash>"],
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

For replies, the `reply_to` field pins the reply to an exact version of the parent post via its git commit hash:

```json
{
  "type": "post",
  "format": "md",
  "poleis": ["<readme-hash>"],
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
    <polis-hash>/
      alice.json              # trust declaration
      bob.json
  poleis/
    <polis-hash>.json         # README you've signed
  feed.xml                    # RSS feed
```

### Trust Declaration Format

```json
{
  "type": "trust-declaration",
  "subject": "<their-public-key>",
  "polis": "<readme-hash>",
  "level": "TRUST",
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

---

## Discovery via `.well-known`

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
      "readme_hash": "<hash>",
      "name": "Linux Shitposters",
      "stars": 47,
      "role": "TRUST"
    }
  ],
  "trust_index": "/trust/index.json"
}
```

### Discovery Layers

1. **`.well-known` crawling** — bots index `koinon.json` manifests. Fast, lightweight, cacheable.
2. **Radicle gossip** — nodes tell each other about repos.
3. **Trust graph navigation** — discover poleis through trusted politai's declarations.
4. **Crossposting** — content mirrored to Nostr/Bluesky/Mastodon brings people back.
5. **Forge search** — GitHub/Codeberg search works natively.
6. **Directory sites** — anyone can build a search engine for the network.

---

## Integrity and Lying

Lying is mostly useless because the trust graph is multi-party. You can rewrite your repo but you can't rewrite other people's. Every interesting claim requires corroboration. Signed commits provide tamper evidence. Clients flag suspicious re-signed history.

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

## Public by Default

This protocol is public. Your repo, trust graph, and posts are public. Transparency is what makes the trust graph work.

For private conversations, use Signal, Matrix, etc. Koinon is for public discourse.

---

## Achaean: The Reference Implementation

### The Stack

- **Web Crypto API** — identity and signing. Browser-native.
- **Git** — content storage, history, hash-linking, forking.
- **Radicle + Git Forges (dual mode)** — P2P hosting AND traditional forge hosting simultaneously.
- **RSS** — subscription and content distribution. Pull-based.
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
| Read feed | A filtered, personalized feed | Content fetched, agora computed, filtered through Gemma |
| Discover poleis | Browse/search page | `.well-known` + gossip + trust graph + directories |

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

### Tiered Scaling

**Tier 1: Small poleis (under ~100 members)** — the client computes the agora directly. Fetch repos, build graph, done. No extra infrastructure needed.

**Tier 2: Medium poleis (100–10,000)** — optional aggregator services. Someone runs a crawler that watches member repos via RSS feeds, incrementally updates a cached agora, and serves it. Any polites can run an aggregator. Multiple competing aggregators can exist for the same polis. The client can verify the aggregator's output against raw repos. Trust but verify.

**Tier 3: Large poleis (10,000+)** — dedicated indexing services. Still an opt-in optimization, not a protocol requirement. The protocol stays "repos + trust + computed agora." The indexer pre-computes what any client could compute on its own.

### What Makes This Tractable

**`.well-known/koinon.json`** — aggregators don't need to clone full repos. They poll lightweight manifests, check for changes, fetch only what's new.

**RSS feeds** — aggregators subscribe to member feeds. New posts or trust changes trigger feed updates. No full re-crawl needed.

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
8. **Public by default.** Private tools for private things.
9. **Simplicity is strength.** Three primitives. Three trust states. Everything else is emergent.
10. **No central dependencies.** Dual-mode hosting. No single point of failure.
11. **Lying is futile.** Multi-party trust graph. Signed commits. Tamper evidence.
12. **Scale is infrastructure, not protocol.** The protocol stays simple. Aggregators, caches, and indexers are optional layers anyone can provide.

---

## Open Questions

- **Cross-polis trust** — does trust in one polis carry weight in another?
- **On-device model requirements** — minimum viable model, fallback for low-power devices
- **Large media** — git + large binaries. Git LFS? External hosting with hash references?
- **Reverse bridges** — pulling replies from other networks back into the agora
- **`.well-known` standardization** — exact schema, update frequency
- **Post templates** — shareable layout templates for non-technical users
- **Visual editor** — WYSIWYG post editor that generates HTML + CSS
- **Aggregator protocol** — standard API for aggregator services to serve pre-computed agoras

---

*This document is version 2.3 of the Koinon Protocol specification. Achaean is the first implementation. This is itself a README. Fork it freely.*
