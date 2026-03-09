import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/repo_identifier.dart';

part 'polis_state.freezed.dart';

@freezed
abstract class PolisState with _$PolisState implements IUiFlowState {
  const PolisState._();
  const factory PolisState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PolisMembership> poleis,
    RepoIdentifier? createdPolis,
  }) = _PolisState;

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
