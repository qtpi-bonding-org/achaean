import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';

abstract class IObserveService {
  /// Declare observe for a subject. Commits observe/[subject-pubkey-prefix].json.
  Future<void> declareObserve({
    required String subjectPubkey,
    required String subjectRepo,
  });

  /// Revoke observe for a subject. Deletes the observe file.
  Future<void> revokeObserve({required String subjectName});

  /// List observe declarations from own repo.
  Future<List<ObserveDeclaration>> getOwnObserveDeclarations();

  /// List observe declarations from any repo via public read.
  Future<List<ObserveDeclaration>> getObserveDeclarations(
      RepoIdentifier repoId);
}
