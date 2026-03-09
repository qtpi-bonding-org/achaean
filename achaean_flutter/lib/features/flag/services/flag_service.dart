import 'dart:convert';

import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/flag_exception.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import 'i_flag_service.dart';

class FlagService implements IFlagService {
  final IGitService _gitService;

  FlagService(this._gitService);

  @override
  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        if (manifest.flags.any(
            (f) => f.post == postPath && f.polis == polisRepoUrl)) {
          return;
        }

        final updated = manifest.copyWith(
          flags: [
            ...manifest.flags,
            FlagEntry(
              post: postPath,
              polis: polisRepoUrl,
              reason: reason,
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
          message: 'Flag post: $postPath in $polisRepoUrl',
          sha: manifestFile.sha,
        );
      },
      FlagException.new,
      'flagPost',
    );
  }

  @override
  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  }) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        final updated = manifest.copyWith(
          flags: manifest.flags
              .where((f) =>
                  !(f.post == postPath && f.polis == polisRepoUrl))
              .toList(),
        );

        final updatedJson =
            const JsonEncoder.withIndent('  ').convert(updated.toJson());
        await client.commitFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
          content: updatedJson,
          message: 'Retract flag: $postPath in $polisRepoUrl',
          sha: manifestFile.sha,
        );
      },
      FlagException.new,
      'retractFlag',
    );
  }

  @override
  Future<List<FlagEntry>> getOwnFlags() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          FlagException.new,
        );
        const repo = 'koinon';

        final manifestFile = await client.readFile(
          owner: owner,
          repo: repo,
          path: '.well-known/koinon.json',
        );
        final manifestJson =
            jsonDecode(manifestFile.content) as Map<String, dynamic>;
        final manifest = KoinonManifest.fromJson(manifestJson);

        return manifest.flags;
      },
      FlagException.new,
      'getOwnFlags',
    );
  }
}
