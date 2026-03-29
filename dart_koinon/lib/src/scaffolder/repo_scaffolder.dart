import 'dart:convert';

import 'package:dart_git/dart_git.dart';

import '../models/koinon_manifest.dart';

/// Creates the standard Koinon repo structure for a new polites.
class RepoScaffolder {
  final IGitClient git;

  const RepoScaffolder(this.git);

  /// Scaffolds a new polites repo with the standard directory structure.
  ///
  /// Creates the repo on the forge, then commits the initial files:
  /// - `.well-known/koinon.json` — discovery manifest
  /// - `identity/pubkey.json` — public key
  /// - `trust/.gitkeep` — trust declarations directory
  /// - `poleis/.gitkeep` — polis signatures directory
  /// - `posts/.gitkeep` — posts directory
  Future<GitRepo> scaffold({
    required String repoName,
    required String pubkey,
    required String repoHttps,
    String? repoRadicle,
    String? description,
  }) async {
    GitRepo repo;
    try {
      repo = await git.createRepo(
        name: repoName,
        description: description ?? 'Koinon polites repo',
      );
    } on GitConflictException {
      // Repo already exists — reuse it (e.g. re-registering on same forge)
      return GitRepo(
        id: 0,
        name: repoName,
        owner: repoHttps.split('/').reversed.skip(1).first,
        cloneUrl: '$repoHttps.git',
        htmlUrl: repoHttps,
      );
    }

    final owner = repo.owner;
    final name = repo.name;

    final manifest = KoinonManifest(
      pubkey: pubkey,
      repoHttps: repoHttps,
      repoRadicle: repoRadicle,
    );

    // Commit initial files sequentially (each needs the previous to exist).
    await git.commitFile(
      owner: owner,
      repo: name,
      path: '.well-known/koinon.json',
      content: _encodePretty(manifest.toJson()),
      message: 'Initialize Koinon manifest',
    );

    await git.commitFile(
      owner: owner,
      repo: name,
      path: 'identity/pubkey.json',
      content: _encodePretty({'pubkey': pubkey}),
      message: 'Add public key',
    );

    await git.commitFile(
      owner: owner,
      repo: name,
      path: 'trust/.gitkeep',
      content: '',
      message: 'Initialize trust directory',
    );

    await git.commitFile(
      owner: owner,
      repo: name,
      path: 'poleis/.gitkeep',
      content: '',
      message: 'Initialize poleis directory',
    );

    await git.commitFile(
      owner: owner,
      repo: name,
      path: 'posts/.gitkeep',
      content: '',
      message: 'Initialize posts directory',
    );

    return repo;
  }

  String _encodePretty(Map<String, dynamic> json) =>
      const JsonEncoder.withIndent('  ').convert(json);
}
