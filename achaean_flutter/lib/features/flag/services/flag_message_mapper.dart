import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/flag_state.dart';

@injectable
class FlagMessageMapper implements IStateMessageMapper<FlagState> {
  @override
  MessageKey? map(FlagState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('flag.post.success');
    }
    return null;
  }
}
