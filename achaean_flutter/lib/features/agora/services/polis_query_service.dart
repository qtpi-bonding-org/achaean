import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_polis_query_service.dart';

class PolisQueryService implements IPolisQueryService {
  final Client _client;

  PolisQueryService(this._client);

  @override
  Future<List<PolisDefinition>> listPoleis() {
    return tryMethod(
      () => _client.koinon.listPoleis(),
      QueryException.new,
      'listPoleis',
    );
  }

  @override
  Future<PolisDefinition?> getPolis(String repoUrl) {
    return tryMethod(
      () => _client.koinon.getPolis(repoUrl),
      QueryException.new,
      'getPolis',
    );
  }

  @override
  Future<List<PolitaiUser>> getPolisMembers(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getPolisMembers(polisRepoUrl),
      QueryException.new,
      'getPolisMembers',
    );
  }

  @override
  Future<List<ReadmeSignatureRecord>> getPolisSigners(String polisRepoUrl) {
    return tryMethod(
      () => _client.koinon.getPolisSigners(polisRepoUrl),
      QueryException.new,
      'getPolisSigners',
    );
  }
}
