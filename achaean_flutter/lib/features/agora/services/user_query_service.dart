import 'package:achaean_client/achaean_client.dart';

import '../../../core/exceptions/query_exception.dart';
import '../../../core/try_operation.dart';
import 'i_user_query_service.dart';

class UserQueryService implements IUserQueryService {
  final Client _client;

  UserQueryService(this._client);

  @override
  Future<PolitaiUser?> getUser(String pubkey) {
    return tryMethod(
      () => _client.koinon.getUser(pubkey),
      QueryException.new,
      'getUser',
    );
  }

  @override
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(String pubkey) {
    return tryMethod(
      () => _client.koinon.getTrustDeclarations(pubkey),
      QueryException.new,
      'getTrustDeclarations',
    );
  }
}
