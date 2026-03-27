import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_profile_service.dart';
import 'profile_state.dart';

class ProfileCubit extends AppCubit<ProfileState> {
  final IProfileService _service;

  ProfileCubit(this._service) : super(const ProfileState());

  Future<void> loadOwnProfile() async {
    await tryOperation(
      () async {
        final profile = await _service.getOwnProfile();
        return state.copyWith(
          status: UiFlowStatus.success,
          profile: profile,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> updateProfile({
    String? displayName,
    String? bio,
  }) async {
    await tryOperation(
      () async {
        final updated = ProfileDetails(
          displayName: displayName,
          bio: bio,
        );
        await _service.updateProfile(updated);
        return state.copyWith(
          status: UiFlowStatus.success,
          profile: updated,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
