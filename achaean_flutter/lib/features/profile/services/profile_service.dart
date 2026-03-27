import 'dart:convert';

import 'package:dart_git/dart_git.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/exceptions/profile_exception.dart';
import '../../../core/models/repo_identifier.dart';
import '../../../core/services/i_git_service.dart';
import '../../../core/try_operation.dart';
import '../../../features/trust/services/trust_service.dart'
    show PublicGitClientFactory;
import 'i_profile_service.dart';

class ProfileService implements IProfileService {
  final IGitService _gitService;
  final PublicGitClientFactory _publicClientFactory;

  static const _profilePath = 'profile/profile.json';

  ProfileService(this._gitService, this._publicClientFactory);

  @override
  Future<ProfileDetails> getOwnProfile() {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ProfileException.new,
        );
        return _readProfile(client, owner, 'koinon');
      },
      ProfileException.new,
      'getOwnProfile',
    );
  }

  @override
  Future<void> updateProfile(ProfileDetails profile) {
    return tryMethod(
      () async {
        final client = await _gitService.getClient();
        final owner = requireNonNull(
          await _gitService.getUsername(),
          'username',
          ProfileException.new,
        );
        const repo = 'koinon';

        String? sha;
        try {
          final existing = await client.readFile(
            owner: owner,
            repo: repo,
            path: _profilePath,
          );
          sha = existing.sha;
        } on GitNotFoundException {
          // New profile file
        }

        final json =
            const JsonEncoder.withIndent('  ').convert(profile.toJson());

        await client.commitFile(
          owner: owner,
          repo: repo,
          path: _profilePath,
          content: json,
          message: 'Update profile',
          sha: sha,
        );
      },
      ProfileException.new,
      'updateProfile',
    );
  }

  @override
  Future<ProfileDetails> getProfile(RepoIdentifier repoId) {
    return tryMethod(
      () async {
        final hostType = requireNonNull(
          await _gitService.getHostType(),
          'hostType',
          ProfileException.new,
        );
        final client = _publicClientFactory(
          baseUrl: repoId.baseUrl,
          hostType: hostType,
        );
        return _readProfile(client, repoId.owner, repoId.repo);
      },
      ProfileException.new,
      'getProfile',
    );
  }

  Future<ProfileDetails> _readProfile(
    IGitClient client,
    String owner,
    String repo,
  ) async {
    try {
      final file = await client.readFile(
        owner: owner,
        repo: repo,
        path: _profilePath,
      );
      final json = jsonDecode(file.content) as Map<String, dynamic>;
      return ProfileDetails.fromJson(json);
    } on GitNotFoundException {
      return const ProfileDetails();
    }
  }
}
