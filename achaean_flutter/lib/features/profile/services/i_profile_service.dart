import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';

abstract class IProfileService {
  Future<ProfileDetails> getOwnProfile();
  Future<void> updateProfile(ProfileDetails profile);
  Future<ProfileDetails> getProfile(RepoIdentifier repoId);
}
