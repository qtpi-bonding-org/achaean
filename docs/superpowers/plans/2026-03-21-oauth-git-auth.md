# OAuth Git Server Authentication Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace hardcoded Forgejo URL with user-provided git server URL and add OAuth2 PKCE as the primary authentication flow, keeping PAT registration as fallback in dart_git.

**Architecture:** Two-layer change — dart_git gets `GitBearerAuth`, `IGitOAuth` interface, and `ForgejoOAuth` implementation (URL building, code exchange, username fetch); achaean_flutter uses `flutter_web_auth_2` to open the browser and catch the redirect, then passes the code to `ForgejoOAuth` for exchange. `GitService` learns to distinguish between PAT (`Authorization: token`) and OAuth (`Authorization: Bearer`) tokens via a stored `authType` field.

**Tech Stack:** Dart (`http`, `crypto` packages), Flutter (`flutter_web_auth_2`, `flutter_secure_storage`), OAuth2 PKCE (RFC 7636)

**Spec:** `docs/superpowers/specs/2026-03-21-oauth-git-auth-design.md`

**Note on PAT registration:** The spec says PAT registration stays as a fallback in dart_git (`IGitRegistration` / `ForgejoRegistration` are unchanged). The Flutter app removes the in-app PAT registration form — instead, "Create Account" opens the git server's signup page in the browser. After creating an account there, the user returns to the app and taps "Connect Account" (OAuth). This is the MVP scope per the spec.

**Note on `AccountCreationMessageMapper`:** The existing mapper checks `status == success && result != null` — this works with the new state shape unchanged.

**Why `flutter_web_auth_2` over `flutter_appauth`:** `flutter_web_auth_2` supports web, iOS, Android, macOS, Windows, and Linux. `flutter_appauth` is native-only (no web). `flutter_web_auth_2` is lighter (no native AppAuth SDK), opens the browser and returns the redirect URL — we parse the code and exchange it ourselves via `ForgejoOAuth`. This keeps the OAuth logic in dart_git (portable to CLI).

---

## File Structure

### dart_git (package)

| File | Action | Responsibility |
|------|--------|---------------|
| `lib/src/client/i_git_auth.dart` | Modified (Task 1 ✅) | `GitBearerAuth` class added |
| `lib/src/client/git_host_type.dart` | Modify | Add `gitlab` enum value |
| `lib/src/client/i_git_oauth.dart` | Create | `IGitOAuth` interface |
| `lib/src/forgejo/forgejo_oauth.dart` | Create | Forgejo/Gitea OAuth2 PKCE implementation |
| `lib/dart_git.dart` | Modify | Export new files |
| `test/forgejo_oauth_test.dart` | Create | Test OAuth URL building and code exchange |

### achaean_flutter (app)

| File | Action | Responsibility |
|------|--------|---------------|
| `lib/core/services/git_service.dart` | Modify | Support `authType` (token vs bearer) in credential storage/retrieval |
| `lib/core/services/i_git_service.dart` | Modify | Add `authType` parameter to `configure()` |
| `lib/features/account_creation/screens/account_creation_screen.dart` | Rewrite | URL field + "Create Account" (browser) + "Connect Account" (OAuth) |
| `lib/features/account_creation/cubit/account_creation_cubit.dart` | Rewrite | `connectAccount()` method — calls flutter_web_auth_2, then ForgejoOAuth |
| `lib/features/account_creation/cubit/account_creation_state.dart` | Modify | Add `serverUrl` field |
| `lib/features/account_creation/services/i_account_creation_service.dart` | Rewrite | `connectViaOAuth()` method |
| `lib/features/account_creation/services/account_creation_service.dart` | Rewrite | OAuth connection flow using ForgejoOAuth |
| `lib/app/injection_module.dart` | Modify | Remove hardcoded `localhost:3000` |
| `lib/app/bootstrap.dart` | Modify | Register `IGitOAuth`, update wiring |
| `lib/l10n/app_en.arb` | Modify | Add new localization strings |
| `pubspec.yaml` | Modify | Add `flutter_web_auth_2` dependency |
| `ios/Runner/Info.plist` | Modify | Add `achaean://` URL scheme (required by flutter_web_auth_2) |
| `android/app/build.gradle` | Modify | Add `appAuthRedirectScheme` manifest placeholder |

---

## Tasks

### Task 1: Add `GitBearerAuth` to dart_git — ✅ COMPLETE

Already implemented and committed.

---

### Task 2: Create `IGitOAuth` interface and `ForgejoOAuth` implementation

**Files:**
- Create: `dart_git/lib/src/client/i_git_oauth.dart`
- Create: `dart_git/lib/src/forgejo/forgejo_oauth.dart`
- Modify: `dart_git/lib/dart_git.dart`
- Modify: `dart_git/pubspec.yaml`
- Modify: root `pubspec.yaml` (workspace)
- Create: `dart_git/test/forgejo_oauth_test.dart`

- [ ] **Step 1: Write the tests**

Create `dart_git/test/forgejo_oauth_test.dart`:

```dart
import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  const serverUrl = 'https://git.example.com';

  group('ForgejoOAuth.buildAuthorizationUrl', () {
    test('returns correct URL with PKCE parameters', () {
      final oauth = ForgejoOAuth();
      final result = oauth.buildAuthorizationUrl(serverUrl: serverUrl);

      final uri = Uri.parse(result.url);
      expect(uri.scheme, 'https');
      expect(uri.host, 'git.example.com');
      expect(uri.path, '/login/oauth/authorize');
      expect(uri.queryParameters['client_id'], 'achaean');
      expect(uri.queryParameters['redirect_uri'], 'achaean://oauth-callback');
      expect(uri.queryParameters['response_type'], 'code');
      expect(uri.queryParameters['code_challenge_method'], 'S256');
      expect(uri.queryParameters['code_challenge'], isNotEmpty);
      expect(uri.queryParameters['state'], isNotEmpty);

      // code_verifier should be 128 chars
      expect(result.codeVerifier.length, 128);
      // state should be non-empty
      expect(result.state, isNotEmpty);
      // state in URL should match returned state
      expect(uri.queryParameters['state'], result.state);
    });

    test('uses custom client_id and redirect_uri', () {
      final oauth = ForgejoOAuth();
      final result = oauth.buildAuthorizationUrl(
        serverUrl: serverUrl,
        clientId: 'custom-app',
        redirectUri: 'custom://callback',
      );

      final uri = Uri.parse(result.url);
      expect(uri.queryParameters['client_id'], 'custom-app');
      expect(uri.queryParameters['redirect_uri'], 'custom://callback');
    });
  });

  group('ForgejoOAuth.exchangeCode', () {
    test('exchanges code for credentials', () async {
      final oauth = ForgejoOAuth(
        httpClient: MockClient((req) async {
          // exchangeCode internally calls fetchUsername, so handle both requests
          if (req.url.path == '/login/oauth/access_token') {
            expect(req.method, 'POST');
            expect(req.headers['Accept'], 'application/json');

            final body = Uri.splitQueryString(req.body);
            expect(body['client_id'], 'achaean');
            expect(body['code'], 'auth-code-123');
            expect(body['code_verifier'], 'my-verifier');
            expect(body['grant_type'], 'authorization_code');
            expect(body['redirect_uri'], 'achaean://oauth-callback');

            return http.Response(
              jsonEncode({
                'access_token': 'oauth-access-token',
                'token_type': 'bearer',
                'refresh_token': 'oauth-refresh-token',
              }),
              200,
            );
          } else if (req.url.path == '/api/v1/user') {
            expect(req.method, 'GET');
            expect(req.headers['Authorization'], 'Bearer oauth-access-token');
            return http.Response(
              jsonEncode({'login': 'testuser'}),
              200,
            );
          }
          throw Exception('Unexpected request: ${req.method} ${req.url}');
        }),
      );

      final creds = await oauth.exchangeCode(
        serverUrl: serverUrl,
        code: 'auth-code-123',
        codeVerifier: 'my-verifier',
      );

      expect(creds.token, 'oauth-access-token');
      expect(creds.baseUrl, serverUrl);
      expect(creds.username, 'testuser');
      expect(creds.hostType, GitHostType.forgejo);
    });

    test('throws on non-200 response', () async {
      final oauth = ForgejoOAuth(
        httpClient: MockClient(
          (_) async => http.Response('{"error": "bad_code"}', 400),
        ),
      );

      expect(
        () => oauth.exchangeCode(
          serverUrl: serverUrl,
          code: 'bad',
          codeVerifier: 'v',
        ),
        throwsA(isA<GitUnexpectedException>()),
      );
    });
  });

  group('ForgejoOAuth.fetchUsername', () {
    test('fetches username from user API', () async {
      final oauth = ForgejoOAuth(
        httpClient: MockClient((req) async {
          expect(req.method, 'GET');
          expect(req.url.toString(), '$serverUrl/api/v1/user');
          expect(req.headers['Authorization'], 'Bearer my-token');

          return http.Response(
            jsonEncode({'login': 'testuser'}),
            200,
          );
        }),
      );

      final username =
          await oauth.fetchUsername(serverUrl: serverUrl, token: 'my-token');
      expect(username, 'testuser');
    });
  });
}
```

- [ ] **Step 2: Run tests to verify they fail**

Run: `cd /Users/aicoder/Documents/achaean/dart_git && dart test test/forgejo_oauth_test.dart`
Expected: Compilation error — `ForgejoOAuth` not found

- [ ] **Step 3: Create `IGitOAuth` interface**

Create `dart_git/lib/src/client/i_git_oauth.dart`:

```dart
import 'git_credentials.dart';

/// OAuth2 PKCE authentication for git servers.
abstract class IGitOAuth {
  /// Build the authorization URL to open in the browser.
  ///
  /// Returns the URL, the PKCE code verifier (keep secret, needed for
  /// token exchange), and the state parameter (verify on callback).
  ({String url, String codeVerifier, String state}) buildAuthorizationUrl({
    required String serverUrl,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  });

  /// Exchange the authorization code for an access token.
  ///
  /// Call this after the OAuth callback redirect with the code from the URL.
  /// The [codeVerifier] must be the same one returned by [buildAuthorizationUrl].
  Future<GitCredentials> exchangeCode({
    required String serverUrl,
    required String code,
    required String codeVerifier,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  });

  /// Fetch the authenticated user's username from the git server API.
  Future<String> fetchUsername({
    required String serverUrl,
    required String token,
  });
}
```

- [ ] **Step 4: Create `ForgejoOAuth` implementation**

Create `dart_git/lib/src/forgejo/forgejo_oauth.dart`:

```dart
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import '../client/git_credentials.dart';
import '../client/git_exception.dart';
import '../client/git_host_type.dart';
import '../client/i_git_oauth.dart';

/// Forgejo/Gitea implementation of [IGitOAuth] using OAuth2 PKCE.
class ForgejoOAuth implements IGitOAuth {
  final http.Client httpClient;

  ForgejoOAuth({http.Client? httpClient})
      : httpClient = httpClient ?? http.Client();

  @override
  ({String url, String codeVerifier, String state}) buildAuthorizationUrl({
    required String serverUrl,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  }) {
    final codeVerifier = _generateCodeVerifier();
    final codeChallenge = _computeCodeChallenge(codeVerifier);
    final state = _generateState();

    final uri = Uri.parse('$serverUrl/login/oauth/authorize').replace(
      queryParameters: {
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'response_type': 'code',
        'code_challenge': codeChallenge,
        'code_challenge_method': 'S256',
        'state': state,
      },
    );

    return (url: uri.toString(), codeVerifier: codeVerifier, state: state);
  }

  @override
  Future<GitCredentials> exchangeCode({
    required String serverUrl,
    required String code,
    required String codeVerifier,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  }) async {
    final response = await httpClient.post(
      Uri.parse('$serverUrl/login/oauth/access_token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: Uri(queryParameters: {
        'client_id': clientId,
        'code': code,
        'code_verifier': codeVerifier,
        'grant_type': 'authorization_code',
        'redirect_uri': redirectUri,
      }).query,
    );

    if (response.statusCode != 200) {
      throw GitUnexpectedException(
        'OAuth token exchange failed',
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final accessToken = json['access_token'] as String;

    final username = await fetchUsername(
      serverUrl: serverUrl,
      token: accessToken,
    );

    return GitCredentials(
      baseUrl: serverUrl,
      token: accessToken,
      username: username,
      hostType: GitHostType.forgejo,
    );
  }

  @override
  Future<String> fetchUsername({
    required String serverUrl,
    required String token,
  }) async {
    final response = await httpClient.get(
      Uri.parse('$serverUrl/api/v1/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw GitUnexpectedException(
        'Failed to fetch user info',
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return json['login'] as String;
  }

  String _generateCodeVerifier() {
    const charset =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    final random = Random.secure();
    return List.generate(128, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _computeCodeChallenge(String verifier) {
    final bytes = utf8.encode(verifier);
    final digest = sha256.convert(bytes);
    return base64Url.encode(digest.bytes).replaceAll('=', '');
  }

  String _generateState() {
    final random = Random.secure();
    final bytes = List.generate(32, (_) => random.nextInt(256));
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}
```

- [ ] **Step 5: Add `crypto` dependency to dart_git and workspace root**

Add to `dart_git/pubspec.yaml` under `dependencies`:

```yaml
  crypto: ^3.0.3
```

Add to root `/Users/aicoder/Documents/achaean/pubspec.yaml` under `dependency_overrides`:

```yaml
  crypto: ^3.0.3
```

Run: `cd /Users/aicoder/Documents/achaean/dart_git && dart pub get`

- [ ] **Step 6: Export new files from `dart_git.dart`**

Add to `dart_git/lib/dart_git.dart` after the `i_git_registration.dart` export:

```dart
export 'src/client/i_git_oauth.dart';
```

After the `forgejo_registration.dart` export:

```dart
export 'src/forgejo/forgejo_oauth.dart';
```

- [ ] **Step 7: Run all tests to verify they pass**

Run: `cd /Users/aicoder/Documents/achaean/dart_git && dart test`
Expected: All tests pass (existing + new OAuth tests)

- [ ] **Step 8: Commit**

```bash
cd /Users/aicoder/Documents/achaean && git add dart_git/ pubspec.yaml
git commit -m "feat(dart_git): add IGitOAuth interface and ForgejoOAuth implementation"
```

---

### Task 3: Update `GitService` to support Bearer auth

**Files:**
- Modify: `achaean_flutter/lib/core/services/i_git_service.dart`
- Modify: `achaean_flutter/lib/core/services/git_service.dart`

- [ ] **Step 1: Add `authType` parameter to `IGitService.configure()`**

In `achaean_flutter/lib/core/services/i_git_service.dart`, update the `configure()` signature:

```dart
  Future<void> configure({
    required String baseUrl,
    required String token,
    required String username,
    required GitHostType hostType,
    String authType = 'token',
  });
```

- [ ] **Step 2: Update `GitService` to store and use `authType`**

In `achaean_flutter/lib/core/services/git_service.dart`:

Update `configure()` to accept and store `authType`:

```dart
  @override
  Future<void> configure({
    required String baseUrl,
    required String token,
    required String username,
    required GitHostType hostType,
    String authType = 'token',
  }) {
    return tryMethod(
      () async {
        final json = jsonEncode({
          'baseUrl': baseUrl,
          'token': token,
          'username': username,
          'hostType': hostType.name,
          'authType': authType,
        });
        await _storage.write(key: _storageKey, value: json);
        _cachedClient = null;
      },
      GitServiceException.new,
      'configure',
    );
  }
```

In `getClient()`, change `auth: GitTokenAuth(creds['token'] as String),` to `auth: _buildAuth(creds),`.

Add this private method to the class:

```dart
  IGitAuth _buildAuth(Map<String, dynamic> creds) {
    final token = creds['token'] as String;
    final authType = creds['authType'] as String? ?? 'token';
    return switch (authType) {
      'bearer' => GitBearerAuth(token),
      _ => GitTokenAuth(token),
    };
  }
```

- [ ] **Step 3: Verify the app still compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter analyze --no-fatal-infos`
Expected: No errors

- [ ] **Step 4: Commit**

```bash
cd /Users/aicoder/Documents/achaean && git add achaean_flutter/lib/core/services/git_service.dart achaean_flutter/lib/core/services/i_git_service.dart
git commit -m "feat(achaean_flutter): support bearer auth type in GitService credentials"
```

---

### Task 4: Update injection, bootstrap, and account creation service for OAuth

Atomic task — all changes must happen together because they're interdependent.

**Files:**
- Modify: `achaean_flutter/lib/app/injection_module.dart`
- Modify: `achaean_flutter/lib/app/bootstrap.dart`
- Rewrite: `achaean_flutter/lib/features/account_creation/services/i_account_creation_service.dart`
- Rewrite: `achaean_flutter/lib/features/account_creation/services/account_creation_service.dart`
- Modify: `dart_git/lib/src/client/git_host_type.dart`

- [ ] **Step 1: Add `gitlab` to `GitHostType` enum**

Change `dart_git/lib/src/client/git_host_type.dart` from:

```dart
enum GitHostType { forgejo, gitea, codeberg, github }
```

to:

```dart
enum GitHostType { forgejo, gitea, codeberg, github, gitlab }
```

- [ ] **Step 2: Remove hardcoded `IGitRegistration` from `InjectionModule`**

Replace the entire content of `achaean_flutter/lib/app/injection_module.dart`:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Registers third-party dependencies that injectable can't auto-discover.
@module
abstract class InjectionModule {
  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
```

- [ ] **Step 3: Update `IAccountCreationService` interface**

Replace `achaean_flutter/lib/features/account_creation/services/i_account_creation_service.dart`:

```dart
import '../models/account_creation_result.dart';

/// Orchestrates account connection flows.
abstract class IAccountCreationService {
  /// Run the full OAuth flow: open browser, exchange code, configure git, scaffold repo.
  /// [serverUrl] is the git server base URL (e.g. https://git.beehaw.org).
  /// [callbackUrlScheme] is the URL scheme registered for the OAuth callback (default: achaean).
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    String callbackUrlScheme = 'achaean',
  });
}
```

- [ ] **Step 4: Update `AccountCreationService` implementation**

Replace `achaean_flutter/lib/features/account_creation/services/account_creation_service.dart`:

```dart
import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../../../core/exceptions/account_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_key_service.dart';
import '../../../core/try_operation.dart';
import '../models/account_creation_result.dart';
import 'i_account_creation_service.dart';

class AccountCreationService implements IAccountCreationService {
  final IKeyService _keyService;
  final IGitOAuth _oauth;
  final IGitService _gitService;

  AccountCreationService(this._keyService, this._oauth, this._gitService);

  @override
  Future<AccountCreationResult> connectViaOAuth({
    required String serverUrl,
    String callbackUrlScheme = 'achaean',
  }) {
    return tryMethod(
      () async {
        // 1. Build OAuth URL with PKCE
        final authResult = _oauth.buildAuthorizationUrl(
          serverUrl: serverUrl,
          redirectUri: '$callbackUrlScheme://oauth-callback',
        );

        // 2. Open browser and wait for redirect
        final resultUrl = await FlutterWebAuth2.authenticate(
          url: authResult.url,
          callbackUrlScheme: callbackUrlScheme,
        );

        // 3. Parse code and state from redirect URL
        final uri = Uri.parse(resultUrl);
        final code = uri.queryParameters['code'];
        final returnedState = uri.queryParameters['state'];

        if (code == null) {
          throw AccountException('OAuth callback missing authorization code', 'connectViaOAuth');
        }
        if (returnedState != authResult.state) {
          throw AccountException('OAuth state mismatch — possible CSRF attack', 'connectViaOAuth');
        }

        // 4. Exchange code for credentials
        final credentials = await _oauth.exchangeCode(
          serverUrl: serverUrl,
          code: code,
          codeVerifier: authResult.codeVerifier,
          redirectUri: '$callbackUrlScheme://oauth-callback',
        );

        // 5. Configure git service with OAuth credentials (bearer auth)
        await _gitService.configure(
          baseUrl: credentials.baseUrl,
          token: credentials.token,
          username: credentials.username,
          hostType: credentials.hostType,
          authType: 'bearer',
        );

        // 6. Generate and store keypair (if not already generated)
        final hasKeypair = await _keyService.hasKeypair();
        final pubkeyHex = hasKeypair
            ? (await _keyService.getPublicKeyHex())!
            : await _keyService.generateAndStoreKeypair();

        // 7. Scaffold Koinon repo
        final client = await _gitService.getClient();
        final repoName = 'koinon';
        final repoHttps =
            '${credentials.baseUrl}/${credentials.username}/$repoName';

        final repo = await RepoScaffolder(client).scaffold(
          repoName: repoName,
          pubkey: pubkeyHex,
          repoHttps: repoHttps,
        );

        return AccountCreationResult(
          pubkeyHex: pubkeyHex,
          repoOwner: repo.owner,
          repoName: repo.name,
          repoUrl: repo.htmlUrl,
        );
      },
      AccountException.new,
      'connectViaOAuth',
    );
  }
}
```

- [ ] **Step 5: Update bootstrap wiring**

In `achaean_flutter/lib/app/bootstrap.dart`:

In `_registerCoreServices()`, add after the `IKeyService` registration:

```dart
  // OAuth service (Forgejo/Gitea PKCE flow)
  getIt.registerLazySingleton<IGitOAuth>(
    () => ForgejoOAuth(),
  );
```

Update the `IAccountCreationService` registration from:

```dart
  getIt.registerLazySingleton<IAccountCreationService>(
    () => AccountCreationService(
      getIt<IKeyService>(),
      getIt<IGitRegistration>(),
      getIt<IGitService>(),
    ),
  );
```

to:

```dart
  getIt.registerLazySingleton<IAccountCreationService>(
    () => AccountCreationService(
      getIt<IKeyService>(),
      getIt<IGitOAuth>(),
      getIt<IGitService>(),
    ),
  );
```

Update the `GitClientFactory` switch to handle `gitlab`:

```dart
    return switch (hostType) {
      GitHostType.forgejo ||
      GitHostType.gitea ||
      GitHostType.codeberg =>
        ForgejoClient(baseUrl: baseUrl, auth: auth),
      GitHostType.github => throw UnimplementedError('GitHub support coming'),
      GitHostType.gitlab => throw UnimplementedError('GitLab support coming'),
    };
```

- [ ] **Step 6: Add `flutter_web_auth_2` dependency**

Add to `achaean_flutter/pubspec.yaml` under `dependencies`:

```yaml
  flutter_web_auth_2: ^4.0.1
```

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter pub get`

- [ ] **Step 7: Regenerate injectable code**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs`
Expected: Regenerates `bootstrap.config.dart` without the old `IGitRegistration` provider

- [ ] **Step 8: Verify it compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter analyze --no-fatal-infos`
Expected: Errors only in cubit and screen files (still calling old `createAccount()`) — fixed in Task 5.

- [ ] **Step 9: Commit**

```bash
cd /Users/aicoder/Documents/achaean && git add dart_git/lib/src/client/git_host_type.dart achaean_flutter/lib/app/ achaean_flutter/lib/features/account_creation/services/ achaean_flutter/pubspec.yaml achaean_flutter/pubspec.lock
git commit -m "feat(achaean_flutter): wire OAuth into account creation service and bootstrap"
```

---

### Task 5: Update cubit, state, screen, and platform config for OAuth flow

Atomic task — cubit, state, and screen reference each other.

**Files:**
- Modify: `achaean_flutter/lib/features/account_creation/cubit/account_creation_state.dart`
- Rewrite: `achaean_flutter/lib/features/account_creation/cubit/account_creation_cubit.dart`
- Rewrite: `achaean_flutter/lib/features/account_creation/screens/account_creation_screen.dart`
- Modify: `achaean_flutter/lib/l10n/app_en.arb`
- Modify: `achaean_flutter/ios/Runner/Info.plist`
- Modify: `achaean_flutter/android/app/build.gradle` (or `build.gradle.kts`)

- [ ] **Step 1: Add localization strings**

Add these entries to `achaean_flutter/lib/l10n/app_en.arb` (before the closing `}`):

```json
  "accountCreationConnectTitle": "Connect to Git Server",
  "labelGitServerUrl": "Git server URL",
  "accountCreationConnect": "Connect Account",
  "accountCreationSignup": "Create Account",
  "accountCreationConnecting": "Connecting...",
  "accountCreationUrlHint": "https://git.example.com"
```

- [ ] **Step 2: Update state — add `serverUrl` field**

Replace `achaean_flutter/lib/features/account_creation/cubit/account_creation_state.dart`:

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/account_creation_result.dart';

part 'account_creation_state.freezed.dart';

@freezed
abstract class AccountCreationState with _$AccountCreationState implements IUiFlowState {
  const AccountCreationState._();
  const factory AccountCreationState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    AccountCreationResult? result,
  }) = _AccountCreationState;

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

Note: The state shape is unchanged from the original — `flutter_web_auth_2` handles the browser flow synchronously (from the caller's perspective), so no pending PKCE fields needed.

- [ ] **Step 3: Rewrite cubit**

Replace `achaean_flutter/lib/features/account_creation/cubit/account_creation_cubit.dart`:

```dart
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_account_creation_service.dart';
import 'account_creation_state.dart';

class AccountCreationCubit extends AppCubit<AccountCreationState> {
  final IAccountCreationService _service;

  AccountCreationCubit(this._service)
      : super(const AccountCreationState());

  /// Run the full OAuth flow: opens browser, exchanges code, scaffolds repo.
  Future<void> connectAccount(String serverUrl) async {
    final normalized = _normalizeUrl(serverUrl);
    await tryOperation(
      () async {
        final result = await _service.connectViaOAuth(
          serverUrl: normalized,
        );
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Open the git server's signup page in the browser.
  Future<void> openSignupPage(String serverUrl) async {
    final normalized = _normalizeUrl(serverUrl);
    await launchUrl(
      Uri.parse('$normalized/user/sign_up'),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Normalize URL: trim, ensure https:// prefix, remove trailing slash.
  String _normalizeUrl(String url) {
    var normalized = url.trim();
    if (!normalized.startsWith('http://') &&
        !normalized.startsWith('https://')) {
      normalized = 'https://$normalized';
    }
    if (normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return normalized;
  }
}
```

- [ ] **Step 4: Rewrite the screen**

Replace `achaean_flutter/lib/features/account_creation/screens/account_creation_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../app_router.dart';
import '../../../design_system/primitives/app_sizes.dart';
import '../../../design_system/widgets/ui_flow_listener.dart';
import '../../../l10n/app_localizations.dart';
import '../cubit/account_creation_cubit.dart';
import '../cubit/account_creation_state.dart';
import '../services/account_creation_message_mapper.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => GetIt.instance<AccountCreationCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.accountCreationConnectTitle)),
        body: UiFlowListener<AccountCreationCubit, AccountCreationState>(
          mapper: GetIt.instance<AccountCreationMessageMapper>(),
          listener: (context, state) {
            if (state.result != null) {
              AppRouter.setHasAccount(true);
              AppNavigation.toHome(context);
            }
          },
          child: BlocBuilder<AccountCreationCubit, AccountCreationState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(AppSizes.space * 2),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          labelText: l10n.labelGitServerUrl,
                          hintText: l10n.accountCreationUrlHint,
                        ),
                        keyboardType: TextInputType.url,
                        autocorrect: false,
                        validator: (v) =>
                            v == null || v.trim().isEmpty
                                ? l10n.validationRequired
                                : null,
                      ),
                      SizedBox(height: AppSizes.space * 3),
                      FilledButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AccountCreationCubit>()
                                      .connectAccount(
                                        _urlController.text,
                                      );
                                }
                              },
                        child: Text(
                          state.isLoading
                              ? l10n.accountCreationConnecting
                              : l10n.accountCreationConnect,
                        ),
                      ),
                      SizedBox(height: AppSizes.space),
                      OutlinedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context
                                      .read<AccountCreationCubit>()
                                      .openSignupPage(
                                        _urlController.text,
                                      );
                                }
                              },
                        child: Text(l10n.accountCreationSignup),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Add `url_launcher` dependency**

Add to `achaean_flutter/pubspec.yaml` under `dependencies`:

```yaml
  url_launcher: ^6.2.5
```

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter pub get`

- [ ] **Step 6: Register `achaean://` URL scheme on iOS**

In `achaean_flutter/ios/Runner/Info.plist`, add inside the top-level `<dict>`, before `</dict>`:

```xml
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>com.qtpibonding.achaean</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>achaean</string>
			</array>
		</dict>
	</array>
```

- [ ] **Step 7: Register callback scheme on Android**

Check if the build file is `build.gradle` or `build.gradle.kts` at `achaean_flutter/android/app/`. In the `defaultConfig` block, add:

For `build.gradle`:
```groovy
manifestPlaceholders = [appAuthRedirectScheme: 'achaean']
```

For `build.gradle.kts`:
```kotlin
manifestPlaceholders["appAuthRedirectScheme"] = "achaean"
```

- [ ] **Step 8: Regenerate freezed code**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 9: Verify it compiles**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter analyze --no-fatal-infos`
Expected: No errors

- [ ] **Step 10: Commit**

```bash
cd /Users/aicoder/Documents/achaean && git add achaean_flutter/
git commit -m "feat(achaean_flutter): OAuth account creation screen with flutter_web_auth_2"
```

---

### Task 6: End-to-end verification

- [ ] **Step 1: Run full dart_git test suite**

Run: `cd /Users/aicoder/Documents/achaean/dart_git && dart test`
Expected: All tests pass

- [ ] **Step 2: Run Flutter analyze**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter analyze --no-fatal-infos`
Expected: No errors

- [ ] **Step 3: Run build_runner**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && dart run build_runner build --delete-conflicting-outputs`
Expected: No errors

- [ ] **Step 4: Re-run analyze after codegen**

Run: `cd /Users/aicoder/Documents/achaean/achaean_flutter && flutter analyze --no-fatal-infos`
Expected: No errors

- [ ] **Step 5: Final commit if any generated files changed**

```bash
cd /Users/aicoder/Documents/achaean && git status
# Only commit if there are changes
git add -A && git commit -m "chore: regenerate build_runner output for OAuth changes"
```
