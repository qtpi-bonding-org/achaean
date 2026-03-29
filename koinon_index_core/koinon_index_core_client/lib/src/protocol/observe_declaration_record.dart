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

/// An indexed observe declaration — non-structural, personal feed only.
abstract class ObserveDeclarationRecord implements _i1.SerializableModel {
  ObserveDeclarationRecord._({
    this.id,
    required this.fromPubkey,
    required this.toPubkey,
    required this.subjectRepoUrl,
    required this.timestamp,
    required this.indexedAt,
  });

  factory ObserveDeclarationRecord({
    int? id,
    required String fromPubkey,
    required String toPubkey,
    required String subjectRepoUrl,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) = _ObserveDeclarationRecordImpl;

  factory ObserveDeclarationRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ObserveDeclarationRecord(
      id: jsonSerialization['id'] as int?,
      fromPubkey: jsonSerialization['fromPubkey'] as String,
      toPubkey: jsonSerialization['toPubkey'] as String,
      subjectRepoUrl: jsonSerialization['subjectRepoUrl'] as String,
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

  /// Public key of the observer (author).
  String fromPubkey;

  /// Public key of the observed subject.
  String toPubkey;

  /// Repo URL of the subject (for discovery).
  String subjectRepoUrl;

  /// When the declaration was made.
  DateTime timestamp;

  /// When the aggregator indexed this declaration.
  DateTime indexedAt;

  /// Returns a shallow copy of this [ObserveDeclarationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ObserveDeclarationRecord copyWith({
    int? id,
    String? fromPubkey,
    String? toPubkey,
    String? subjectRepoUrl,
    DateTime? timestamp,
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_core.ObserveDeclarationRecord',
      if (id != null) 'id': id,
      'fromPubkey': fromPubkey,
      'toPubkey': toPubkey,
      'subjectRepoUrl': subjectRepoUrl,
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

class _ObserveDeclarationRecordImpl extends ObserveDeclarationRecord {
  _ObserveDeclarationRecordImpl({
    int? id,
    required String fromPubkey,
    required String toPubkey,
    required String subjectRepoUrl,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         fromPubkey: fromPubkey,
         toPubkey: toPubkey,
         subjectRepoUrl: subjectRepoUrl,
         timestamp: timestamp,
         indexedAt: indexedAt,
       );

  /// Returns a shallow copy of this [ObserveDeclarationRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ObserveDeclarationRecord copyWith({
    Object? id = _Undefined,
    String? fromPubkey,
    String? toPubkey,
    String? subjectRepoUrl,
    DateTime? timestamp,
    DateTime? indexedAt,
  }) {
    return ObserveDeclarationRecord(
      id: id is int? ? id : this.id,
      fromPubkey: fromPubkey ?? this.fromPubkey,
      toPubkey: toPubkey ?? this.toPubkey,
      subjectRepoUrl: subjectRepoUrl ?? this.subjectRepoUrl,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}
