import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'i_secure_storage.dart';

/// Typed accessors for all secure app preferences.
///
/// Centralizes storage keys and provides type-safe read/write
/// for git credentials, keypair, and server configuration.
class SecurePreferences {
  final ISecureStorage _storage;

  const SecurePreferences(this._storage);

  // ── Storage keys (private) ──────────────────────────────────
  static const _gitCredentials = 'achaean_git_credentials';
  static const _keypairJwk = 'achaean_jwk_set';
  static const _indexServerUrl = 'achaean_index_server_url';

  // ── Index server ────────────────────────────────────────────

  Future<String?> getIndexServerUrl() => _storage.read(_indexServerUrl);

  Future<void> setIndexServerUrl(String url) =>
      _storage.write(_indexServerUrl, url);

  // ── Git credentials ─────────────────────────────────────────

  Future<Map<String, dynamic>?> getGitCredentials() async {
    final json = await _storage.read(_gitCredentials);
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }

  Future<void> setGitCredentials({
    required String baseUrl,
    required String token,
    required String username,
    required GitHostType hostType,
    String authType = 'token',
  }) =>
      _storage.write(
        _gitCredentials,
        jsonEncode({
          'baseUrl': baseUrl,
          'token': token,
          'username': username,
          'hostType': hostType.name,
          'authType': authType,
        }),
      );

  Future<bool> hasGitCredentials() => _storage.containsKey(_gitCredentials);

  // ── Keypair ─────────────────────────────────────────────────

  Future<String?> getKeypairJwk() => _storage.read(_keypairJwk);

  Future<void> setKeypairJwk(String jwk) =>
      _storage.write(_keypairJwk, jwk);

  Future<bool> hasKeypair() => _storage.containsKey(_keypairJwk);
}
