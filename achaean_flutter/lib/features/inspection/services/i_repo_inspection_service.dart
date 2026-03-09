import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../core/models/repo_inspection_result.dart';

abstract class IRepoInspectionService {
  /// Inspect a repo: read manifest, trust declarations, polis signatures, posts.
  Future<RepoInspectionResult> inspect(RepoIdentifier repoId);

  /// Read and parse the koinon manifest from any repo.
  Future<KoinonManifest> getManifest(RepoIdentifier repoId);
}
