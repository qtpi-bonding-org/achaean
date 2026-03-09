import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trust_state.freezed.dart';

@freezed
abstract class TrustState with _$TrustState implements IUiFlowState {
  const TrustState._();
  const factory TrustState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<TrustDeclaration> declarations,
  }) = _TrustState;

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
