import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_voucher_review_service.dart';

class VoucherReviewService implements IVoucherReviewService {
  final Client _client;

  VoucherReviewService(this._client);

  @override
  Future<List<FlagRecord>> getFlaggedPostsByTrusted() {
    return tryMethod(
      () => _client.koinon.getFlaggedPostsForVouchers(),
      QueryException.new,
      'getFlaggedPostsByTrusted',
    );
  }
}
