import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'polis_discovery_state.freezed.dart';

@freezed
abstract class PolisDiscoveryState
    with _$PolisDiscoveryState
    implements IUiFlowState {
  const PolisDiscoveryState._();
  const factory PolisDiscoveryState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PolisDefinition> poleis,
    @Default([]) List<PolisMember> members,
  }) = _PolisDiscoveryState;

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
