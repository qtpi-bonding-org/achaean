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

/// An indexed trust declaration — an edge in the trust graph.
abstract class TrustDeclarationRecord implements _i1.SerializableModel {
  TrustDeclarationRecord._({
    this.id,
    required this.fromPubkey,
    required this.toPubkey,
    required this.subjectRepoUrl,
    required this.level,
    required this.timestamp,
    required this.indexedAt,
  });

  factory TrustDeclarationRecord({
    int? id,
    required String fromPubkey,
    required String toPubkey,
    required String subjectRepoUrl,
    required String level,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) = _TrustDeclarationRecordImpl;

  factory TrustDeclarationRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TrustDeclarationRecord(
      id: jsonSerialization['id'] as int?,
      fromPubkey: jsonSerialization['fromPubkey'] as String,
      toPubkey: jsonSerialization['toPubkey'] as String,
      subjectRepoUrl: jsonSerialization['subjectRepoUrl'] as String,
      level: jsonSerialization['level'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      indexedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['indexedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Public key of the truster (author).
  String fromPubkey;

  /// Public key of the trusted subject.
  String toPubkey;

  /// Repo URL of the subject (for graph traversal).
  String subjectRepoUrl;

  /// Trust level: "trust" or "provisional".
  String level;

  /// When the declaration was made.
  DateTime timestamp;

  /// When the aggregator indexed this declaration.
  DateTime indexedAt;

  /// Returns a shallow copy of this [TrustDeclarationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TrustDeclarationRecord copyWith({
    int? id,
    String? fromPubkey,
    String? toPubkey,
    String? subjectRepoUrl,
    String? level,
    DateTime? timestamp,
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TrustDeclarationRecord',
      if (id != null) 'id': id,
      'fromPubkey': fromPubkey,
      'toPubkey': toPubkey,
      'subjectRepoUrl': subjectRepoUrl,
      'level': level,
      'timestamp': timestamp.toJson(),
      'indexedAt': indexedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TrustDeclarationRecordImpl extends TrustDeclarationRecord {
  _TrustDeclarationRecordImpl({
    int? id,
    required String fromPubkey,
    required String toPubkey,
    required String subjectRepoUrl,
    required String level,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         fromPubkey: fromPubkey,
         toPubkey: toPubkey,
         subjectRepoUrl: subjectRepoUrl,
         level: level,
         timestamp: timestamp,
         indexedAt: indexedAt,
       );

  /// Returns a shallow copy of this [TrustDeclarationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TrustDeclarationRecord copyWith({
    Object? id = _Undefined,
    String? fromPubkey,
    String? toPubkey,
    String? subjectRepoUrl,
    String? level,
    DateTime? timestamp,
    DateTime? indexedAt,
  }) {
    return TrustDeclarationRecord(
      id: id is int? ? id : this.id,
      fromPubkey: fromPubkey ?? this.fromPubkey,
      toPubkey: toPubkey ?? this.toPubkey,
      subjectRepoUrl: subjectRepoUrl ?? this.subjectRepoUrl,
      level: level ?? this.level,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}
