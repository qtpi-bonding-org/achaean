import 'package:achaean_client/achaean_client.dart';

import 'i_polis_query_service.dart';

/// No-op implementation of [IPolisQueryService] for demo/guest mode.
///
/// Returns empty lists for all queries. This allows [AgoraCubit] and
/// [PolisDiscoveryCubit] to be registered in demo mode without a Serverpod
/// index server, so the router can always create them without crashing.
class StubPolisQueryService implements IPolisQueryService {
  const StubPolisQueryService();

  @override
  Future<List<PolisDefinition>> listPoleis() async => const [];

  @override
  Future<PolisDefinition?> getPolis(String repoUrl) async => null;

  @override
  Future<List<PolisMember>> getPolisMembers(String polisRepoUrl) async =>
      const [];
}
