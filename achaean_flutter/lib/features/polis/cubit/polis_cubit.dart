import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_polis_service.dart';
import 'polis_state.dart';

class PolisCubit extends AppCubit<PolisState> {
  final IPolisService _service;

  PolisCubit(this._service) : super(const PolisState());

  Future<void> createPolis({
    required String name,
    String? description,
    String? norms,
    int? threshold,
  }) async {
    await tryOperation(
      () async {
        final repoId = await _service.createPolis(
          name: name,
          description: description,
          norms: norms,
          threshold: threshold,
        );
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          createdPolis: repoId,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> joinPolis(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        await _service.joinPolis(repoId);
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> leavePolis(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        await _service.leavePolis(repoId);
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnPoleis() async {
    await tryOperation(
      () async {
        final poleis = await _service.getOwnPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
