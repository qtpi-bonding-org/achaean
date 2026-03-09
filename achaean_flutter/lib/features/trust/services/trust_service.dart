import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/trust_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_signing_service.dart';
import '../../../core/try_operation.dart';
import 'i_trust_service.dart';

/// Factory for creating read-only IGitClient instances for foreign repos.
typedef PublicGitClientFactory = IGitClient Function({
  required String baseUrl,
  required GitHostType hostType,
});

class TrustService implements ITrustService {
  final IGitService _gitService;
  final ISigningService _signingService;
  final PublicGitClientFactory _publicClientFactory;

  TrustService(
      this._gitService, this._signingService, this._publicClientFactory);

  @override
  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        const repo = 'koinon';
        final now = DateTime.now().toUtc();

        // Build unsigned trust declaration
        final unsigned = TrustDeclaration(
          subject: subjectPubkey,
          repo: subjectRepo,
          level: level,
          timestamp: now,
          signature: '',
        );

        // Sign
        final signature = await _signingService.sign(unsigned.toJson());
        final signed = unsigned.copyWith(signature: signature);

        // Use first 16 chars of pubkey as filename
        final fileName = subjectPubkey.length >= 16
            ? subjectPubkey.substring(0, 16)
            : subjectPubkey;
        final path = 'trust/$fileName.json';

        // Check if file exists (need sha for update)
        String? sha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: repo,
            path: path,
          );
          sha = existing.sha;
        } on GitNotFoundException {
          // New trust declaration
        }

        final json =
            const JsonEncoder.withIndent('  ').convert(signed.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: path,
          content: json,
          message: 'Trust: ${level.name} $fileName',
          sha: sha,
        );
      },
      TrustException.new,
      'declareTrust',
    );
  }

  @override
  Future<void> revokeTrust({required String subjectName}) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        const repo = 'koinon';
        final path = 'trust/$subjectName.json';

        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: path,
        );

        await client.deleteFile(
          owner: owner,
          repo: repo,
          path: path,
          sha: file.sha,
          message: 'Revoke trust: $subjectName',
        );
      },
      TrustException.new,
      'revokeTrust',
    );
  }

  @override
  Future<List<TrustDeclaration>> getOwnTrustDeclarations() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          TrustException.new,
        );
        return _readTrustDir(client, owner, 'koinon');
      },
      TrustException.new,
      'getOwnTrustDeclarations',
    );
  }

  @override
  Future<List<TrustDeclaration>> getTrustDeclarations(
      RepoIdentifier repoId) {
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
        return _readTrustDir(client, repoId.owner, repoId.repo);
      },
      TrustException.new,
      'getTrustDeclarations',
    );
  }

  Future<List<TrustDeclaration>> _readTrustDir(
    IGitClient client,
    String owner,
    String repo,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: owner,
        repo: repo,
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
          owner: owner,
          repo: repo,
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
}
