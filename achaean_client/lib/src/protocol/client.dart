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
import 'package:achaean_client/src/protocol/greetings/greeting.dart' as _i3;
import 'package:achaean_client/src/protocol/koinon/politai_user.dart' as _i4;
import 'package:achaean_client/src/protocol/koinon/polis_definition.dart'
    as _i5;
import 'package:achaean_client/src/protocol/koinon/polis_member.dart' as _i6;
import 'package:achaean_client/src/protocol/koinon/relationships.dart' as _i7;
import 'package:achaean_client/src/protocol/koinon/flag_record.dart' as _i8;
import 'package:achaean_client/src/protocol/koinon/post_reference.dart' as _i9;
import 'protocol.dart' as _i10;

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i3.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i3.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Koinon query endpoints — discovery, agora, trust graph lookups.
/// {@category Endpoint}
class EndpointKoinon extends _i1.EndpointRef {
  EndpointKoinon(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'koinon';

  /// Register a repo URL for indexing (no auth — bootstrap endpoint).
  ///
  /// Used by clients to manually register their repo with the aggregator
  /// (bootstrap for first user on a forge without system webhooks).
  _i2.Future<void> register(String repoUrl) => caller.callServerEndpoint<void>(
    'koinon',
    'register',
    {'repoUrl': repoUrl},
  );

  /// Look up a polites by public key.
  _i2.Future<_i4.PolitaiUser?> getUser(String pubkey) =>
      caller.callServerEndpoint<_i4.PolitaiUser?>(
        'koinon',
        'getUser',
        {'pubkey': pubkey},
      );

  /// List all known poleis.
  _i2.Future<List<_i5.PolisDefinition>> listPoleis() =>
      caller.callServerEndpoint<List<_i5.PolisDefinition>>(
        'koinon',
        'listPoleis',
        {},
      );

  /// Get a polis by repo URL.
  _i2.Future<_i5.PolisDefinition?> getPolis(String repoUrl) =>
      caller.callServerEndpoint<_i5.PolisDefinition?>(
        'koinon',
        'getPolis',
        {'repoUrl': repoUrl},
      );

  /// Get polis members: all signers with their trust connection count.
  ///
  /// Each PolisMember includes isSigner (always true since we start from signers)
  /// and trustConnections (number of mutual trust edges from other signers).
  /// Client compares trustConnections against polis.membershipThreshold.
  _i2.Future<List<_i6.PolisMember>> getPolisMembers(String polisRepoUrl) =>
      caller.callServerEndpoint<List<_i6.PolisMember>>(
        'koinon',
        'getPolisMembers',
        {'polisRepoUrl': polisRepoUrl},
      );

  /// Get all trust and observe relationships for a polites, in both directions.
  _i2.Future<_i7.Relationships> getRelationships(String pubkey) =>
      caller.callServerEndpoint<_i7.Relationships>(
        'koinon',
        'getRelationships',
        {'pubkey': pubkey},
      );

  /// Get all flags for posts in a polis.
  _i2.Future<List<_i8.FlagRecord>> getFlagsForPolis(String polisRepoUrl) =>
      caller.callServerEndpoint<List<_i8.FlagRecord>>(
        'koinon',
        'getFlagsForPolis',
        {'polisRepoUrl': polisRepoUrl},
      );

  /// Get flags on posts by people the caller trusts.
  _i2.Future<List<_i8.FlagRecord>> getFlaggedPostsForVouchers() =>
      caller.callServerEndpoint<List<_i8.FlagRecord>>(
        'koinon',
        'getFlaggedPostsForVouchers',
        {},
      );

  /// Get post references for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns posts from those members.
  _i2.Future<List<_i9.PostReference>> getAgora(
    String polisRepoUrl, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i9.PostReference>>(
    'koinon',
    'getAgora',
    {
      'polisRepoUrl': polisRepoUrl,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get post references from trusted authors (personal feed).
  _i2.Future<List<_i9.PostReference>> getPersonalFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i9.PostReference>>(
    'koinon',
    'getPersonalFeed',
    {
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get all posts in a thread (root + direct replies).
  ///
  /// Returns the root post and all posts whose parentPostUrl matches
  /// the root. Single-level only — nested replies require the client
  /// to call getThread again with a reply's postUrl.
  _i2.Future<List<_i9.PostReference>> getThread(String rootPostUrl) =>
      caller.callServerEndpoint<List<_i9.PostReference>>(
        'koinon',
        'getThread',
        {'rootPostUrl': rootPostUrl},
      );
}

/// Receives Forgejo system webhook push events and indexes Koinon data.
/// {@category Endpoint}
class EndpointWebhook extends _i1.EndpointRef {
  EndpointWebhook(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'webhook';

  /// Processes a Forgejo push webhook payload.
  _i2.Future<void> handlePush(Map<String, dynamic> payload) =>
      caller.callServerEndpoint<void>(
        'webhook',
        'handlePush',
        {'payload': payload},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i10.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    greeting = EndpointGreeting(this);
    koinon = EndpointKoinon(this);
    webhook = EndpointWebhook(this);
  }

  late final EndpointGreeting greeting;

  late final EndpointKoinon koinon;

  late final EndpointWebhook webhook;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'greeting': greeting,
    'koinon': koinon,
    'webhook': webhook,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
