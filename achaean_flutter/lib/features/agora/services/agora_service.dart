import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_agora_service.dart';

class AgoraService implements IAgoraService {
  final Client _client;

  AgoraService(this._client);

  @override
  Future<List<PostReference>> getAgoraRefs(
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) {
    return tryMethod(
      () => _client.koinon
          .getAgora(polisRepoUrl, limit: limit, offset: offset),
      QueryException.new,
      'getAgoraRefs',
    );
  }

  @override
  Future<List<FlagRecord>> getFlagsForPolis(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getFlagsForPolis(polisRepoUrl),
      QueryException.new,
      'getFlagsForPolis',
    );
  }
}
