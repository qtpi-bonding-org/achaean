import 'package:achaean_client/achaean_client.dart';
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_review_state.freezed.dart';

@freezed
abstract class VoucherReviewState
    with _$VoucherReviewState
    implements IUiFlowState {
  const VoucherReviewState._();
  const factory VoucherReviewState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<FlagRecord> flaggedPosts,
  }) = _VoucherReviewState;

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
