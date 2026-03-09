import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:injectable/injectable.dart';

import '../cubit/account_creation_state.dart';

@injectable
class AccountCreationMessageMapper
    implements IStateMessageMapper<AccountCreationState> {
  @override
  MessageKey? map(AccountCreationState state) {
    if (state.status == UiFlowStatus.success && state.result != null) {
      return const MessageKey.success('account.creation.success');
    }
    return null; // Errors handled by global exception mapper
  }
}
