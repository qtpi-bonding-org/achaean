import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_flag_service.dart';
import 'flag_state.dart';

class FlagCubit extends AppCubit<FlagState> {
  final IFlagService _service;

  FlagCubit(this._service) : super(const FlagState());

  Future<void> flagPost({
    required String postPath,
    required String polisRepoUrl,
    required String reason,
  }) async {
    await tryOperation(
      () async {
        await _service.flagPost(
          postPath: postPath,
          polisRepoUrl: polisRepoUrl,
          reason: reason,
        );
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> retractFlag({
    required String postPath,
    required String polisRepoUrl,
  }) async {
    await tryOperation(
      () async {
        await _service.retractFlag(
          postPath: postPath,
          polisRepoUrl: polisRepoUrl,
        );
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnFlags() async {
    await tryOperation(
      () async {
        final flags = await _service.getOwnFlags();
        return state.copyWith(
          status: UiFlowStatus.success,
          flags: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
