# Achaean

The first reference implementation of the [Koinon Protocol](Koinon.md) — a protocol for sovereign identity, voluntary community, and trust-based social networking.

## What is this?

Achaean is a social platform where communities are trust-gated, not moderation-gated. There are no admin ban hammers, no content moderation queues, no spam filters — because the architecture makes them unnecessary. You only see content from people your community trusts.

- **Identity** is a cryptographic keypair you own
- **Content** lives in your git repo, not on a server
- **Communities** (poleis) are defined by a shared social contract (a signed README)
- **Membership** is computed from mutual trust relationships
- **The server** is a metadata index — it never stores or serves content

## Terminology

| Term | Meaning |
|---|---|
| **Koinon** | The protocol — the shared specification for identity, trust, communities, and content |
| **Polis** (pl. poleis) | A community — a voluntary group bound by a signed social contract (README) and mutual trust |
| **Polites** (pl. politai) | A citizen — a user identified by their cryptographic keypair |
| **Agora** | The community feed — computed from trusted members' posts |
| **Synedrion** | The index/computation layer — gathers trust declarations, computes membership, serves agora feeds. Has no authority over data; anyone can run one |
| **Archeion** | The archive/storage layer — the git forge where user repos live (Forgejo, GitHub, Codeberg, Radicle) |

## How is this different?

| | Identity | Data storage | Moderation | Community model |
|---|---|---|---|---|
| **Lemmy / Mastodon** | Server owns it | Server | Server admins (reactive banning) | Server = community |
| **Bluesky** | DID (portable) | Personal repo (PDS) | Labeling services (centralized in practice) | Follows-based feed |
| **Nostr** | Keypair | Relays (multiple copies) | Relay operators / client-side filtering | No community primitive |
| **Koinon** | Keypair | Git repo (you own it) | Trust graph (structural — bad actors can't enter) | Polis: signed social contract + mutual trust |

### vs. Lemmy / Mastodon (ActivityPub)

ActivityPub communities rely on server admins to moderate. This puts a real burden on volunteers — especially at scale, where federated harassment and content moderation become an ongoing time commitment. Koinon removes that role entirely by making community boundaries structural.

### vs. Bluesky (AT Protocol)

Bluesky introduced great ideas — user-owned data repos, portable identity, a separate aggregation layer. Koinon shares those instincts but goes further on the trust model. Where Bluesky uses centralized labeling services for moderation, Koinon computes community membership from the trust graph itself.

### vs. Nostr

Nostr shares Koinon's keypair identity and "no server owns your stuff" philosophy. The difference is community structure — Nostr is a global event stream without a built-in community primitive. Koinon adds that layer: trust-gated groups with computed membership.

### What Koinon does differently

Communities are trust-gated — membership requires mutual trust relationships above a threshold. This means:

- **Harassment from strangers?** They're not in the trust graph, they don't exist in your agora.
- **Alt-account flooding?** No trust edges = invisible.
- **CSAM on the server?** Server never stores content.
- **Admin burnout?** There's almost nothing to moderate.

The protocol has five primitives (README, trust declaration, README signature, flag, membership function) and three trust states (none, provisional, mutual). Flags let any member signal that a post violates the social contract — it's a signed declaration in your own repo, not an admin action. When enough trusted members flag the same content, it's community consensus, not top-down censorship. Everything else — moderation, governance, community boundaries — is emergent from those primitives.

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Flutter    │     │  Synedrion   │     │   Archeion   │
│   Client     │────▶│  (indexer)   │────▶│  (git forge) │
│              │     │              │     │              │
│ - keypair    │     │ - trust graph│     │ - user repos │
│ - local copy │     │ - membership │     │ - posts      │
│ - post/read  │     │ - post refs  │     │ - trust decl │
│ - trust mgmt │     │ - agora feed │     │ - signatures │
└─────────────┘     └─────────────┘     └─────────────┘
      │                                        ▲
      └────────── fetches content directly ────┘
```

Three independent layers, intentionally decoupled:
- **Archeion** (Forgejo) — git forge hosting user repos. Replaceable with GitHub, Codeberg, Gitea, or Radicle.
- **Synedrion** (Serverpod) — indexes trust declarations, computes membership, serves agora feeds. Never touches content.
- **Client** (Flutter) — cross-platform app. Holds your keypair, maintains a local copy of your repo, fetches content directly from authors' archeions.

## Tech stack

Dart top-to-bottom. Shared models between client and server.

- **Client:** Flutter, Cubit + GetIt, GoRouter
- **Server:** Serverpod (Dart backend with type-safe RPC)
- **Database:** PostgreSQL + Apache AGE (relational + graph queries in one DB)
- **Identity:** ECDSA P-256 keypairs, platform keychain storage
- **Git:** Pure Dart Forgejo/git client (no git binary required)

## Project structure

```
achaean/
├── achaean_flutter/    # Flutter client app
├── achaean_server/     # Serverpod backend
├── achaean_client/     # Generated Serverpod client
├── dart_koinon/        # Koinon protocol models & utilities
├── dart_git/           # Pure Dart Forgejo API client
├── Koinon.md           # Protocol specification
├── Achaean.md          # Implementation design
├── Plan.md             # Phased build plan
└── PostSchema.md       # Post JSON schema
```

## License

Copyright 2026 Qtpi Bonding LLC. Dual-licensed:

- **Code** (Achaean implementation): [AGPL-3.0](LICENSE)
- **Protocol spec & documentation** (Koinon.md, PostSchema.md, docs/): [CC-BY-SA-4.0](LICENSE-docs)

Anyone can implement the Koinon protocol. If you modify and deploy the Achaean server code, you must open-source your changes.
