# OAuth Git Server Authentication

## Summary

Replace the hardcoded Forgejo URL and direct PAT registration with a user-facing git server connection flow. Two auth strategies: OAuth2 PKCE for connecting existing accounts (primary), and PAT registration for creating new accounts from inside the app (fallback). The app never handles passwords in the OAuth path.

## Problem

The app currently hardcodes `localhost:3000` as the Forgejo URL and uses `IGitRegistration` to create accounts via direct API calls. This doesn't work for real deployments, doesn't support GitHub/GitLab, and sends passwords through the app.

## Auth Strategies

### OAuth2 PKCE (primary)

For users who already have an account on their git server. No password touches the app.

**Convention:** Every Koinon-compatible git server registers an OAuth2 application with:
- `client_id = "achaean"`
- Redirect URI: `achaean://oauth-callback`
- PKCE enabled (no client secret needed)

**Flow:**
1. User enters git server URL (e.g. `https://git.beehaw.org`)
2. App generates `code_verifier` (128-char random string) and `code_challenge` (SHA256 of verifier, base64url-encoded)
3. App opens system browser to:
   ```
   {server}/login/oauth/authorize?
     client_id=achaean&
     redirect_uri=achaean://oauth-callback&
     response_type=code&
     code_challenge={challenge}&
     code_challenge_method=S256&
     state={random}
   ```
4. User logs in on git server web UI (if not already logged in)
5. User clicks "Authorize"
6. Browser redirects to `achaean://oauth-callback?code={code}&state={state}`
7. Flutter catches the deep link, verifies `state` matches
8. App calls `POST {server}/login/oauth/access_token` with:
   ```
   client_id=achaean&
   code={code}&
   code_verifier={verifier}&
   grant_type=authorization_code&
   redirect_uri=achaean://oauth-callback
   ```
9. Gets back `access_token` (and optionally `refresh_token`)
10. App stores token and server URL in secure storage
11. App fetches user info from `{server}/api/v1/user` to get username

**Forgejo/Gitea endpoints:**
- Authorize: `/login/oauth/authorize`
- Token: `/login/oauth/access_token`
- User info: `/api/v1/user` (with `Authorization: Bearer {token}`)

**GitHub endpoints (future):**
- Authorize: `https://github.com/login/oauth/authorize`
- Token: `https://github.com/login/oauth/access_token`
- User info: `https://api.github.com/user`

**GitLab endpoints (future):**
- Authorize: `{server}/oauth/authorize`
- Token: `{server}/oauth/token`
- User info: `{server}/api/v4/user`

### PAT Registration (fallback)

For creating new accounts from inside the app. Uses the existing `IGitRegistration` / `ForgejoRegistration` flow.

**Flow:**
1. User enters git server URL, username, email, password
2. App calls `POST {server}/api/v1/user/signup`
3. App creates a personal access token via `POST {server}/api/v1/users/{username}/tokens` with Basic Auth
4. App stores token and server URL

This flow stays as-is in `dart_git`. It's useful for:
- Self-hosted instances where the admin wants in-app registration
- CLI tools
- Testing

## Account Creation Screen

```
Git server URL:  [https://git.beehaw.org          ]

[Create Account]      ← opens {server}/user/sign_up in system browser
[Connect Account]     ← starts OAuth2 PKCE flow
```

**Create Account:** Opens the git server's signup page in the browser. User creates their account on the web, then comes back to the app and taps "Connect Account."

**Connect Account:** Starts the OAuth PKCE flow. User authorizes the app in the browser, gets redirected back, app gets a token.

After either flow succeeds, the app:
1. Stores the token and server URL in secure storage
2. Fetches the username from the API
3. Generates ECDSA P-256 keypair (if not already generated)
4. Scaffolds the koinon repo (if it doesn't exist)
5. Navigates to the home feed

## dart_git Changes

### New interface: `IGitOAuth`

```dart
abstract class IGitOAuth {
  /// Start the OAuth2 PKCE flow.
  /// Returns the URL to open in the browser.
  ({String url, String codeVerifier, String state}) buildAuthorizationUrl({
    required String serverUrl,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  });

  /// Exchange the authorization code for an access token.
  Future<GitCredentials> exchangeCode({
    required String serverUrl,
    required String code,
    required String codeVerifier,
    String clientId = 'achaean',
    String redirectUri = 'achaean://oauth-callback',
  });
}
```

### Existing interface: `IGitRegistration` (unchanged)

Stays as-is for PAT-based account creation. Rename references from "forge" to "git server" in docs/comments.

### New enum value: `GitHostType`

Add `gitlab` to the existing enum:
```dart
enum GitHostType { forgejo, gitea, codeberg, github, gitlab }
```

### Auth header change

OAuth tokens use `Authorization: Bearer {token}` instead of `Authorization: token {token}`. The `IGitAuth` system needs a `GitBearerAuth` implementation alongside the existing `GitTokenAuth`.

```dart
class GitBearerAuth implements IGitAuth {
  final String token;
  const GitBearerAuth(this.token);

  @override
  Map<String, String> get headers => {'Authorization': 'Bearer $token'};
}
```

## Flutter Changes

### Deep link handling

Register `achaean://` URL scheme:
- **iOS:** Add to `Info.plist` under `CFBundleURLSchemes`
- **Android:** Add intent filter in `AndroidManifest.xml`

Use `app_links` or `uni_links` package to listen for the OAuth callback.

### Secure storage

Store after successful auth:
- `achaean_git_server_url` — the server URL
- `achaean_git_token` — the access token
- `achaean_git_username` — the username
- `achaean_git_host_type` — forgejo/gitea/github/gitlab

On app launch, load these from secure storage to configure the git client.

### Scoping note

OAuth2 tokens from Forgejo currently have no scope restrictions — they can perform any action on behalf of the user. This is a Forgejo limitation, not something we control.

## Server Admin Setup

For a Koinon-compatible git server, the admin must:

1. Register an OAuth2 application:
   - Name: `Achaean`
   - Client ID: `achaean`
   - Redirect URI: `achaean://oauth-callback`
   - Confidential: No (PKCE, no client secret)

2. Enable self-registration (if users should be able to sign up)

3. Set up Serverpod system webhook (existing requirement)

## MVP Scope

For the Beehaw demo:
- Implement `ForgejoOAuth` (implements `IGitOAuth`) — Forgejo and Gitea use the same endpoints
- Deep link handling in Flutter
- Updated account creation screen with URL field + two buttons
- Store/load credentials from secure storage
- `GitBearerAuth` for OAuth tokens
- Add `gitlab` to `GitHostType` enum (implementation deferred)
- GitHub and GitLab OAuth implementations deferred

## What This Replaces

- Hardcoded `localhost:3000` in `injection_module.dart` — replaced by user-provided URL stored in secure storage
- `IGitRegistration` as the only auth path — OAuth becomes primary, PAT stays as fallback
- The `InjectionModule.gitRegistration` singleton — replaced by runtime configuration based on stored credentials
