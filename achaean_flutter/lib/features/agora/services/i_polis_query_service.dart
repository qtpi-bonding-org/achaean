import 'package:achaean_client/achaean_client.dart';

/// Queries Serverpod for polis discovery and membership data.
abstract class IPolisQueryService {
  Future<List<PolisDefinition>> listPoleis();
  Future<PolisDefinition?> getPolis(String repoUrl);
  Future<List<PolitaiUser>> getPolisMembers(String polisRepoUrl);
  Future<List<ReadmeSignatureRecord>> getPolisSigners(String polisRepoUrl);
}
