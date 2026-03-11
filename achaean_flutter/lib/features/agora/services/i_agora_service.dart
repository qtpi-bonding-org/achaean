import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for agora data (post references + flags).
abstract class IAgoraService {
  /// Get cached posts for a polis agora.
  Future<List<CachedPost>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  });

  /// Get all flags for posts in a polis.
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl);
}
