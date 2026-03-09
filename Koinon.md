# The Koinon Protocol

## A protocol for sovereign identity, voluntary community, and client-side moderation.

*Koinon (Greek: κοινόν, "the common thing") was the word the ancient Greeks used for their confederacies — voluntary leagues of sovereign city-states. The Achaean League (5th century BC — 146 BC) was the most successful of these, balancing collective action with local autonomy. Through the writings of the Achaean statesman Polybius, this structure influenced the constitution of the United States and other modern federal states.*

---

## Terminology

| Term | Meaning |
|---|---|
| **Koinon** | The protocol. The shared specification that defines how identity, trust, communities, and content work. |
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

A signed file: author keypair, subject keypair, subject repo URL, trust level (`TRUST` or `PROVISIONAL`). Trust is between individuals — not scoped to any polis. Poleis compute membership from the global trust graph. Revocable by deletion. The repo URL enables trust graph traversal — aggregators follow these links to discover repos on any forge.

### 3. README Signature

A signed file in the polites's own repo: the README content (or its hash), the polis repo ID, the README commit hash, and the polites's signature. This is the act of cosigning the social contract. Signatures are decentralized — scattered across member repos — and assembled by the aggregator.

### 4. Membership Function

Computed, not stored. Member = signed the current README version + mutual `TRUST` declarations (from the global trust graph) with N other signers (N = threshold). The agora is also computed from this. Trust exists between individuals independent of any polis; poleis are just lenses that filter the trust graph by who has signed their README.

---

## Post Format

### JSON Is Canonical

Every post starts as structured JSON — a normalized, layered schema that covers every text-based social platform (microblogging, link aggregation, forums, Q&A, polls, events, classifieds, code sharing, and more) with one format. No `type` field — the client inspects which fields are present and renders accordingly.

The full schema is defined in **[PostSchema.md](PostSchema.md)** — two schemas (Post and Reply), five layers (content, routing, details, crosspost, presentation). A tweet, a Reddit link share, a classified listing, and a poll are all the same schema with different fields filled in.

The commit hash in reply references is immutable. Even if the original author edits or deletes their post, your reply still points to the exact version you were responding to. Git gives you receipts for free. Threading is just a linked list of signed files across repos. Cross-polis replies work naturally.

### The Pipeline

```
User input → JSON (canonical, stored in repo, signed)
                ↓                          ↓
        Crosspost bridges          Optional: presentation hook
        (Nostr, Bluesky,           (JSON → HTML+CSS
         Mastodon, RSS)             for rich agora display)
```

Presentation, rendering rules, media constraints, and examples are all in **[PostSchema.md](PostSchema.md)**.

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
  "repo": "<their-repo-url>",
  "level": "TRUST",
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<your-web-crypto-signature>"
}
```

The `repo` field is how trust graph traversal discovers new repos. When an aggregator indexes a trust declaration, it follows the repo URL to discover the subject's repo — even on self-hosted forges it has never seen before.

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
3. **The Koinon Index** — a lightweight crawler/search engine that indexes `koinon.json` manifests across the network. Seeded by forge search (query for repos containing `.well-known/koinon.json`), then follows the trust graph to discover more repos. Serves a search API and browse UI for finding poleis by topic, size, and activity. Cheap to run — small JSON manifests over HTTPS, Postgres index, single VPS. Anyone can run a competing indexer since all the data is public and the manifest format is standardized.

**In-network discovery (once you're in):**

4. **Trust graph traversal** — the aggregator follows repo URLs in trust declarations to discover new repos automatically. If Alice (on GitHub) trusts Bob (on self-hosted Forgejo), Alice's trust declaration contains Bob's repo URL. The aggregator follows the link, discovers Bob's repo, subscribes to his RSS feed. One trust link bridges the gap to any forge, anywhere.
5. **Manual registration** — the aggregator exposes a registration endpoint: `POST /register` with `{ "repo": "<repo-url>" }`. A self-hosted user (or their client, automatically on account setup) hits it once. The aggregator fetches their `.well-known/koinon.json`, subscribes to their RSS, and they're in the index. This is the bootstrap for the first user on a forge that nobody has linked to yet.
6. **Radicle gossip** — nodes tell each other about repos.
7. **RSS** — subscribe to trusted politai, discover their poleis through their activity.

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

Federated platforms automatically replicate content across servers. Koinon is pull-based. Content lives in the author's repo only — the aggregator index stores only metadata references, never content. The agora is a list of pointers. Nobody unknowingly hosts anyone else's content. The forge hosting the repo has existing legal obligations and reporting mechanisms. Trust revocation instantly removes all references from every agora.

### No Protocol-Level Moderation

The protocol has no moderation layer. Content is signed (cryptographic accountability). Hosting providers have existing legal obligations. Community moderation is the trust graph. Subjective moderation is on-device.

---

## Visibility

All poleis are **public**. Your repo, trust graph, and posts are public. Transparency is what makes the trust graph work — membership must be computable by anyone for the protocol to function.

For private conversations, use Signal, Matrix, etc. Koinon is for public communities. Encrypted poleis may be added in a future protocol version if there's demand, but they add significant complexity (envelope encryption, key distribution, member rotation) and are not needed for v1.

---

## Design Principles

1. **The protocol does not enforce. It mirrors.** Trust relationships exist between humans. Koinon makes them machine-readable.
2. **Sovereignty is non-negotiable.** Your keypair. Your repo. Your content. Your layout.
3. **Poleis are not actors.** Emergent patterns, not entities.
4. **Content is owned.** Every post is signed. Accountability is cryptographic.
5. **Content is expressive.** Your post, your design. HTML + CSS for full creative control. No cookie-cutter templates.
6. **Forking is a feature.** Poleis split. History carries forward.
7. **Moderation is personal.** The protocol doesn't moderate. People do.
8. **Public by default.** Transparency is what makes the trust graph work. Private comms go elsewhere.
9. **Simplicity is strength.** Four primitives. Three trust states. Everything else is emergent.
10. **No central dependencies.** No single point of failure.
11. **Lying is futile.** Multi-party trust graph. Signed commits. Tamper evidence.
12. **Scale is infrastructure, not protocol.** The protocol stays simple. Aggregators, caches, and indexers are optional layers anyone can provide.

---

## Open Questions

- **Agora sorting** — how does the aggregator sort/rank content? Chronological, reply count, trust-weighted signals? Per-polis configuration?
- **Reverse bridges** — pulling replies from other networks back into the agora
- **`.well-known` standardization** — exact schema, update frequency

---

*This document is version 4.0 of the Koinon Protocol specification. The first implementation is [Achaean](Achaean.md). This is itself a README. Fork it freely.*
