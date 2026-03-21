import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_feed_state.freezed.dart';

@freezed
abstract class PersonalFeedState
    with _$PersonalFeedState
    implements IUiFlowState {
  const PersonalFeedState._();
  const factory PersonalFeedState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<PostReference> posts,
    @Default(false) bool hasMore,
    @Default(0) int offset,
  }) = _PersonalFeedState;

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
