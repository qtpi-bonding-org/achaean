import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for agora data (post references + flags).
abstract class IAgoraService {
  /// Get post references for a polis agora.
  Future<List<PostReference>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  });

  /// Get post references from trusted authors (personal feed).
  Future<List<PostReference>> getPersonalFeed({
    int limit = 50,
    int offset = 0,
  });

  /// Get all flags for posts in a polis.
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl);
}
