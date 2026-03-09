import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/trust_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/models/repo_inspection_result.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart';
import 'i_repo_inspection_service.dart';

class RepoInspectionService implements IRepoInspectionService {
  final IGitService _gitService;
  final PublicGitClientFactory _publicClientFactory;

  RepoInspectionService(this._gitService, this._publicClientFactory);

  @override
  Future<RepoInspectionResult> inspect(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          TrustException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );

        // Read manifest
        KoinonManifest? manifest;
        try {
          final manifestFile = await client.readFile(
            owner: repoId.owner,
            repo: repoId.repo,
            path: '.well-known/koinon.json',
          );
          final json =
              jsonDecode(manifestFile.content) as Map<String, dynamic>;
          manifest = KoinonManifest.fromJson(json);
        } on GitNotFoundException {
          // No manifest
        }

        // Read trust declarations
        final trustDeclarations = await _readTrustDir(client, repoId);

        // Read polis signatures
        final readmeSignatures = await _readPolisSignatures(client, repoId);

        // Read posts
        final posts = await _readPosts(client, repoId);

        return RepoInspectionResult(
          manifest: manifest,
          trustDeclarations: trustDeclarations,
          readmeSignatures: readmeSignatures,
          posts: posts,
        );
      },
      TrustException.new,
      'inspect',
    );
  }

  @override
  Future<KoinonManifest> getManifest(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          TrustException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: '.well-known/koinon.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        return KoinonManifest.fromJson(json);
      },
      TrustException.new,
      'getManifest',
    );
  }

  Future<List<TrustDeclaration>> _readTrustDir(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'trust',
      );
    } on GitNotFoundException {
      return [];
    }

    final declarations = <TrustDeclaration>[];
    for (final entry in entries) {
      if (entry.name == '.gitkeep' || !entry.name.endsWith('.json')) continue;
      try {
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: entry.path,
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        declarations.add(TrustDeclaration.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return declarations;
  }

  Future<List<ReadmeSignature>> _readPolisSignatures(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> poleisDirs;
    try {
      poleisDirs = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'poleis',
      );
    } on GitNotFoundException {
      return [];
    }

    final signatures = <ReadmeSignature>[];
    for (final dir in poleisDirs) {
      if (dir.type != GitEntryType.dir) continue;
      try {
        final subEntries = await client.listFiles(
          owner: repoId.owner,
          repo: repoId.repo,
          path: dir.path,
        );
        for (final subEntry in subEntries) {
          if (subEntry.type == GitEntryType.dir) {
            // poleis/<owner>/<repo>/signature.json
            try {
              final file = await client.readFile(
                owner: repoId.owner,
                repo: repoId.repo,
                path: '${subEntry.path}/signature.json',
              );
              final json =
                  jsonDecode(file.content) as Map<String, dynamic>;
              signatures.add(ReadmeSignature.fromJson(json));
            } catch (_) {
              continue;
            }
          } else if (subEntry.name == 'signature.json') {
            // poleis/<repo-id>/signature.json (flat structure)
            try {
              final file = await client.readFile(
                owner: repoId.owner,
                repo: repoId.repo,
                path: subEntry.path,
              );
              final json =
                  jsonDecode(file.content) as Map<String, dynamic>;
              signatures.add(ReadmeSignature.fromJson(json));
            } catch (_) {
              continue;
            }
          }
        }
      } catch (_) {
        continue;
      }
    }
    return signatures;
  }

  Future<List<Post>> _readPosts(
    IGitClient client,
    RepoIdentifier repoId,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: repoId.owner,
        repo: repoId.repo,
        path: 'posts',
      );
    } on GitNotFoundException {
      return [];
    }

    final posts = <Post>[];
    for (final entry in entries) {
      if (entry.type != GitEntryType.dir || entry.name == '.gitkeep') continue;
      try {
        final file = await client.readFile(
          owner: repoId.owner,
          repo: repoId.repo,
          path: '${entry.path}/post.json',
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        posts.add(Post.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    posts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return posts;
  }
}
