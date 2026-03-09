# Post Flagging Design

## Scope

Add post flagging as the 5th Koinon primitive. Any polis member can flag a post by adding a signed entry to their koinon.json. Flagged posts get NSFW-blurred in the agora after crossing a configurable threshold. Vouchers can query flagged posts to decide whether to revoke trust on the author. Also rename `threshold` → `membership_threshold` for clarity alongside the new `flag_threshold`.

## Key Decisions

- **Flagging is a first-class primitive** alongside identity, trust, polis signatures, and posts. Stored in koinon.json, indexed by Serverpod into relational tables.
- **Signed flags** for accountability. If someone abuses flagging, the community can trace it and revoke their trust.
- **NSFW blur** once flag count >= `flag_threshold` (per-polis config in README frontmatter, default 1).
- **Flags are permanent per polis.** A flagged post stays blurred. Vouchers are notified via a query endpoint and decide independently whether to revoke trust on the author.
- **Deletion:** Authors can delete flagged posts (webhook de-indexes). Flaggers can retract flags (remove from koinon.json, webhook re-indexes, count drops).
- **No push notifications.** Vouchers query Serverpod for "flags on posts by people I trust." Push is a future enhancement.
- **Reason field:** Free-form string. No enum.
- **Rename `threshold` → `membership_threshold`** in polis README frontmatter, `PolisDefinition` model, AGE graph, and all queries.

---

## koinon.json Addition

```json
{
  "protocol": "koinon",
  "version": "1.0",
  "pubkey": "abc123...",
  "repo_https": "http://localhost:3000/alice/koinon",
  "poleis": [...],
  "trust": [...],
  "flags": [
    {
      "post": "alice/koinon/posts/2026-03-09-hot-take/post.json",
      "polis": "bob/polis-democracy",
      "reason": "spam"
    }
  ]
}
```

New `FlagEntry` freezed model in `dart_koinon`: `post` (String), `polis` (String), `reason` (String).

Add `@Default([]) List<FlagEntry> flags` to `KoinonManifest`.

---

## Polis README Frontmatter

```yaml
---
name: "Democracy"
membership_threshold: 1
flag_threshold: 3
---
```

- `membership_threshold`: mutual TRUST edges required for membership (renamed from `threshold`). Default 1.
- `flag_threshold`: number of flags before a post gets NSFW-blurred. Default 1.

Both stored in `PolisDefinition` model (`membershipThreshold`, `flagThreshold`).

---

## Serverpod Model

`FlagRecord` (new `.spy.yaml`):

| Field | Type | Description |
|-------|------|-------------|
| `flaggedByPubkey` | String | Who flagged |
| `postAuthorPubkey` | String | Post author's pubkey |
| `postPath` | String | Path to the post file |
| `polisRepoUrl` | String | Which polis context |
| `reason` | String | Free-form reason |
| `timestamp` | DateTime | When flagged |
| `indexedAt` | DateTime | When Serverpod indexed it |

---

## Webhook Indexing

Same atomic-replace pattern as trust and signatures. When koinon.json changes:

1. Delete all `flag_records` where `flaggedByPubkey` = this pubkey
2. Re-insert from manifest `flags` array
3. Look up `postAuthorPubkey` from `post_references` table by matching `postPath`

---

## Endpoints

- `getFlagsForPolis(polisRepoUrl)` → `List<FlagRecord>` — all flags in a polis. Client groups by post and compares count to `flag_threshold` for NSFW rendering.
- `getFlaggedPostsForVouchers()` → `List<FlagRecord>` — uses caller's pubkey (from auth), traverses AGE TRUSTS edges to find people the caller vouches for, returns flags on their posts. "Show me flags on posts by people I trust."

Both endpoints require keypair auth (like all query endpoints).

---

## Flutter Side

### FlagService

- `flagPost({postPath, polisRepoUrl, reason})` — add FlagEntry to koinon.json flags array, commit
- `retractFlag({postPath, polisRepoUrl})` — remove matching FlagEntry, commit
- `getOwnFlags()` — read koinon.json flags array

### Agora UI

- Query `getFlagsForPolis` when loading agora
- Group flags by post path, count per post
- If count >= polis `flag_threshold`, render post with NSFW blur overlay
- Tap to reveal (user choice)

### Voucher Review

- Query `getFlaggedPostsForVouchers` to see flagged posts by trusted users
- Voucher can then navigate to trust management and revoke if warranted

---

## Rename: `threshold` → `membership_threshold`

Affects:

- `PolisDefinition` Serverpod model (`.spy.yaml`): rename `threshold` field to `membershipThreshold`
- `AgeGraph.computeMembers`: parameter name update
- `KoinonEndpoint.getPolisMembers` / `getAgora`: read `membershipThreshold` instead of `threshold`
- `AgeGraph.upsertPolis`: store as `membership_threshold` property on Polis node
- Flutter `PolisInfo` model: rename `threshold` → `membershipThreshold`
- Flutter `PolisService._parseYamlFrontmatter`: read `membership_threshold` from YAML
- Polis README generation: write `membership_threshold` instead of `threshold`

---

## Data Flow

```
Member flags post (Flutter)
  → adds FlagEntry to koinon.json flags array
  → commits to own koinon repo via IGitClient
  → Forgejo fires system webhook
  → Serverpod webhook: reads koinon.json, atomic-replaces flag_records
  → flag_records table updated

Agora query (Flutter)
  → getFlagsForPolis(polisRepoUrl)
  → returns all FlagRecords for polis
  → Flutter groups by post, counts flags
  → >= flag_threshold → NSFW blur

Voucher review (Flutter)
  → getFlaggedPostsForVouchers()
  → Serverpod: AGE traversal (caller → TRUSTS → others → authored posts → joined with flags)
  → returns flagged posts by people caller trusts
  → voucher decides: revoke trust or not
```
