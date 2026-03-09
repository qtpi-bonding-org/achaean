import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/polis_state.dart';

@injectable
class PolisMessageMapper implements IStateMessageMapper<PolisState> {
  @override
  MessageKey? map(PolisState state) {
    if (state.status == UiFlowStatus.success && state.createdPolis != null) {
      return const MessageKey.success('polis.creation.success');
    }
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('polis.operation.success');
    }
    return null;
  }
}
