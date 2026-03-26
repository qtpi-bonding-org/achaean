import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_observe_service.dart';
import 'observe_state.dart';

class ObserveCubit extends AppCubit<ObserveState> {
  final IObserveService _service;

  ObserveCubit(this._service) : super(const ObserveState());

  Future<void> declareObserve({
    required String subjectPubkey,
    required String subjectRepo,
  }) async {
    await tryOperation(
      () async {
        await _service.declareObserve(
          subjectPubkey: subjectPubkey,
          subjectRepo: subjectRepo,
        );
        final declarations = await _service.getOwnObserveDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> revokeObserve({required String subjectName}) async {
    await tryOperation(
      () async {
        await _service.revokeObserve(subjectName: subjectName);
        final declarations = await _service.getOwnObserveDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnObserve() async {
    await tryOperation(
      () async {
        final declarations = await _service.getOwnObserveDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadObserveFor(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        final declarations = await _service.getObserveDeclarations(repoId);
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
