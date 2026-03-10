# Serverpod Query Layer Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Wire up the Flutter client to query Serverpod endpoints using stateless keypair auth, replacing anonaccount with a simpler KoinonAuthHandler.

**Architecture:** Server gets a `KoinonAuthHandler` that verifies ECDSA P-256 signed timestamps — no registration, no sessions. Client gets a `KoinonKeyManager` that generates auth tokens automatically for the Serverpod generated client. Thin feature services wrap `client.koinon.*` calls, cubits manage state.

**Tech Stack:** Serverpod 3.4.1, Flutter/Dart, pointycastle (ECDSA P-256), freezed (state), get_it (DI)

**Design doc:** `docs/plans/2026-03-09-serverpod-query-layer-design.md`

---

## Task 1: CryptoUtils — ECDSA P-256 Verification (Server)

Copy the signature verification logic from anonaccount into achaean_server so we can drop the anonaccount dependency.

**Files:**
- Create: `achaean_server/lib/src/koinon/crypto_utils.dart`
- Modify: `achaean_server/pubspec.yaml` (add pointycastle dependency)

**Step 1: Add pointycastle to server pubspec.yaml**

Add under `dependencies`:
```yaml
  pointycastle: ^3.9.1
```

**Step 2: Create crypto_utils.dart**

This is adapted from anonaccount's `crypto_utils.dart`. Only keep what we need — signature verification and key validation.

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// ECDSA P-256 cryptographic utilities for Koinon auth.
///
/// Adapted from serverpod_anonaccred CryptoUtils.
class CryptoUtils {
  /// Validates ECDSA P-256 public key format.
  ///
  /// Accepts 128 hex chars (raw x||y) or 130 hex chars (04 prefix + x||y).
  static bool isValidPublicKey(String publicKey) {
    if (publicKey.length != 128 && publicKey.length != 130) return false;
    if (publicKey.length == 130 && !publicKey.startsWith('04')) return false;
    return _isHexString(publicKey);
  }

  /// Validates ECDSA P-256 signature format (128 hex chars = 64 bytes r||s).
  static bool isValidSignature(String signature) {
    return signature.length == 128 && _isHexString(signature);
  }

  /// Verify an ECDSA P-256 signature.
  ///
  /// [message] is the plaintext that was signed.
  /// [signature] is 128 hex chars (r||s, 32 bytes each).
  /// [publicKey] is 128 or 130 hex chars.
  static Future<bool> verifySignature({
    required String message,
    required String signature,
    required String publicKey,
  }) async {
    try {
      if (!isValidPublicKey(publicKey) || !isValidSignature(signature)) {
        return false;
      }

      // Hash message with SHA-256
      final messageBytes = utf8.encode(message);
      final digest = SHA256Digest();
      final hashedMessage = Uint8List(digest.digestSize);
      digest.update(Uint8List.fromList(messageBytes), 0, messageBytes.length);
      digest.doFinal(hashedMessage, 0);

      // Parse public key — extract x||y coordinates
      final pubKeyHex = publicKey.length == 130
          ? publicKey.substring(2) // Strip 04 prefix
          : publicKey;
      final pubKeyBytes = hexToBytes(pubKeyHex);
      final x = pubKeyBytes.sublist(0, 32);
      final y = pubKeyBytes.sublist(32, 64);
      final xBigInt = _bytesToBigInt(x);
      final yBigInt = _bytesToBigInt(y);

      // Create EC point on P-256 curve
      final domainParams = ECDomainParameters('secp256r1');
      final point = domainParams.curve.createPoint(xBigInt, yBigInt);
      final ecPublicKey = ECPublicKey(point, domainParams);

      // Parse signature — extract r||s (32 bytes each)
      final sigBytes = hexToBytes(signature);
      final r = _bytesToBigInt(sigBytes.sublist(0, 32));
      final s = _bytesToBigInt(sigBytes.sublist(32, 64));
      final ecSignature = ECSignature(r, s);

      // Verify
      final signer = ECDSASigner(SHA256Digest());
      signer.init(
        false,
        PublicKeyParameter<ECPublicKey>(ecPublicKey),
      );
      return signer.verifySignature(hashedMessage, ecSignature);
    } catch (_) {
      return false;
    }
  }

  /// Convert hex string to bytes.
  static Uint8List hexToBytes(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      result[i ~/ 2] = int.parse(hex.substring(i, i + 2), radix: 16);
    }
    return result;
  }

  static bool _isHexString(String s) => RegExp(r'^[0-9a-fA-F]+$').hasMatch(s);

  static BigInt _bytesToBigInt(Uint8List bytes) {
    var result = BigInt.zero;
    for (final byte in bytes) {
      result = (result << 8) | BigInt.from(byte);
    }
    return result;
  }
}
```

**Step 3: Verify it compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_server && dart pub get && dart analyze lib/src/koinon/crypto_utils.dart`
Expected: No errors.

**Step 4: Commit**

```bash
git add achaean_server/pubspec.yaml achaean_server/lib/src/koinon/crypto_utils.dart
git commit -m "Add CryptoUtils: ECDSA P-256 verification for Koinon auth"
```

---

## Task 2: KoinonAuthHandler — Stateless Serverpod Auth (Server)

Replace `KoinonAuth` (custom headers) with `KoinonAuthHandler` that plugs into Serverpod's `authenticationHandler`. The client sends a token `pubkey:timestamp:signatureHex`, and the handler verifies it.

**Files:**
- Replace: `achaean_server/lib/src/koinon/koinon_auth.dart`

**Step 1: Rewrite koinon_auth.dart**

Replace the entire file. The new handler implements Serverpod's `authenticationHandler` signature — it receives a token string (extracted from the Authorization header by Serverpod) and returns `AuthenticationInfo` or `null`.

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import 'crypto_utils.dart';

/// Stateless keypair authentication for Koinon endpoints.
///
/// Token format: `pubkey:timestamp:signature`
/// - pubkey: 128-char hex ECDSA P-256 public key
/// - timestamp: ISO 8601 UTC timestamp
/// - signature: 128-char hex ECDSA signature of the timestamp bytes
///
/// Plugs into Serverpod's authenticationHandler. No registration,
/// no sessions, no database lookup. Fully stateless.
class KoinonAuthHandler {
  static const _maxAgeMinutes = 5;

  /// Serverpod authentication handler callback.
  ///
  /// [token] is extracted from the Authorization header by Serverpod.
  /// Returns [AuthenticationInfo] with the pubkey as user identifier,
  /// or null if verification fails.
  static Future<AuthenticationInfo?> handleAuthentication(
    Session session,
    String token,
  ) async {
    try {
      return await _verify(token);
    } catch (e) {
      session.log('KoinonAuth: verification failed: $e',
          level: LogLevel.warning);
      return null;
    }
  }

  /// Verify the token and return the caller's pubkey.
  ///
  /// Can also be called directly from endpoints that need the pubkey.
  /// Throws if verification fails.
  static Future<String> verifyFromSession(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Not authenticated');
    }
    return authInfo.authId ?? authInfo.userIdentifier;
  }

  static Future<AuthenticationInfo> _verify(String token) async {
    // Parse token: pubkey:timestamp:signature
    final parts = token.split(':');
    // Timestamp contains colons (ISO 8601), so rejoin everything between
    // first and last colon-separated segments
    if (parts.length < 3) {
      throw Exception('Invalid token format');
    }
    final pubkey = parts.first;
    final signature = parts.last;
    final timestamp = parts.sublist(1, parts.length - 1).join(':');

    if (!CryptoUtils.isValidPublicKey(pubkey)) {
      throw Exception('Invalid public key format');
    }

    if (!CryptoUtils.isValidSignature(signature)) {
      throw Exception('Invalid signature format');
    }

    // Check timestamp freshness
    final ts = DateTime.tryParse(timestamp);
    if (ts == null) {
      throw Exception('Invalid timestamp format');
    }

    final age = DateTime.now().toUtc().difference(ts);
    if (age.inSeconds.abs() > _maxAgeMinutes * 60) {
      throw Exception('Timestamp too old');
    }

    // Verify signature of timestamp string
    final valid = await CryptoUtils.verifySignature(
      message: timestamp,
      signature: signature,
      publicKey: pubkey,
    );

    if (!valid) {
      throw Exception('Invalid signature');
    }

    return AuthenticationInfo(
      pubkey,
      {},
      authId: pubkey,
    );
  }
}
```

**Step 2: Update all endpoint auth calls**

The endpoints currently call `await KoinonAuth.verify(session)` which returns the pubkey. Change to `await KoinonAuthHandler.verifyFromSession(session)`.

In `achaean_server/lib/src/koinon/koinon_endpoint.dart`, find and replace all occurrences:
- `await KoinonAuth.verify(session)` → `await KoinonAuthHandler.verifyFromSession(session)`

Update the import:
- Remove: `import 'koinon_auth.dart';` (if it was `KoinonAuth`)
- The import stays the same since the file path hasn't changed.

**Step 3: Verify it compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_server && dart analyze lib/src/koinon/`
Expected: No errors.

**Step 4: Commit**

```bash
git add achaean_server/lib/src/koinon/koinon_auth.dart achaean_server/lib/src/koinon/koinon_endpoint.dart
git commit -m "Replace KoinonAuth with KoinonAuthHandler: stateless Serverpod auth"
```

---

## Task 3: Remove Anonaccount + Wire Auth Handler (Server)

Remove anonaccount dependency from the server, wire `KoinonAuthHandler` into Serverpod, and remove the email IDP (not needed — identity is keypair-based).

**Files:**
- Modify: `achaean_server/pubspec.yaml` (remove anonaccount_server)
- Modify: `achaean_server/lib/server.dart` (add authenticationHandler, remove initializeAuthServices)
- Delete: `achaean_server/lib/src/auth/email_idp_endpoint.dart`
- Delete: `achaean_server/lib/src/auth/jwt_refresh_endpoint.dart`

**Step 1: Remove anonaccount from server pubspec.yaml**

Remove these lines from `dependencies`:
```yaml
  anonaccount_server:
    git:
      url: https://github.com/qtpi-bonding-org/serverpod_anonaccred.git
      ref: 5f364aee45cb6a39e7f07b7aaf8187a5164d3f88
      path: anonaccount_server
```

Also remove `serverpod_auth_idp_server: 3.4.1` since we no longer need email IDP.

**Step 2: Update server.dart**

Replace the Serverpod constructor and remove `initializeAuthServices`:

```dart
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/koinon/age_graph.dart';
import 'src/koinon/koinon_auth.dart';
import 'src/web/routes/app_config_route.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: KoinonAuthHandler.handleAuthentication,
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RootRoute(), '/');
  pod.webServer.addRoute(RootRoute(), '/index.html');

  final root = Directory(Uri(path: 'web/static').toFilePath());
  pod.webServer.addRoute(StaticRoute.directory(root));

  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '/app/assets/assets/config.json',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (appDir.existsSync()) {
    pod.webServer.addRoute(
      FlutterRoute(Directory(Uri(path: 'web/app').toFilePath())),
      '/app',
    );
  } else {
    pod.webServer.addRoute(
      StaticRoute.file(
        File(Uri(path: 'web/pages/build_flutter_app.html').toFilePath()),
      ),
      '/app/**',
    );
  }

  await pod.start();

  // Initialize Apache AGE graph
  final ageSession = await pod.createSession();
  try {
    await AgeGraph.initialize(ageSession);
    stdout.writeln('AGE graph initialized');
  } catch (e) {
    stdout.writeln(
      'AGE graph initialization failed (is AGE extension installed?): $e',
    );
  } finally {
    await ageSession.close();
  }
}
```

**Step 3: Delete email IDP and JWT refresh endpoints**

Delete:
- `achaean_server/lib/src/auth/email_idp_endpoint.dart`
- `achaean_server/lib/src/auth/jwt_refresh_endpoint.dart`

These were Serverpod auth module endpoints that we no longer need.

**Step 4: Run serverpod generate + verify**

Run: `cd /Users/aicoder/Documents/achaean/achaean_server && dart pub get && serverpod generate && dart analyze`

This regenerates `protocol.dart`, `endpoints.dart`, etc. without anonaccount references.

Expected: Compiles cleanly. The generated client code will also be updated (anonaccount module references removed).

**Step 5: Commit**

```bash
git add -A achaean_server/
git commit -m "Remove anonaccount + email IDP, wire KoinonAuthHandler into Serverpod"
```

---

## Task 4: Remove Anonaccount from Client + Flutter

Remove anonaccount from achaean_client and achaean_flutter. Replace `FlutterAuthSessionManager` with a `KoinonKeyManager` that generates stateless auth tokens.

**Files:**
- Modify: `achaean_client/pubspec.yaml` (remove anonaccount_client)
- Modify: `achaean_flutter/pubspec.yaml` (remove anonaccount_client, serverpod_auth_idp_flutter)
- Create: `achaean_flutter/lib/core/services/koinon_key_manager.dart`
- Modify: `achaean_flutter/lib/app/bootstrap.dart`
- Delete: `achaean_flutter/lib/core/services/i_serverpod_auth_service.dart`
- Delete: `achaean_flutter/lib/core/services/serverpod_auth_service.dart`

**Step 1: Remove anonaccount from client pubspec.yaml**

Remove from `achaean_client/pubspec.yaml`:
```yaml
  anonaccount_client:
    git:
      url: https://github.com/qtpi-bonding-org/serverpod_anonaccred.git
      ref: 5f364aee45cb6a39e7f07b7aaf8187a5164d3f88
      path: anonaccount_client
```

Also remove `serverpod_auth_idp_client: 3.4.1` (no longer needed).

**Step 2: Remove anonaccount + auth_idp from Flutter pubspec.yaml**

Remove from `achaean_flutter/pubspec.yaml`:
```yaml
  serverpod_auth_idp_flutter: 3.4.1
  anonaccount_client:
    git:
      url: https://github.com/qtpi-bonding-org/serverpod_anonaccred.git
      ref: 5f364aee45cb6a39e7f07b7aaf8187a5164d3f88
      path: anonaccount_client
```

**Step 3: Create KoinonKeyManager**

This implements Serverpod's `AuthenticationKeyManager` interface. On every request, it generates a fresh `pubkey:timestamp:signatureHex` token.

Create `achaean_flutter/lib/core/services/koinon_key_manager.dart`:

```dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:serverpod_client/serverpod_client.dart';

import 'i_key_service.dart';

/// Stateless Koinon auth token manager for Serverpod.
///
/// Generates a fresh `pubkey:timestamp:signatureHex` token on every request.
/// Serverpod sends this as the Authorization header, and the server's
/// [KoinonAuthHandler] verifies it.
///
/// No sessions, no stored tokens. [put] and [remove] are no-ops.
class KoinonKeyManager extends AuthenticationKeyManager {
  final IKeyService _keyService;

  KoinonKeyManager(this._keyService);

  @override
  Future<String?> get() async {
    final pubkey = await _keyService.getPublicKeyHex();
    if (pubkey == null) return null;

    final timestamp = DateTime.now().toUtc().toIso8601String();
    final timestampBytes = Uint8List.fromList(utf8.encode(timestamp));
    final signatureBytes = await _keyService.signBytes(timestampBytes);

    final signatureHex = signatureBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return '$pubkey:$timestamp:$signatureHex';
  }

  @override
  Future<void> put(String key) async {
    // No-op: stateless auth, no tokens to store.
  }

  @override
  Future<void> remove() async {
    // No-op: stateless auth, no tokens to remove.
  }

  @override
  Future<String?> toHeaderValue(String? key) async {
    if (key == null) return null;
    return 'Bearer $key';
  }
}
```

**Step 4: Update bootstrap.dart**

Replace `FlutterAuthSessionManager` with `KoinonKeyManager`. Remove `ServerpodAuthService` registration. Remove anonaccount/auth_idp imports.

Changes to `bootstrap.dart`:

1. Remove imports:
   - `import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';`
   - `import '../core/services/i_serverpod_auth_service.dart';`
   - `import '../core/services/serverpod_auth_service.dart';`

2. Add import:
   - `import '../core/services/koinon_key_manager.dart';`

3. Replace the Serverpod client initialization (in `bootstrap()`):

```dart
    // 3. Initialize Serverpod client
    debugPrint('Bootstrap: Initializing Serverpod client...');
    final serverUrl = await getServerUrl();
    final keyManager = KoinonKeyManager(getIt<IKeyService>());
    final client = Client(
      serverUrl,
      authenticationKeyManager: keyManager,
    )..connectivityMonitor = FlutterConnectivityMonitor();
    getIt.registerSingleton<Client>(client);
    debugPrint('Bootstrap: Serverpod client initialized');
```

4. Remove from `_registerCoreServices()`:
```dart
  // Serverpod auth header service
  getIt.registerLazySingleton<IServerpodAuthService>(
    () => ServerpodAuthService(getIt<IKeyService>()),
  );
```

**Step 5: Delete old auth service files**

Delete:
- `achaean_flutter/lib/core/services/i_serverpod_auth_service.dart`
- `achaean_flutter/lib/core/services/serverpod_auth_service.dart`

**Step 6: Run pub get + verify**

Run: `cd /Users/aicoder/Documents/achaean && dart pub get && cd achaean_flutter && dart analyze`

Expected: No errors. The generated Serverpod client may need regeneration if anonaccount references were in protocol files.

**Step 7: Commit**

```bash
git add -A achaean_client/ achaean_flutter/ pubspec.lock
git commit -m "Remove anonaccount from client + Flutter, add KoinonKeyManager"
```

---

## Task 5: Query Exception + PostReadingService

Add the exception class for query operations and the service for reading posts from foreign repos.

**Files:**
- Create: `achaean_flutter/lib/core/exceptions/query_exception.dart`
- Create: `achaean_flutter/lib/features/agora/services/i_post_reading_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/post_reading_service.dart`

**Step 1: Create query exception**

```dart
class QueryException implements Exception {
  final String message;
  final Object? cause;
  const QueryException(this.message, [this.cause]);
}
```

**Step 2: Create IPostReadingService interface**

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:dart_koinon/dart_koinon.dart';

/// Reads post content from author repos via public git API.
abstract class IPostReadingService {
  /// Read a post's content from the author's repo.
  ///
  /// Uses the [PostReference.authorRepoUrl] and [PostReference.path]
  /// to fetch the actual post.json file.
  Future<Post> getPost(PostReference ref);
}
```

**Step 3: Create PostReadingService implementation**

```dart
import 'dart:convert';

import 'package:achaean_client/achaean_client.dart';
import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/try_operation.dart';
import '../../../features/trust/services/trust_service.dart';
import 'i_post_reading_service.dart';

class PostReadingService implements IPostReadingService {
  final PublicGitClientFactory _publicClientFactory;
  final GitHostType _defaultHostType;

  PostReadingService(this._publicClientFactory, this._defaultHostType);

  @override
  Future<Post> getPost(PostReference ref) {
    return tryMethod(
      () async {
        final repoId = _parseRepoUrl(ref.authorRepoUrl);
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: _defaultHostType,
        );

        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: ref.path,
        );

        final json = jsonDecode(file.content) as Map<String, dynamic>;
        return Post.fromJson(json);
      },
      QueryException.new,
      'getPost',
    );
  }

  RepoIdentifier _parseRepoUrl(String repoUrl) {
    final uri = Uri.parse(repoUrl);
    final segments = uri.pathSegments;
    if (segments.length < 2) {
      throw QueryException('Invalid repo URL: $repoUrl');
    }
    final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
    return RepoIdentifier(
      baseUrl: baseUrl,
      owner: segments[0],
      repo: segments[1],
    );
  }
}
```

**Step 4: Verify it compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart analyze lib/features/agora/ lib/core/exceptions/query_exception.dart`
Expected: No errors.

**Step 5: Commit**

```bash
git add achaean_flutter/lib/core/exceptions/query_exception.dart achaean_flutter/lib/features/agora/
git commit -m "Add QueryException and PostReadingService for foreign repo reads"
```

---

## Task 6: AgoraService — Serverpod Query Wrapper

**Files:**
- Create: `achaean_flutter/lib/features/agora/services/i_agora_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/agora_service.dart`

**Step 1: Create IAgoraService interface**

```dart
import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for agora data (post references + flags).
abstract class IAgoraService {
  /// Get post references for a polis agora.
  Future<List<PostReference>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  });

  /// Get all flags for posts in a polis.
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl);
}
```

**Step 2: Create AgoraService implementation**

```dart
import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_agora_service.dart';

class AgoraService implements IAgoraService {
  final Client _client;

  AgoraService(this._client);

  @override
  Future<List<PostReference>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) {
    return tryMethod(
      () => _client.koinon.getAgora(polisRepoUrl, limit: limit, offset: offset),
      QueryException.new,
      'getAgoraRefs',
    );
  }

  @override
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getFlagsForPolis(polisRepoUrl),
      QueryException.new,
      'getFlagsForPolis',
    );
  }
}
```

**Step 3: Verify + Commit**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart analyze lib/features/agora/`

```bash
git add achaean_flutter/lib/features/agora/services/i_agora_service.dart achaean_flutter/lib/features/agora/services/agora_service.dart
git commit -m "Add AgoraService: Serverpod query wrapper for agora data"
```

---

## Task 7: PolisQueryService + UserQueryService + VoucherReviewService

Three thin services wrapping the remaining Serverpod endpoints.

**Files:**
- Create: `achaean_flutter/lib/features/agora/services/i_polis_query_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/polis_query_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/i_user_query_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/user_query_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/i_voucher_review_service.dart`
- Create: `achaean_flutter/lib/features/agora/services/voucher_review_service.dart`

**Step 1: Create IPolisQueryService + implementation**

Interface:
```dart
import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for polis discovery and membership data.
abstract class IPolisQueryService {
  Future<List<PolisDefinition>> listPoleis();
  Future<PolisDefinition?> getPolis(String repoUrl);
  Future<List<PolitaiUser>> getPolisMembers(String polisRepoUrl);
  Future<List<ReadmeSignatureRecord>> getPolisSigners(String polisRepoUrl);
}
```

Implementation:
```dart
import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_polis_query_service.dart';

class PolisQueryService implements IPolisQueryService {
  final Client _client;

  PolisQueryService(this._client);

  @override
  Future<List<PolisDefinition>> listPoleis() {
    return tryMethod(
      () => _client.koinon.listPoleis(),
      QueryException.new,
      'listPoleis',
    );
  }

  @override
  Future<PolisDefinition?> getPolis(String repoUrl) {
    return tryMethod(
      () => _client.koinon.getPolis(repoUrl),
      QueryException.new,
      'getPolis',
    );
  }

  @override
  Future<List<PolitaiUser>> getPolisMembers(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getPolisMembers(polisRepoUrl),
      QueryException.new,
      'getPolisMembers',
    );
  }

  @override
  Future<List<ReadmeSignatureRecord>> getPolisSigners(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getPolisSigners(polisRepoUrl),
      QueryException.new,
      'getPolisSigners',
    );
  }
}
```

**Step 2: Create IUserQueryService + implementation**

Interface:
```dart
import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for user lookup and trust graph data.
abstract class IUserQueryService {
  Future<PolitaiUser?> getUser(String pubkey);
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(String pubkey);
}
```

Implementation:
```dart
import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_user_query_service.dart';

class UserQueryService implements IUserQueryService {
  final Client _client;

  UserQueryService(this._client);

  @override
  Future<PolitaiUser?> getUser(String pubkey) {
    return tryMethod(
      () => _client.koinon.getUser(pubkey),
      QueryException.new,
      'getUser',
    );
  }

  @override
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(String pubkey) {
    return tryMethod(
      () => _client.koinon.getTrustDeclarations(pubkey),
      QueryException.new,
      'getTrustDeclarations',
    );
  }
}
```

**Step 3: Create IVoucherReviewService + implementation**

Interface:
```dart
import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for flagged posts by people the caller trusts.
abstract class IVoucherReviewService {
  Future<List<FlagRecord>> getFlaggedPostsByTrusted();
}
```

Implementation:
```dart
import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_voucher_review_service.dart';

class VoucherReviewService implements IVoucherReviewService {
  final Client _client;

  VoucherReviewService(this._client);

  @override
  Future<List<FlagRecord>> getFlaggedPostsByTrusted() {
    return tryMethod(
      () => _client.koinon.getFlaggedPostsForVouchers(),
      QueryException.new,
      'getFlaggedPostsByTrusted',
    );
  }
}
```

**Step 4: Verify + Commit**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart analyze lib/features/agora/`

```bash
git add achaean_flutter/lib/features/agora/services/
git commit -m "Add PolisQueryService, UserQueryService, VoucherReviewService"
```

---

## Task 8: AgoraCubit + State

**Files:**
- Create: `achaean_flutter/lib/features/agora/cubit/agora_state.dart`
- Create: `achaean_flutter/lib/features/agora/cubit/agora_cubit.dart`

**Step 1: Create AgoraState**

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agora_state.freezed.dart';

@freezed
abstract class AgoraState with _$AgoraState implements IUiFlowState {
  const AgoraState._();
  const factory AgoraState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PostReference> posts,
    @Default({}) Map<String, int> flagCounts,
    @Default(1) int flagThreshold,
    @Default(false) bool hasMore,
    @Default(0) int offset,
  }) = _AgoraState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;

  /// Check if a post is flagged (flag count >= threshold).
  bool isPostFlagged(String postPath) =>
      (flagCounts[postPath] ?? 0) >= flagThreshold;
}
```

**Step 2: Create AgoraCubit**

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../services/i_agora_service.dart';
import '../services/i_polis_query_service.dart';
import 'agora_state.dart';

class AgoraCubit extends AppCubit<AgoraState> {
  final IAgoraService _agoraService;
  final IPolisQueryService _polisQueryService;

  String? _currentPolisRepoUrl;
  static const _pageSize = 50;

  AgoraCubit(this._agoraService, this._polisQueryService)
      : super(const AgoraState());

  /// Load the agora for a polis.
  Future<void> loadAgora(String polisRepoUrl) async {
    _currentPolisRepoUrl = polisRepoUrl;

    await tryOperation(
      () async {
        // Fetch polis definition for flag threshold
        final polis = await _polisQueryService.getPolis(polisRepoUrl);
        final threshold = polis?.flagThreshold ?? 1;

        // Fetch post references and flags in parallel
        final results = await Future.wait([
          _agoraService.getAgoraRefs(polisRepoUrl, limit: _pageSize, offset: 0),
          _agoraService.getFlagsForPolis(polisRepoUrl),
        ]);

        final posts = results[0] as List<PostReference>;
        final flags = results[1] as List<FlagRecord>;

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: posts,
          flagCounts: _computeFlagCounts(flags),
          flagThreshold: threshold,
          hasMore: posts.length >= _pageSize,
          offset: posts.length,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Load more posts (pagination).
  Future<void> loadMore() async {
    final polisRepoUrl = _currentPolisRepoUrl;
    if (polisRepoUrl == null || !state.hasMore) return;

    await tryOperation(
      () async {
        final morePosts = await _agoraService.getAgoraRefs(
          polisRepoUrl,
          limit: _pageSize,
          offset: state.offset,
        );

        return state.copyWith(
          status: UiFlowStatus.success,
          posts: [...state.posts, ...morePosts],
          hasMore: morePosts.length >= _pageSize,
          offset: state.offset + morePosts.length,
          error: null,
        );
      },
      emitLoading: false,
    );
  }

  Map<String, int> _computeFlagCounts(List<FlagRecord> flags) {
    final counts = <String, int>{};
    for (final flag in flags) {
      counts[flag.postPath] = (counts[flag.postPath] ?? 0) + 1;
    }
    return counts;
  }
}
```

**Step 3: Run build_runner for freezed codegen**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs`

**Step 4: Verify + Commit**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart analyze lib/features/agora/cubit/`

```bash
git add achaean_flutter/lib/features/agora/cubit/
git commit -m "Add AgoraCubit: agora feed state with pagination and flag counts"
```

---

## Task 9: PolisDiscoveryCubit + VoucherReviewCubit

**Files:**
- Create: `achaean_flutter/lib/features/agora/cubit/polis_discovery_state.dart`
- Create: `achaean_flutter/lib/features/agora/cubit/polis_discovery_cubit.dart`
- Create: `achaean_flutter/lib/features/agora/cubit/voucher_review_state.dart`
- Create: `achaean_flutter/lib/features/agora/cubit/voucher_review_cubit.dart`

**Step 1: Create PolisDiscoveryState**

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'polis_discovery_state.freezed.dart';

@freezed
abstract class PolisDiscoveryState with _$PolisDiscoveryState implements IUiFlowState {
  const PolisDiscoveryState._();
  const factory PolisDiscoveryState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PolisDefinition> poleis,
    @Default([]) List<PolitaiUser> members,
  }) = _PolisDiscoveryState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;
}
```

**Step 2: Create PolisDiscoveryCubit**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../services/i_polis_query_service.dart';
import 'polis_discovery_state.dart';

class PolisDiscoveryCubit extends AppCubit<PolisDiscoveryState> {
  final IPolisQueryService _polisQueryService;

  PolisDiscoveryCubit(this._polisQueryService)
      : super(const PolisDiscoveryState());

  /// Load all known poleis from the Serverpod index.
  Future<void> loadPoleis() async {
    await tryOperation(
      () async {
        final poleis = await _polisQueryService.listPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Load computed members for a specific polis.
  Future<void> loadMembers(String polisRepoUrl) async {
    await tryOperation(
      () async {
        final members = await _polisQueryService.getPolisMembers(polisRepoUrl);
        return state.copyWith(
          status: UiFlowStatus.success,
          members: members,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 3: Create VoucherReviewState**

```dart
import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_review_state.freezed.dart';

@freezed
abstract class VoucherReviewState with _$VoucherReviewState implements IUiFlowState {
  const VoucherReviewState._();
  const factory VoucherReviewState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<FlagRecord> flaggedPosts,
  }) = _VoucherReviewState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;
}
```

**Step 4: Create VoucherReviewCubit**

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../services/i_voucher_review_service.dart';
import 'voucher_review_state.dart';

class VoucherReviewCubit extends AppCubit<VoucherReviewState> {
  final IVoucherReviewService _voucherReviewService;

  VoucherReviewCubit(this._voucherReviewService)
      : super(const VoucherReviewState());

  /// Load flagged posts by people the caller trusts.
  Future<void> loadFlaggedPosts() async {
    await tryOperation(
      () async {
        final flags = await _voucherReviewService.getFlaggedPostsByTrusted();
        return state.copyWith(
          status: UiFlowStatus.success,
          flaggedPosts: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
```

**Step 5: Run build_runner + verify**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs && dart analyze lib/features/agora/cubit/`

**Step 6: Commit**

```bash
git add achaean_flutter/lib/features/agora/cubit/
git commit -m "Add PolisDiscoveryCubit and VoucherReviewCubit"
```

---

## Task 10: DI Wiring + Exception Mapper + L10n

Wire everything into bootstrap.dart, update exception mapper, add l10n keys.

**Files:**
- Modify: `achaean_flutter/lib/app/bootstrap.dart`
- Modify: `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart`
- Modify: `achaean_flutter/lib/l10n/app_en.arb`

**Step 1: Update bootstrap.dart — add query service registrations**

Add imports at top:
```dart
import '../features/agora/services/i_post_reading_service.dart';
import '../features/agora/services/post_reading_service.dart';
import '../features/agora/services/i_agora_service.dart';
import '../features/agora/services/agora_service.dart';
import '../features/agora/services/i_polis_query_service.dart';
import '../features/agora/services/polis_query_service.dart';
import '../features/agora/services/i_user_query_service.dart';
import '../features/agora/services/user_query_service.dart';
import '../features/agora/services/i_voucher_review_service.dart';
import '../features/agora/services/voucher_review_service.dart';
import '../features/agora/cubit/agora_cubit.dart';
import '../features/agora/cubit/polis_discovery_cubit.dart';
import '../features/agora/cubit/voucher_review_cubit.dart';
```

Add registrations in `_registerCoreServices()` after the existing service registrations (these depend on `Client` being registered, so they should go in `bootstrap()` after the client is created, OR we can register them lazily):

Actually, since `Client` is registered in `bootstrap()` and `_registerCoreServices()` runs before client registration, these services need to be registered after the client. Add a new method `_registerQueryServices()` called after client registration in `bootstrap()`:

```dart
    // After client registration in bootstrap():
    _registerQueryServices();
```

```dart
void _registerQueryServices() {
  final client = getIt<Client>();

  // Post reading service (reads from foreign repos)
  getIt.registerLazySingleton<IPostReadingService>(
    () => PostReadingService(
      getIt<PublicGitClientFactory>(),
      GitHostType.forgejo, // Default host type for repo URL parsing
    ),
  );

  // Serverpod query services
  getIt.registerLazySingleton<IAgoraService>(
    () => AgoraService(client),
  );
  getIt.registerLazySingleton<IPolisQueryService>(
    () => PolisQueryService(client),
  );
  getIt.registerLazySingleton<IUserQueryService>(
    () => UserQueryService(client),
  );
  getIt.registerLazySingleton<IVoucherReviewService>(
    () => VoucherReviewService(client),
  );

  // Query cubits
  getIt.registerFactory<AgoraCubit>(
    () => AgoraCubit(
      getIt<IAgoraService>(),
      getIt<IPolisQueryService>(),
    ),
  );
  getIt.registerFactory<PolisDiscoveryCubit>(
    () => PolisDiscoveryCubit(getIt<IPolisQueryService>()),
  );
  getIt.registerFactory<VoucherReviewCubit>(
    () => VoucherReviewCubit(getIt<IVoucherReviewService>()),
  );
}
```

**Step 2: Update exception_mapper.dart**

Add import:
```dart
import '../../core/exceptions/query_exception.dart';
```

Add case in the `map` switch:
```dart
      QueryException() => const MessageKey.error('query.error'),
```

**Step 3: Update app_en.arb**

Add key:
```json
  "queryError": "Unable to load data. Check your connection and try again."
```

**Step 4: Update l10n_key_resolver**

Add the mapping for `query.error` → `queryError` in `l10n_key_resolver.g.dart` (or run the generator if available).

**Step 5: Run build_runner + verify**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs && dart analyze`

Expected: Full compilation success.

**Step 6: Commit**

```bash
git add achaean_flutter/lib/app/bootstrap.dart achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart achaean_flutter/lib/l10n/
git commit -m "Wire query services + cubits into DI, add QueryException mapping"
```

---

## Task 11: Final Verification

Ensure everything compiles across all packages.

**Step 1: Server compilation**

Run: `cd /Users/aicoder/Documents/achaean/achaean_server && dart pub get && dart analyze`

**Step 2: Client compilation**

Run: `cd /Users/aicoder/Documents/achaean/achaean_client && dart pub get && dart analyze`

**Step 3: Flutter compilation**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart pub get && dart run build_runner build --delete-conflicting-outputs && dart analyze`

**Step 4: Commit any remaining fixes**

If any compilation issues, fix and commit.

---

## Implementation Order

```
Task 1  (CryptoUtils)              — no deps, server-only
Task 2  (KoinonAuthHandler)        — depends on Task 1
Task 3  (Remove anonaccount server)— depends on Task 2
Task 4  (KoinonKeyManager + cleanup)— depends on Task 3 (client regen)
Task 5  (PostReadingService)       — independent of Tasks 1-4
Task 6  (AgoraService)             — independent
Task 7  (PolisQuery+User+Voucher)  — independent
Task 8  (AgoraCubit)               — depends on Tasks 6, 7
Task 9  (PolisDiscovery+Voucher)   — depends on Task 7
Task 10 (DI wiring)                — depends on all services/cubits
Task 11 (Final verification)       — last
```

Tasks 1-4 are sequential (auth pipeline). Tasks 5-7 can run in parallel. Tasks 8-9 depend on services. Task 10 wires everything. Task 11 verifies.

---

## Critical Files to Reference

| File | What to reference |
|------|-------------------|
| `achaean_flutter/lib/core/try_operation.dart` | `tryMethod()`, `requireNonNull()` for service methods |
| `achaean_flutter/lib/features/flag/cubit/flag_cubit.dart` | Cubit pattern: `AppCubit<S>`, `tryOperation()` |
| `achaean_flutter/lib/features/flag/cubit/flag_state.dart` | State pattern: freezed + `IUiFlowState` |
| `achaean_flutter/lib/features/flag/services/flag_service.dart` | Service pattern: `tryMethod()` wrapper |
| `achaean_flutter/lib/app/bootstrap.dart` | DI registration pattern |
| `achaean_flutter/lib/infrastructure/feedback/exception_mapper.dart` | Exception → MessageKey mapping |
| `achaean_client/lib/src/protocol/client.dart` | Generated Serverpod client: `client.koinon.*` methods |
| `achaean_server/lib/server.dart` | Serverpod init + auth handler registration |
| `anonaccount_server/.../crypto_utils.dart` | Source for CryptoUtils (ECDSA P-256 verification) |
| `anonaccount_server/.../auth_handler.dart` | Source for auth handler pattern |
