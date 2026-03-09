import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/post_creation_result.dart';

part 'post_creation_state.freezed.dart';

@freezed
abstract class PostCreationState with _$PostCreationState implements IUiFlowState {
  const PostCreationState._();
  const factory PostCreationState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    PostCreationResult? result,
  }) = _PostCreationState;

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
