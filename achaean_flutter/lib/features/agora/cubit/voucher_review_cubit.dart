import 'package:cubit_ui_flow/cubit_ui_flow.dart';

import '../../../support/extensions/cubit_ui_flow_extension.dart';
import '../services/i_voucher_review_service.dart';
import 'voucher_review_state.dart';

class VoucherReviewCubit extends AppCubit<VoucherReviewState> {
  final IVoucherReviewService _voucherReviewService;

  VoucherReviewCubit(this._voucherReviewService)
      : super(const VoucherReviewState());

  /// Load flagged posts by people the caller trusts.
  Future<void> loadFlaggedPosts() async {
    await tryOperation(
      () async {
        final flags = await _voucherReviewService.getFlaggedPostsByTrusted();
        return state.copyWith(
          status: UiFlowStatus.success,
          flaggedPosts: flags,
          error: null,
        );
      },
      emitLoading: true,
    );
  }
}
