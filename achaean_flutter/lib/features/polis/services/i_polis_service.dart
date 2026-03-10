import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/polis_info.dart';
import '../../../core/models/repo_identifier.dart';

abstract class IPolisService {
  /// Create a new polis. Creates the repo, commits README with YAML frontmatter,
  /// signs README, commits signature to own repo, updates koinon.json.
  Future<RepoIdentifier> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  });

  /// Join a polis. Reads polis README, signs it, commits signature to own repo,
  /// updates koinon.json.
  Future<void> joinPolis(RepoIdentifier repoId);

  /// Leave a polis. Deletes signature file, updates koinon.json.
  Future<void> leavePolis(RepoIdentifier repoId);

  /// Read and parse polis README frontmatter.
  Future<PolisInfo> getPolisInfo(RepoIdentifier repoId);

  /// List own poleis from koinon.json.
  Future<List<PolisMembership>> getOwnPoleis();

  /// Fork an existing polis. Forks the repo, adds parent pointer to README
  /// YAML frontmatter, signs README, and registers in koinon.json.
  Future<RepoIdentifier> forkPolis(RepoIdentifier sourceRepoId);
}
