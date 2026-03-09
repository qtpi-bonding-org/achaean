import 'dart:convert';

import 'package:http/http.dart' as http;

import '../client/git_credentials.dart';
import '../client/git_exception.dart';
import '../client/git_host_type.dart';
import '../client/i_git_registration.dart';

/// Forgejo implementation of [IGitRegistration].
///
/// Uses Forgejo REST API for self-registration:
/// 1. POST /api/v1/user/signup — register new user
/// 2. POST /api/v1/users/{username}/tokens — create personal access token
class ForgejoRegistration implements IGitRegistration {
  final String baseUrl;
  final http.Client httpClient;

  ForgejoRegistration({
    required this.baseUrl,
    http.Client? httpClient,
  }) : httpClient = httpClient ?? http.Client();

  @override
  GitHostType get hostType => GitHostType.forgejo;

  @override
  Future<GitCredentials> register({
    required String username,
    required String email,
    required String password,
  }) async {
    // 1. Register user via self-registration endpoint
    final signupResponse = await httpClient.post(
      Uri.parse('$baseUrl/api/v1/user/signup'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (signupResponse.statusCode != 201) {
      throw GitUnexpectedException(
        'Registration failed',
        statusCode: signupResponse.statusCode,
        body: signupResponse.body,
      );
    }

    // 2. Create personal access token using basic auth
    final basicAuth = base64Encode(utf8.encode('$username:$password'));
    final tokenResponse = await httpClient.post(
      Uri.parse('$baseUrl/api/v1/users/$username/tokens'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Basic $basicAuth',
      },
      body: jsonEncode({
        'name': 'achaean-${DateTime.now().millisecondsSinceEpoch}',
        'scopes': ['all'],
      }),
    );

    if (tokenResponse.statusCode != 201) {
      throw GitUnexpectedException(
        'Token creation failed',
        statusCode: tokenResponse.statusCode,
        body: tokenResponse.body,
      );
    }

    final tokenJson =
        jsonDecode(tokenResponse.body) as Map<String, dynamic>;
    final token = tokenJson['sha1'] as String;

    return GitCredentials(
      baseUrl: baseUrl,
      token: token,
      username: username,
      hostType: GitHostType.forgejo,
    );
  }
}
