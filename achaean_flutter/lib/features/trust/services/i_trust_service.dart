import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';

abstract class ITrustService {
  /// Declare trust for a subject. Commits trust/[subject-pubkey-prefix].json.
  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  });

  /// Revoke trust for a subject. Deletes the trust file.
  Future<void> revokeTrust({required String subjectName});

  /// List trust declarations from own repo.
  Future<List<TrustDeclaration>> getOwnTrustDeclarations();

  /// List trust declarations from any repo via public read.
  Future<List<TrustDeclaration>> getTrustDeclarations(RepoIdentifier repoId);
}
