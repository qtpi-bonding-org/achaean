import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/trust_state.dart';

@injectable
class TrustMessageMapper implements IStateMessageMapper<TrustState> {
  @override
  MessageKey? map(TrustState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('trust.declaration.success');
    }
    return null;
  }
}
