import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/observe_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/services/i_signing_service.dart';
import '../../../core/try_operation.dart';
import '../../trust/services/trust_service.dart' show PublicGitClientFactory;
import 'i_observe_service.dart';

class ObserveService implements IObserveService {
  final IGitService _gitService;
  final ISigningService _signingService;
  final PublicGitClientFactory _publicClientFactory;

  ObserveService(
      this._gitService, this._signingService, this._publicClientFactory);

  @override
  Future<void> declareObserve({
    required String subjectPubkey,
    required String subjectRepo,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ObserveException.new,
        );
        const repo = 'koinon';
        final now = DateTime.now().toUtc();

        final unsigned = ObserveDeclaration(
          subject: subjectPubkey,
          repo: subjectRepo,
          timestamp: now,
          signature: '',
        );

        final signature = await _signingService.sign(unsigned.toJson());
        final signed = unsigned.copyWith(signature: signature);

        final fileName = subjectPubkey.length >= 16
            ? subjectPubkey.substring(0, 16)
            : subjectPubkey;
        final path = 'observe/$fileName.json';

        String? sha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: repo,
            path: path,
          );
          sha = existing.sha;
        } on GitNotFoundException {
          // New observe declaration
        }

        final json =
            const JsonEncoder.withIndent('  ').convert(signed.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: path,
          content: json,
          message: 'Observe: $fileName',
          sha: sha,
        );

        // Update koinon.json observe array
        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        if (!manifest.observe.any((o) => o.subject == subjectPubkey)) {
          final updated = manifest.copyWith(
            observe: [
              ...manifest.observe,
              ObserveEntry(
                subject: subjectPubkey,
                repo: subjectRepo,
              ),
            ],
          );

          final updatedJson =
              const JsonEncoder.withIndent('  ').convert(updated.toJson());
          await client.commitFile(
            owner: owner,
            repo: repo,
            path: '.well-known/koinon.json',
            content: updatedJson,
            message: 'Update observe index: add $fileName',
            sha: manifestFile.sha,
          );
        }
      },
      ObserveException.new,
      'declareObserve',
    );
  }

  @override
  Future<void> revokeObserve({required String subjectName}) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ObserveException.new,
        );
        const repo = 'koinon';
        final path = 'observe/$subjectName.json';

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
          message: 'Revoke observe: $subjectName',
        );

        // Update koinon.json observe array
        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        final updated = manifest.copyWith(
          observe: manifest.observe
              .where((o) => !o.subject.startsWith(subjectName))
              .toList(),
        );

        final updatedJson =
            const JsonEncoder.withIndent('  ').convert(updated.toJson());
        await client.commitFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
          content: updatedJson,
          message: 'Update observe index: revoke $subjectName',
          sha: manifestFile.sha,
        );
      },
      ObserveException.new,
      'revokeObserve',
    );
  }

  @override
  Future<List<ObserveDeclaration>> getOwnObserveDeclarations() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ObserveException.new,
        );
        return _readObserveDir(client, owner, 'koinon');
      },
      ObserveException.new,
      'getOwnObserveDeclarations',
    );
  }

  @override
  Future<List<ObserveDeclaration>> getObserveDeclarations(
      RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          ObserveException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        return _readObserveDir(client, repoId.owner, repoId.repo);
      },
      ObserveException.new,
      'getObserveDeclarations',
    );
  }

  Future<List<ObserveDeclaration>> _readObserveDir(
    IGitClient client,
    String owner,
    String repo,
  ) async {
    List<GitDirectoryEntry> entries;
    try {
      entries = await client.listFiles(
        owner: owner,
        repo: repo,
        path: 'observe',
      );
    } on GitNotFoundException {
      return [];
    }

    final declarations = <ObserveDeclaration>[];
    for (final entry in entries) {
      if (entry.name == '.gitkeep' || !entry.name.endsWith('.json')) continue;
      try {
        final file = await client.readFile(
          owner: owner,
          repo: repo,
          path: entry.path,
        );
        final json = jsonDecode(file.content) as Map<String, dynamic>;
        declarations.add(ObserveDeclaration.fromJson(json));
      } catch (_) {
        continue;
      }
    }
    return declarations;
  }
}
