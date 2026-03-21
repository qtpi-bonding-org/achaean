import 'package:dart_git/dart_git.dart';

/// Manages [IGitClient] lifecycle with stored credentials.
///
/// Git-host-agnostic — the user can switch hosts at runtime without losing
/// their identity (keypair stays the same, only the git host changes).
abstract class IGitService {
  Future<bool> isConfigured();
  Future<IGitClient> getClient();
  Future<void> configure({
    required String baseUrl,
    required String token,
    required String username,
    required GitHostType hostType,
    String authType = 'token',
  });
  Future<String?> getUsername();
  Future<String?> getBaseUrl();
  Future<GitHostType?> getHostType();
}
