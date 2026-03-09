import 'git_credentials.dart';
import 'git_host_type.dart';

/// Abstract interface for registering a new user account on a git host.
abstract class IGitRegistration {
  GitHostType get hostType;

  /// Register a new user account on a git host.
  /// Returns credentials (base URL, personal access token, username).
  Future<GitCredentials> register({
    required String username,
    required String email,
    required String password,
  });
}
