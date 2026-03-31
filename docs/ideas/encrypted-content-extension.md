# Koinon Protocol Extension: Encrypted Content

**Status:** Draft — data model only. Encryption scheme and key management deferred.

## Goal

Allow Koinon posts to carry encrypted content without leaking metadata through repo structure, post JSON, or the Synedrion index. The data model should leave room for encryption to be layered on later without structural changes.

## Non-Goals

- Specifying the encryption algorithm or key format
- Key management, distribution, or rotation
- Client-side encryption/decryption implementation

These are intentionally deferred. The purpose of this spec is to shape the data model so that none of the above require breaking changes when they arrive.

---

## 1. Repo Structure

Public posts are unchanged:

```
posts/my-cool-take/post.json
posts/link-roundup-march/post.json
```

Encrypted posts live under `posts/encrypted/` with opaque, timestamp-based directory names:

```
posts/encrypted/1711900800-0/post.json
posts/encrypted/1711900800-1/post.json
posts/encrypted/1711900923-0/post.json
```

The directory name is `{unix-timestamp}-{index}`, where index starts at 0 and increments if multiple encrypted posts share the same second.

**Why not UUIDs for all posts?** Making all posts use opaque paths to hide which are encrypted would be security theater — the JSON content itself reveals whether a post is encrypted. Keeping public posts human-readable and using an explicit `encrypted/` prefix is honest and preserves browsability for public repos.

---

## 2. EncryptedPost Model

A new model, separate from `Post`. No flags, no nullable gymnastics — an encrypted post is a different thing.

**Location:** `dart_koinon/lib/src/models/encrypted_post.dart`

```dart
@freezed
abstract class EncryptedPost with _$EncryptedPost {
  const factory EncryptedPost({
    /// The encrypted payload. Opaque blob (base64-encoded).
    /// Contains the serialized PostContent, routing, details,
    /// crosspost — everything that would be in a plaintext Post.
    required String encryptedContent,

    /// When the post was created.
    required DateTime timestamp,

    /// Author's signature over the encrypted payload.
    required String signature,
  }) = _EncryptedPost;

  factory EncryptedPost.fromJson(Map<String, dynamic> json) =>
      _$EncryptedPostFromJson(json);
}
```

### Example `post.json` (encrypted)

```json
{
  "encryptedContent": "eyJhbGciOiJBMjU2R0NNIi...<base64 blob>",
  "timestamp": "2025-03-28T14:00:00.000Z",
  "signature": "MEUCIQD..."
}
```

### Shape detection

The indexer and client distinguish post types by the JSON shape:

- Has `content` key → `Post` (public)
- Has `encryptedContent` key → `EncryptedPost`

No version field or type discriminator needed.

---

## 3. What's Inside the Blob

When encrypted, the blob contains everything that would normally be plaintext in a `Post`:

- `content` (text, title, url, media filenames)
- `routing` (poleis, tags, mentions)
- `details` (polls, events, etc.)
- `crosspost` (platform configs)
- `parent` (if a reply)

The blob is opaque to the indexer and to anyone without the decryption key. The serialization format inside the blob is the same JSON shape as a plaintext `Post` minus `timestamp` and `signature` (which stay outside).

---

## 4. Indexer Changes

**`content_indexer.dart`** currently reads `post.json`, deserializes a `Post`, and stores metadata in a `PostReference`.

For encrypted posts, the indexer:

1. Parses the JSON
2. Detects `encryptedContent` key → treats as `EncryptedPost`
3. Indexes only what it can see in plaintext:
   - `authorPubkey` (from repo lookup)
   - `authorRepoUrl` (from webhook event)
   - `postUrl` (from event + path)
   - `commitHash` (from event)
   - `timestamp` (plaintext on EncryptedPost)
   - `indexedAt` (current time)
   - `encrypted: true`
4. Does NOT index: `title` (null), `poleisTags` (null), `parentPostUrl` (null — reply info is inside the blob)

The indexer never attempts to decrypt. It is metadata-only for encrypted posts.

---

## 5. PostReference Changes

Add one field to `PostReference`:

```dart
/// Whether this post is encrypted.
@Default(false) bool encrypted;
```

For encrypted posts: `encrypted = true`, `title = null`, `poleisTags = null`, `parentPostUrl = null`.

For public posts: no change. `encrypted` defaults to `false`.

This lets the client know before fetching whether a post is encrypted, so it can show a placeholder or skip decryption logic for public posts.

---

## 6. Client Behavior

### Rendering

- Public posts: render as today (no change).
- Encrypted posts: client fetches `post.json`, detects `EncryptedPost`, attempts decryption.
  - Success: deserialize the blob as Post fields, render normally.
  - Failure (no key): show a placeholder ("Encrypted post — you don't have access").

### Search

- Server-side search (via Synedrion): only works for public posts. Encrypted posts have no indexed title or content.
- Client-side search: the client can search over decrypted content it has already fetched and cached locally.

### Posting

- Client writes encrypted content to `posts/encrypted/{timestamp}-{index}/post.json`.
- Client writes public content to `posts/{slug}/post.json`.
- Commit and push as usual. The forge doesn't know or care.

---

## 7. Key Management (Out of Scope — Implementation Detail)

Encryption scheme, key format, key distribution, and key rotation are **not protocol concerns**. They are implementation details left to clients (Achaean or otherwise).

The protocol defines only the shape: a post can be an opaque encrypted blob with plaintext `timestamp` and `signature`. How the blob is produced — what cipher, what key exchange, what rotation strategy — is entirely up to the implementation. This is consistent with Koinon's design philosophy: the protocol defines data shapes and primitives, not machinery.

Any implementation will need to solve:

- **Polis-scoped encryption:** A shared key for polis members so all members can decrypt community content.
- **Individual encryption:** Encrypting to specific keypairs (DMs, private messages).
- **Key rotation:** What happens when polis membership changes.
- **Historical access:** Whether new members can read old encrypted posts.
- **Key storage:** Where wrapped/encrypted keys live (polis repo, user repo, etc.).

Different implementations may solve these differently. That's fine — the protocol doesn't care what's inside the blob, only that the blob exists and the plaintext metadata around it has the right shape.

---

## Summary of Changes

| Component | Change |
|---|---|
| Repo structure | Add `posts/encrypted/{ts}-{idx}/` path convention |
| `dart_koinon` models | New `EncryptedPost` model. `Post` unchanged. |
| Content indexer | Detect shape, index metadata-only for encrypted posts |
| `PostReference` | Add `bool encrypted` field |
| Client | Decrypt-on-render, placeholder for inaccessible posts |
| Key management | Out of scope — blob is opaque, scheme is pluggable |
