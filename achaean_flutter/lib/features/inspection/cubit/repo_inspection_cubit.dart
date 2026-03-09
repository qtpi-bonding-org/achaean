import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_repo_inspection_service.dart';
import 'repo_inspection_state.dart';

class RepoInspectionCubit extends AppCubit<RepoInspectionState> {
  final IRepoInspectionService _service;

  RepoInspectionCubit(this._service) : super(const RepoInspectionState());

  Future<void> inspect(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        final result = await _service.inspect(repoId);
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
