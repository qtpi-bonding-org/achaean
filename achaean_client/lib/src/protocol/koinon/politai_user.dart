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

/// An indexed polites (user) discovered by the aggregator.
abstract class PolitaiUser implements _i1.SerializableModel {
  PolitaiUser._({
    this.id,
    required this.pubkey,
    required this.repoUrl,
    this.displayName,
    required this.discoveredAt,
    this.lastIndexedAt,
  });

  factory PolitaiUser({
    int? id,
    required String pubkey,
    required String repoUrl,
    String? displayName,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) = _PolitaiUserImpl;

  factory PolitaiUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return PolitaiUser(
      id: jsonSerialization['id'] as int?,
      pubkey: jsonSerialization['pubkey'] as String,
      repoUrl: jsonSerialization['repoUrl'] as String,
      displayName: jsonSerialization['displayName'] as String?,
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

  /// The polites's public key (unique identity).
  String pubkey;

  /// HTTPS URL of the polites's git repo.
  String repoUrl;

  /// Display name (optional, from profile).
  String? displayName;

  /// When the aggregator first discovered this user.
  DateTime discoveredAt;

  /// When the aggregator last indexed this user's repo.
  DateTime? lastIndexedAt;

  /// Returns a shallow copy of this [PolitaiUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PolitaiUser copyWith({
    int? id,
    String? pubkey,
    String? repoUrl,
    String? displayName,
    DateTime? discoveredAt,
    DateTime? lastIndexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PolitaiUser',
      if (id != null) 'id': id,
      'pubkey': pubkey,
      'repoUrl': repoUrl,
      if (displayName != null) 'displayName': displayName,
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

class _PolitaiUserImpl extends PolitaiUser {
  _PolitaiUserImpl({
    int? id,
    required String pubkey,
    required String repoUrl,
    String? displayName,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) : super._(
         id: id,
         pubkey: pubkey,
         repoUrl: repoUrl,
         displayName: displayName,
         discoveredAt: discoveredAt,
         lastIndexedAt: lastIndexedAt,
       );

  /// Returns a shallow copy of this [PolitaiUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PolitaiUser copyWith({
    Object? id = _Undefined,
    String? pubkey,
    String? repoUrl,
    Object? displayName = _Undefined,
    DateTime? discoveredAt,
    Object? lastIndexedAt = _Undefined,
  }) {
    return PolitaiUser(
      id: id is int? ? id : this.id,
      pubkey: pubkey ?? this.pubkey,
      repoUrl: repoUrl ?? this.repoUrl,
      displayName: displayName is String? ? displayName : this.displayName,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      lastIndexedAt: lastIndexedAt is DateTime?
          ? lastIndexedAt
          : this.lastIndexedAt,
    );
  }
}
