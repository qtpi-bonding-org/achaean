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

/// An indexed README cosignature — a polites has signed a polis README.
abstract class ReadmeSignatureRecord implements _i1.SerializableModel {
  ReadmeSignatureRecord._({
    this.id,
    required this.signerPubkey,
    required this.polisRepoUrl,
    required this.readmeCommit,
    required this.readmeHash,
    required this.timestamp,
    required this.indexedAt,
  });

  factory ReadmeSignatureRecord({
    int? id,
    required String signerPubkey,
    required String polisRepoUrl,
    required String readmeCommit,
    required String readmeHash,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) = _ReadmeSignatureRecordImpl;

  factory ReadmeSignatureRecord.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReadmeSignatureRecord(
      id: jsonSerialization['id'] as int?,
      signerPubkey: jsonSerialization['signerPubkey'] as String,
      polisRepoUrl: jsonSerialization['polisRepoUrl'] as String,
      readmeCommit: jsonSerialization['readmeCommit'] as String,
      readmeHash: jsonSerialization['readmeHash'] as String,
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

  /// Public key of the signer.
  String signerPubkey;

  /// Repo URL of the polis whose README was signed.
  String polisRepoUrl;

  /// Commit hash of the README version that was signed.
  String readmeCommit;

  /// Content hash of the README.
  String readmeHash;

  /// When the signature was made.
  DateTime timestamp;

  /// When the aggregator indexed this signature.
  DateTime indexedAt;

  /// Returns a shallow copy of this [ReadmeSignatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ReadmeSignatureRecord copyWith({
    int? id,
    String? signerPubkey,
    String? polisRepoUrl,
    String? readmeCommit,
    String? readmeHash,
    DateTime? timestamp,
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_core.ReadmeSignatureRecord',
      if (id != null) 'id': id,
      'signerPubkey': signerPubkey,
      'polisRepoUrl': polisRepoUrl,
      'readmeCommit': readmeCommit,
      'readmeHash': readmeHash,
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

class _ReadmeSignatureRecordImpl extends ReadmeSignatureRecord {
  _ReadmeSignatureRecordImpl({
    int? id,
    required String signerPubkey,
    required String polisRepoUrl,
    required String readmeCommit,
    required String readmeHash,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         signerPubkey: signerPubkey,
         polisRepoUrl: polisRepoUrl,
         readmeCommit: readmeCommit,
         readmeHash: readmeHash,
         timestamp: timestamp,
         indexedAt: indexedAt,
       );

  /// Returns a shallow copy of this [ReadmeSignatureRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ReadmeSignatureRecord copyWith({
    Object? id = _Undefined,
    String? signerPubkey,
    String? polisRepoUrl,
    String? readmeCommit,
    String? readmeHash,
    DateTime? timestamp,
    DateTime? indexedAt,
  }) {
    return ReadmeSignatureRecord(
      id: id is int? ? id : this.id,
      signerPubkey: signerPubkey ?? this.signerPubkey,
      polisRepoUrl: polisRepoUrl ?? this.polisRepoUrl,
      readmeCommit: readmeCommit ?? this.readmeCommit,
      readmeHash: readmeHash ?? this.readmeHash,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}
