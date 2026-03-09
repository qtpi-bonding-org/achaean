import 'git_host_type.dart';

/// Credentials returned after registering with a git host.
class GitCredentials {
  final String baseUrl;
  final String token;
  final String username;
  final GitHostType hostType;

  const GitCredentials({
    required this.baseUrl,
    required this.token,
    required this.username,
    required this.hostType,
  });
}
