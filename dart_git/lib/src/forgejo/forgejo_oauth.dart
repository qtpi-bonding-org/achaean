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
