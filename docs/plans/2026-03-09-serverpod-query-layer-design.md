# Serverpod Query Layer Design

## Scope

Wire up the Flutter client to query Serverpod endpoints. Replace anonaccount with a stateless auth handler. Add services and cubits for agora feed, polis discovery, user lookup, and voucher review. No UI screens — cubits are the stopping point.

## Key Decisions

- **Stateless auth replaces anonaccount.** Client signs timestamp with ECDSA P-256 keypair on every request. Server verifies signature, no registration or sessions needed. Serverpod stays a replaceable, stateless index.
- **Token format:** `pubkey:timestamp:signature` sent via Serverpod's built-in auth key manager. Handler parses, checks timestamp freshness (5 min), verifies ECDSA signature.
- **Lazy content loading.** Serverpod returns `PostReference` metadata only. Flutter reads actual `post.json` from author's git repo via `PublicGitClientFactory`. Serverpod never stores post content.
- **Thin feature services** wrapping `client.koinon.*` calls. Each service composes multiple endpoint calls and adds domain logic. Follows existing `IService` → `Service` → `Cubit` pattern.

---

## Auth: KoinonAuthHandler

### Server-Side

New `KoinonAuthHandler` plugs into Serverpod's `authenticationHandler` parameter:

```dart
final pod = Serverpod(
  args, Protocol(), Endpoints(),
  authenticationHandler: KoinonAuthHandler.handleAuthentication,
);
```

Handler signature:
```dart
static Future<AuthenticationInfo?> handleAuthentication(
  Session session, String token,
)
```

Flow:
1. Parse token: `pubkey:timestamp:signature` (colon-separated)
2. Validate timestamp is within 5 minutes
3. Verify ECDSA P-256 signature of timestamp bytes against pubkey
4. Return `AuthenticationInfo(pubkey, {}, authId: pubkey)`

Copy `CryptoUtils` (pointycastle ECDSA P-256 verification) from anonaccount. No database lookup needed.

### Client-Side

`KoinonKeyManager` implements Serverpod's auth key manager interface. On each request:
1. Get pubkey hex from `IKeyService`
2. Sign current ISO 8601 UTC timestamp with stored keypair
3. Return token as `pubkey:timestamp:signatureHex`

Serverpod's generated client attaches the token automatically via `Authorization` header.

### Remove

- anonaccount dependency from server and client `pubspec.yaml`
- `KoinonAuth` (custom header class)
- `ServerpodAuthService` and `IServerpodAuthService`
- All anonaccount imports and module references

---

## Services

### PostReadingService

Reads post content from any user's git repo. Reusable across agora, flagged post review, user profiles.

```dart
abstract class IPostReadingService {
  Future<Post> getPost(PostReference ref);
}
```

Implementation uses `PublicGitClientFactory` to create an `IGitClient` for the author's repo, reads `post.json` at the given path, parses as `Post`.

### AgoraService

Queries Serverpod for post references and flags within a polis.

```dart
abstract class IAgoraService {
  Future<List<PostReference>> getAgoraRefs(String polisRepoUrl, {int limit = 50, int offset = 0});
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl);
}
```

### PolisQueryService

Queries Serverpod for polis discovery and membership.

```dart
abstract class IPolisQueryService {
  Future<List<PolisDefinition>> listPoleis();
  Future<PolisDefinition?> getPolis(String repoUrl);
  Future<List<PolitaiUser>> getPolisMembers(String polisRepoUrl);
  Future<List<ReadmeSignatureRecord>> getPolisSigners(String polisRepoUrl);
}
```

### UserQueryService

Queries Serverpod for user lookup and trust graph.

```dart
abstract class IUserQueryService {
  Future<PolitaiUser?> getUser(String pubkey);
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(String pubkey);
}
```

### VoucherReviewService

Queries Serverpod for flagged posts by people the caller trusts.

```dart
abstract class IVoucherReviewService {
  Future<List<FlagRecord>> getFlaggedPostsByTrusted();
}
```

---

## Cubits

### AgoraCubit

Loads post references + flags for a polis. Combines them into state with flag counts and blur status per post.

State holds: `List<PostReference>`, flag counts map, polis `flagThreshold`, pagination info.

Methods: `loadAgora(polisRepoUrl)`, `loadMore()`.

### PolisDiscoveryCubit

Lists all known poleis, loads members for a selected polis.

State holds: `List<PolisDefinition>`, selected polis members.

Methods: `loadPoleis()`, `loadMembers(polisRepoUrl)`.

### VoucherReviewCubit

Loads flagged posts by people the caller trusts.

State holds: `List<FlagRecord>`.

Methods: `loadFlaggedPosts()`.

---

## Data Flow

```
Agora feed:
  AgoraCubit.loadAgora(polisRepoUrl)
    → AgoraService.getAgoraRefs(polisRepoUrl, limit, offset)
      → client.koinon.getAgora() → List<PostReference>
    → AgoraService.getFlagsForPolis(polisRepoUrl)
      → client.koinon.getFlagsForPolis() → List<FlagRecord>
    → Cubit combines: refs + flag counts + polis flagThreshold → state
    → UI renders references, lazy-loads content:
      → PostReadingService.getPost(ref)
        → PublicGitClientFactory → IGitClient.readFile(post.json)

Polis discovery:
  PolisDiscoveryCubit.loadPoleis()
    → PolisQueryService.listPoleis()
      → client.koinon.listPoleis() → List<PolisDefinition>
  PolisDiscoveryCubit.loadMembers(polisRepoUrl)
    → PolisQueryService.getPolisMembers()
      → client.koinon.getPolisMembers() → List<PolitaiUser>

Voucher review:
  VoucherReviewCubit.loadFlaggedPosts()
    → VoucherReviewService.getFlaggedPostsByTrusted()
      → client.koinon.getFlaggedPostsForVouchers() → List<FlagRecord>
    → PostReadingService.getPost() for each flagged post
```

## What Changes

- **Remove:** anonaccount from server + client dependencies, `KoinonAuth`, `ServerpodAuthService`, `IServerpodAuthService`
- **Add (server):** `KoinonAuthHandler`, `CryptoUtils` (ECDSA P-256 verification, from anonaccount)
- **Add (client):** `KoinonKeyManager`, 5 query services (PostReading, Agora, PolisQuery, UserQuery, VoucherReview), 3 cubits (Agora, PolisDiscovery, VoucherReview)
- **Modify:** `server.dart` (swap auth handler), `bootstrap.dart` (new DI registrations, remove anonaccount)
