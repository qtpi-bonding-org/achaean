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
import 'package:koinon_index_content_client/src/protocol/post_reference.dart'
    as _i3;
import 'package:koinon_index_content_client/src/protocol/flag_record.dart'
    as _i4;

/// Koinon content query endpoints — feeds, threads, and flag lookups.
/// {@category Endpoint}
class EndpointKoinonContent extends _i1.EndpointRef {
  EndpointKoinonContent(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'koinon_index_content.koinonContent';

  /// Get post references for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns posts from those members
  /// that are tagged for the given polis.
  _i2.Future<List<_i3.PostReference>> getAgora(
    String polisRepoUrl, {
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i3.PostReference>>(
    'koinon_index_content.koinonContent',
    'getAgora',
    {
      'polisRepoUrl': polisRepoUrl,
      'limit': limit,
      'offset': offset,
    },
  );

  /// Get post references from trusted and observed authors (personal feed).
  ///
  /// Includes the caller's own posts.
  _i2.Future<List<_i3.PostReference>> getPersonalFeed({
    required int limit,
    required int offset,
  }) => caller.callServerEndpoint<List<_i3.PostReference>>(
    'koinon_index_content.koinonContent',
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
  _i2.Future<List<_i3.PostReference>> getThread(String rootPostUrl) =>
      caller.callServerEndpoint<List<_i3.PostReference>>(
        'koinon_index_content.koinonContent',
        'getThread',
        {'rootPostUrl': rootPostUrl},
      );

  /// Get all flags for posts in a polis.
  _i2.Future<List<_i4.FlagRecord>> getFlagsForPolis(String polisRepoUrl) =>
      caller.callServerEndpoint<List<_i4.FlagRecord>>(
        'koinon_index_content.koinonContent',
        'getFlagsForPolis',
        {'polisRepoUrl': polisRepoUrl},
      );

  /// Get flags on posts by people the caller trusts.
  _i2.Future<List<_i4.FlagRecord>> getFlaggedPostsForVouchers() =>
      caller.callServerEndpoint<List<_i4.FlagRecord>>(
        'koinon_index_content.koinonContent',
        'getFlaggedPostsForVouchers',
        {},
      );
}

class Caller extends _i1.ModuleEndpointCaller {
  Caller(_i1.ServerpodClientShared client) : super(client) {
    koinonContent = EndpointKoinonContent(this);
  }

  late final EndpointKoinonContent koinonContent;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'koinon_index_content.koinonContent': koinonContent,
  };
}
