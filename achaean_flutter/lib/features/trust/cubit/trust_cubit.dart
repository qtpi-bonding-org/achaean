import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/models/repo_identifier.dart';
import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_trust_service.dart';
import 'trust_state.dart';

class TrustCubit extends AppCubit<TrustState> {
  final ITrustService _service;

  TrustCubit(this._service) : super(const TrustState());

  Future<void> declareTrust({
    required String subjectPubkey,
    required String subjectRepo,
    required TrustLevel level,
  }) async {
    await tryOperation(
      () async {
        await _service.declareTrust(
          subjectPubkey: subjectPubkey,
          subjectRepo: subjectRepo,
          level: level,
        );
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> revokeTrust({required String subjectName}) async {
    await tryOperation(
      () async {
        await _service.revokeTrust(subjectName: subjectName);
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadOwnTrust() async {
    await tryOperation(
      () async {
        final declarations = await _service.getOwnTrustDeclarations();
        return state.copyWith(
          status: UiFlowStatus.success,
          declarations: declarations,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  Future<void> loadTrustFor(RepoIdentifier repoId) async {
    await tryOperation(
      () async {
        final declarations = await _service.getTrustDeclarations(repoId);
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
