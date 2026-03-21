import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../exceptions/git_service_exception.dart';
import '../try_operation.dart';
import 'i_git_service.dart';

const _storageKey = 'achaean_git_credentials';

/// Factory function type for creating the right [IGitClient] by host type.
typedef GitClientFactory = IGitClient Function({
  required String baseUrl,
  required IGitAuth auth,
  required GitHostType hostType,
});

class GitService implements IGitService {
  final FlutterSecureStorage _storage;
  final GitClientFactory _clientFactory;
  IGitClient? _cachedClient;

  GitService(this._clientFactory, this._storage);

  @override
  Future<bool> isConfigured() {
    return tryMethod(
      () async {
        final json = await _storage.read(key: _storageKey);
        return json != null;
      },
      GitServiceException.new,
      'isConfigured',
    );
  }

  @override
  Future<IGitClient> getClient() {
    return tryMethod(
      () async {
        if (_cachedClient != null) return _cachedClient!;

        final raw = requireNonNull(
          await _storage.read(key: _storageKey),
          'git credentials',
          GitServiceException.new,
        );

        final creds = jsonDecode(raw) as Map<String, dynamic>;
        final hostType = GitHostType.values.byName(creds['hostType'] as String);

        final client = _clientFactory(
          baseUrl: creds['baseUrl'] as String,
          auth: _buildAuth(creds),
          hostType: hostType,
        );
        _cachedClient = client;
        return client;
      },
      GitServiceException.new,
      'getClient',
    );
  }

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

  @override
  Future<String?> getUsername() {
    return tryMethod(
      () async {
        final creds = await _readCredentials();
        return creds?['username'] as String?;
      },
      GitServiceException.new,
      'getUsername',
    );
  }

  @override
  Future<String?> getBaseUrl() {
    return tryMethod(
      () async {
        final creds = await _readCredentials();
        return creds?['baseUrl'] as String?;
      },
      GitServiceException.new,
      'getBaseUrl',
    );
  }

  @override
  Future<GitHostType?> getHostType() {
    return tryMethod(
      () async {
        final creds = await _readCredentials();
        final name = creds?['hostType'] as String?;
        if (name == null) return null;
        return GitHostType.values.byName(name);
      },
      GitServiceException.new,
      'getHostType',
    );
  }

  IGitAuth _buildAuth(Map<String, dynamic> creds) {
    final token = creds['token'] as String;
    final authType = creds['authType'] as String? ?? 'token';
    return switch (authType) {
      'bearer' => GitBearerAuth(token),
      _ => GitTokenAuth(token),
    };
  }

  Future<Map<String, dynamic>?> _readCredentials() async {
    final json = await _storage.read(key: _storageKey);
    if (json == null) return null;
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
