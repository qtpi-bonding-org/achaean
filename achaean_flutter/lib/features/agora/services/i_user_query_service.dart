import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for user lookup and trust graph data.
abstract class IUserQueryService {
  Future<PolitaiUser?> getUser(String pubkey);
  Future<Relationships> getRelationships(String pubkey);
}
