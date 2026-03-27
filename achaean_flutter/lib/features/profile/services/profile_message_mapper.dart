import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/profile_state.dart';

@injectable
class ProfileMessageMapper implements IStateMessageMapper<ProfileState> {
  @override
  MessageKey? map(ProfileState state) {
    if (state.status == UiFlowStatus.success) {
      return const MessageKey.success('profileUpdateSuccess');
    }
    return null;
  }
}
