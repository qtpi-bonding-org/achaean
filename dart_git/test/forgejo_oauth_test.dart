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
