import 'package:dart_koinon/dart_koinon.dart';

abstract class IFlagService {
  /// Flag a post in a polis. Adds FlagEntry to koinon.json.
  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  });

  /// Retract a flag. Removes matching FlagEntry from koinon.json.
  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  });

  /// Get own flags from koinon.json.
  Future<List<FlagEntry>> getOwnFlags();
}
