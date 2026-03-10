import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for flagged posts by people the caller trusts.
abstract class IVoucherReviewService {
  Future<List<FlagRecord>> getFlaggedPostsByTrusted();
}
