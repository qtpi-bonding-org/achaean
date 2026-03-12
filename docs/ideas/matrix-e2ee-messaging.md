# Matrix E2EE Messaging

## Idea

Add encrypted direct messaging and polis group chat using Matrix (Synapse/Conduit) as the transport layer, embedded in the Flutter client via `matrix_dart_sdk`.

## Why

Achaean has public posts (agora) but no private communication. Users need:
- 1:1 encrypted DMs between politai
- Private group chat within a polis
- A messaging system that matches achaean's decentralization philosophy

Matrix provides E2EE, federation, and room management out of the box.

## Identity Bridging: Matrix ID ↔ Koinon Keypair

The core problem: achaean identifies users by ECDSA P-256 public key, Matrix identifies users by `@user:server`. How to link them trustlessly?

### Approach: Signed claim in the koinon manifest

The user's koinon manifest (which lives in their git repo, signed by their keypair) declares their Matrix ID:

```json
{
  "matrix": "@alice:polis.example.org"
}
```

Because the manifest is signed, anyone can verify that the owner of public key `X` claims to be `@alice:polis.example.org`.

For the reverse direction (proving the Matrix account is owned by the same person), the user's client sets a **room state event** in each polis room they join:

```json
{
  "type": "org.koinon.identity",
  "state_key": "@alice:polis.example.org",
  "content": {
    "pubkey": "<achaean-public-key>",
    "signature": "<sign('@alice:polis.example.org', private_key)>"
  }
}
```

Why a room state event and not account data? Matrix account data is **private to the user** — other users cannot read it through the API. Room state events are visible to all room members, so any polis member can verify the binding.

Now the binding is bidirectional and trustless:
1. Manifest says pubkey `X` → `@alice:server` (verified by git signature)
2. Room state event says `@alice:server` → pubkey `X` (verified by checking the ECDSA signature)

Neither direction requires trusting any server. The client verifies both signatures locally. The state event is set once per room join — the client does it automatically.

### Why not simpler approaches?

| Approach | Problem |
|---|---|
| Just put Matrix ID in manifest, no reverse proof | Anyone could claim to be `@alice:server` in their manifest |
| Use Matrix display name | Display names aren't verified, can be changed |
| Server-side linking | Requires trusting the server, breaks decentralization |
| Derive Matrix ID from keypair | Locks users into one Matrix server, no migration |

## Architecture

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Flutter    │     │  Synedrion   │     │   Matrix     │
│   Client     │     │  (indexer)   │     │  (Synapse/   │
│              │     │              │     │   Conduit)   │
│ - posts      │     │ - trust graph│     │ - E2EE DMs  │
│ - trust mgmt │     │ - membership │     │ - polis rooms│
│ - messaging  │────▶│ - agora feed │     │ - federation │
│   (matrix    │     └─────────────┘     │              │
│    dart sdk) │─────────────────────────▶│              │
└─────────────┘                          └─────────────┘
```

The client talks to both Synedrion (for posts/trust/membership) and Matrix (for messaging). They share identity through the signed claim mechanism.

## Polis Rooms

Each polis could have an auto-created Matrix room:
- Room membership mirrors polis membership (computed from trust graph)
- When someone gains/loses membership, the client (or a bot) updates the room
- Room is encrypted by default
- Room ID is declared in the polis README alongside the other polis metadata

## Integration Depth

Embedding `matrix_dart_sdk` in the Flutter app (not linking out to Element). Messages appear inside achaean's UI with the same Athenian styling. Matrix is the transport, not the UX.

## Open Questions

- **Homeserver hosting**: Does each polis run its own Synapse? Or is there a shared one? Federation means it doesn't matter much, but someone has to run a server.
- **Room membership sync**: Who has authority to invite/kick from polis rooms? A bot watching the trust graph? The client itself?
- **Key verification**: Should Matrix's own key verification (emoji compare) layer on top of koinon's identity binding, or is the signed claim enough?
- **Offline messages**: Matrix handles this natively (sync on reconnect), but how does it interact with achaean's git-based content model?

## When to Build

After core post/trust/membership flows are working. Messaging is additive — it doesn't change the existing architecture.
