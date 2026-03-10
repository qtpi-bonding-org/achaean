import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_polis_query_service.dart';
import 'polis_discovery_state.dart';

class PolisDiscoveryCubit extends AppCubit<PolisDiscoveryState> {
  final IPolisQueryService _polisQueryService;

  PolisDiscoveryCubit(this._polisQueryService)
      : super(const PolisDiscoveryState());

  /// Load all known poleis from the Serverpod index.
  Future<void> loadPoleis() async {
    await tryOperation(
      () async {
        final poleis = await _polisQueryService.listPoleis();
        return state.copyWith(
          status: UiFlowStatus.success,
          poleis: poleis,
          error: null,
        );
      },
      emitLoading: true,
    );
  }

  /// Load computed members for a specific polis.
  Future<void> loadMembers(String polisRepoUrl) async {
    await tryOperation(
      () async {
        final members = await _polisQueryService.getPolisMembers(polisRepoUrl);
        return state.copyWith(
          status: UiFlowStatus.success,
          members: members,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
