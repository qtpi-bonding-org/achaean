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

/// An indexed polis — a community repo known to the aggregator.
abstract class PolisDefinition implements _i1.SerializableModel {
  PolisDefinition._({
    this.id,
    required this.repoUrl,
    required this.name,
    this.description,
    required this.membershipThreshold,
    required this.flagThreshold,
    this.parentRepoUrl,
    required this.ownerPubkey,
    this.readmeCommit,
    required this.discoveredAt,
    this.lastIndexedAt,
  });

  factory PolisDefinition({
    int? id,
    required String repoUrl,
    required String name,
    String? description,
    required int membershipThreshold,
    required int flagThreshold,
    String? parentRepoUrl,
    required String ownerPubkey,
    String? readmeCommit,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) = _PolisDefinitionImpl;

  factory PolisDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return PolisDefinition(
      id: jsonSerialization['id'] as int?,
      repoUrl: jsonSerialization['repoUrl'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      membershipThreshold: jsonSerialization['membershipThreshold'] as int,
      flagThreshold: jsonSerialization['flagThreshold'] as int,
      parentRepoUrl: jsonSerialization['parentRepoUrl'] as String?,
      ownerPubkey: jsonSerialization['ownerPubkey'] as String,
      readmeCommit: jsonSerialization['readmeCommit'] as String?,
      discoveredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['discoveredAt'],
      ),
      lastIndexedAt: jsonSerialization['lastIndexedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastIndexedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// HTTPS URL of the polis git repo (stable identity).
  String repoUrl;

  /// Display name of the polis.
  String name;

  /// Description / about text.
  String? description;

  /// Membership threshold — mutual trust links required.
  int membershipThreshold;

  /// Flag threshold — number of flags before NSFW blur.
  int flagThreshold;

  /// Parent polis repo URL (null for genesis poleis).
  String? parentRepoUrl;

  /// Public key of the repo owner.
  String ownerPubkey;

  /// Current README commit hash.
  String? readmeCommit;

  /// When the aggregator first discovered this polis.
  DateTime discoveredAt;

  /// When the aggregator last indexed this polis.
  DateTime? lastIndexedAt;

  /// Returns a shallow copy of this [PolisDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PolisDefinition copyWith({
    int? id,
    String? repoUrl,
    String? name,
    String? description,
    int? membershipThreshold,
    int? flagThreshold,
    String? parentRepoUrl,
    String? ownerPubkey,
    String? readmeCommit,
    DateTime? discoveredAt,
    DateTime? lastIndexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_core.PolisDefinition',
      if (id != null) 'id': id,
      'repoUrl': repoUrl,
      'name': name,
      if (description != null) 'description': description,
      'membershipThreshold': membershipThreshold,
      'flagThreshold': flagThreshold,
      if (parentRepoUrl != null) 'parentRepoUrl': parentRepoUrl,
      'ownerPubkey': ownerPubkey,
      if (readmeCommit != null) 'readmeCommit': readmeCommit,
      'discoveredAt': discoveredAt.toJson(),
      if (lastIndexedAt != null) 'lastIndexedAt': lastIndexedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PolisDefinitionImpl extends PolisDefinition {
  _PolisDefinitionImpl({
    int? id,
    required String repoUrl,
    required String name,
    String? description,
    required int membershipThreshold,
    required int flagThreshold,
    String? parentRepoUrl,
    required String ownerPubkey,
    String? readmeCommit,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) : super._(
         id: id,
         repoUrl: repoUrl,
         name: name,
         description: description,
         membershipThreshold: membershipThreshold,
         flagThreshold: flagThreshold,
         parentRepoUrl: parentRepoUrl,
         ownerPubkey: ownerPubkey,
         readmeCommit: readmeCommit,
         discoveredAt: discoveredAt,
         lastIndexedAt: lastIndexedAt,
       );

  /// Returns a shallow copy of this [PolisDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PolisDefinition copyWith({
    Object? id = _Undefined,
    String? repoUrl,
    String? name,
    Object? description = _Undefined,
    int? membershipThreshold,
    int? flagThreshold,
    Object? parentRepoUrl = _Undefined,
    String? ownerPubkey,
    Object? readmeCommit = _Undefined,
    DateTime? discoveredAt,
    Object? lastIndexedAt = _Undefined,
  }) {
    return PolisDefinition(
      id: id is int? ? id : this.id,
      repoUrl: repoUrl ?? this.repoUrl,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      membershipThreshold: membershipThreshold ?? this.membershipThreshold,
      flagThreshold: flagThreshold ?? this.flagThreshold,
      parentRepoUrl: parentRepoUrl is String?
          ? parentRepoUrl
          : this.parentRepoUrl,
      ownerPubkey: ownerPubkey ?? this.ownerPubkey,
      readmeCommit: readmeCommit is String? ? readmeCommit : this.readmeCommit,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      lastIndexedAt: lastIndexedAt is DateTime?
          ? lastIndexedAt
          : this.lastIndexedAt,
    );
  }
}
