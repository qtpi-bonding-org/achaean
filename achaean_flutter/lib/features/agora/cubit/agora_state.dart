import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'agora_state.freezed.dart';

@freezed
abstract class AgoraState with _$AgoraState implements IUiFlowState {
  const AgoraState._();
  const factory AgoraState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<CachedPost> posts,
    @Default({}) Map<String, int> flagCounts,
    @Default(1) int flagThreshold,
    @Default(false) bool hasMore,
    @Default(0) int offset,
  }) = _AgoraState;

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

  /// Check if a post is flagged (flag count >= threshold).
  bool isPostFlagged(String postPath) =>
      (flagCounts[postPath] ?? 0) >= flagThreshold;
}
