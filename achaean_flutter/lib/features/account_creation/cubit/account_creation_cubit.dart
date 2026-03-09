import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_account_creation_service.dart';
import 'account_creation_state.dart';

class AccountCreationCubit extends AppCubit<AccountCreationState> {
  final IAccountCreationService _service;

  AccountCreationCubit(this._service)
      : super(const AccountCreationState());

  Future<void> createAccount({
    required String username,
    required String email,
    required String password,
  }) async {
    await tryOperation(
      () async {
        final result = await _service.createAccount(
          username: username,
          email: email,
          password: password,
        );
        return state.copyWith(
          status: UiFlowStatus.success,
          result: result,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
