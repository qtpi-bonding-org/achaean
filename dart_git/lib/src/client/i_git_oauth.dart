import 'git_credentials.dart';

/// OAuth2 PKCE authentication for git servers.
abstract class IGitOAuth {
  /// Build the authorization URL to open in the browser.
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

  /// Fetch the authenticated user's username from the git server API.
  Future<String> fetchUsername({
    required String serverUrl,
    required String token,
  });
}
