/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:koinon_index_core_client/src/protocol/politai_user.dart' as _i3;
import 'package:koinon_index_core_client/src/protocol/relationships.dart'
    as _i4;
import 'package:koinon_index_core_client/src/protocol/polis_definition.dart'
    as _i5;
import 'package:koinon_index_core_client/src/protocol/polis_member.dart' as _i6;

/// Koinon core query endpoints — discovery, trust graph, and polis lookups.
/// {@category Endpoint}
class EndpointKoinonCore extends _i1.EndpointRef {
  EndpointKoinonCore(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'koinon_index_core.koinonCore';

  /// Register a repo URL for indexing (no auth — bootstrap endpoint).
  ///
  /// Used by clients to manually register their repo with the aggregator
  /// (bootstrap for first user on a forge without system webhooks).
  _i2.Future<void> register(String repoUrl) => caller.callServerEndpoint<void>(
    'koinon_index_core.koinonCore',
    'register',
    {'repoUrl': repoUrl},
  );

  /// Look up a polites by public key.
  _i2.Future<_i3.PolitaiUser?> getUser(String pubkey) =>
      caller.callServerEndpoint<_i3.PolitaiUser?>(
        'koinon_index_core.koinonCore',
        'getUser',
        {'pubkey': pubkey},
      );

  /// Get all trust and observe relationships for a polites, in both directions.
  _i2.Future<_i4.Relationships> getRelationships(String pubkey) =>
      caller.callServerEndpoint<_i4.Relationships>(
        'koinon_index_core.koinonCore',
        'getRelationships',
        {'pubkey': pubkey},
      );

  /// List all known poleis.
  _i2.Future<List<_i5.PolisDefinition>> listPoleis() =>
      caller.callServerEndpoint<List<_i5.PolisDefinition>>(
        'koinon_index_core.koinonCore',
        'listPoleis',
        {},
      );

  /// Get a polis by repo URL.
  _i2.Future<_i5.PolisDefinition?> getPolis(String repoUrl) =>
      caller.callServerEndpoint<_i5.PolisDefinition?>(
        'koinon_index_core.koinonCore',
        'getPolis',
        {'repoUrl': repoUrl},
      );

  /// Get polis members: all signers with their trust connection count.
  ///
  /// Uses a single AGE Cypher query for trust counting, then a batch ORM
  /// lookup for repo URLs. Client compares trustConnections against
  /// polis.membershipThreshold to determine full member vs provisional.
  _i2.Future<List<_i6.PolisMember>> getPolisMembers(String polisRepoUrl) =>
      caller.callServerEndpoint<List<_i6.PolisMember>>(
        'koinon_index_core.koinonCore',
        'getPolisMembers',
        {'polisRepoUrl': polisRepoUrl},
      );
}

class Caller extends _i1.ModuleEndpointCaller {
  Caller(_i1.ServerpodClientShared client) : super(client) {
    koinonCore = EndpointKoinonCore(this);
  }

  late final EndpointKoinonCore koinonCore;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'koinon_index_core.koinonCore': koinonCore,
  };
}
