import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/account_creation_result.dart';

part 'account_creation_state.freezed.dart';

@freezed
abstract class AccountCreationState with _$AccountCreationState implements IUiFlowState {
  const AccountCreationState._();
  const factory AccountCreationState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    AccountCreationResult? result,
  }) = _AccountCreationState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;
}
