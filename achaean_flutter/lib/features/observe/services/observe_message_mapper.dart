import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/observe_state.dart';

@injectable
class ObserveMessageMapper implements IStateMessageMapper<ObserveState> {
  @override
  MessageKey? map(ObserveState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('observeDeclarationSuccess');
    }
    return null;
  }
}
