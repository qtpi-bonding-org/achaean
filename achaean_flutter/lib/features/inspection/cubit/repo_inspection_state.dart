import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/repo_inspection_result.dart';

part 'repo_inspection_state.freezed.dart';

@freezed
abstract class RepoInspectionState with _$RepoInspectionState
    implements IUiFlowState {
  const RepoInspectionState._();
  const factory RepoInspectionState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    RepoInspectionResult? result,
  }) = _RepoInspectionState;

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
