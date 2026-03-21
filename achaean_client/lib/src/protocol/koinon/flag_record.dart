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

/// An indexed post flag — a moderation signal from a polis member.
abstract class FlagRecord implements _i1.SerializableModel {
  FlagRecord._({
    this.id,
    required this.flaggedByPubkey,
    required this.postAuthorPubkey,
    required this.postUrl,
    required this.polisRepoUrl,
    required this.reason,
    required this.timestamp,
    required this.indexedAt,
  });

  factory FlagRecord({
    int? id,
    required String flaggedByPubkey,
    required String postAuthorPubkey,
    required String postUrl,
    required String polisRepoUrl,
    required String reason,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) = _FlagRecordImpl;

  factory FlagRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlagRecord(
      id: jsonSerialization['id'] as int?,
      flaggedByPubkey: jsonSerialization['flaggedByPubkey'] as String,
      postAuthorPubkey: jsonSerialization['postAuthorPubkey'] as String,
      postUrl: jsonSerialization['postUrl'] as String,
      polisRepoUrl: jsonSerialization['polisRepoUrl'] as String,
      reason: jsonSerialization['reason'] as String,
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

  /// Public key of the flagger.
  String flaggedByPubkey;

  /// Public key of the post author.
  String postAuthorPubkey;

  /// Full URL to the flagged post.json.
  String postUrl;

  /// Polis repo URL where this flag applies.
  String polisRepoUrl;

  /// Free-form reason for flagging.
  String reason;

  /// When the flag was made.
  DateTime timestamp;

  /// When the aggregator indexed this flag.
  DateTime indexedAt;

  /// Returns a shallow copy of this [FlagRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlagRecord copyWith({
    int? id,
    String? flaggedByPubkey,
    String? postAuthorPubkey,
    String? postUrl,
    String? polisRepoUrl,
    String? reason,
    DateTime? timestamp,
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlagRecord',
      if (id != null) 'id': id,
      'flaggedByPubkey': flaggedByPubkey,
      'postAuthorPubkey': postAuthorPubkey,
      'postUrl': postUrl,
      'polisRepoUrl': polisRepoUrl,
      'reason': reason,
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

class _FlagRecordImpl extends FlagRecord {
  _FlagRecordImpl({
    int? id,
    required String flaggedByPubkey,
    required String postAuthorPubkey,
    required String postUrl,
    required String polisRepoUrl,
    required String reason,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         flaggedByPubkey: flaggedByPubkey,
         postAuthorPubkey: postAuthorPubkey,
         postUrl: postUrl,
         polisRepoUrl: polisRepoUrl,
         reason: reason,
         timestamp: timestamp,
         indexedAt: indexedAt,
       );

  /// Returns a shallow copy of this [FlagRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FlagRecord copyWith({
    Object? id = _Undefined,
    String? flaggedByPubkey,
    String? postAuthorPubkey,
    String? postUrl,
    String? polisRepoUrl,
    String? reason,
    DateTime? timestamp,
    DateTime? indexedAt,
  }) {
    return FlagRecord(
      id: id is int? ? id : this.id,
      flaggedByPubkey: flaggedByPubkey ?? this.flaggedByPubkey,
      postAuthorPubkey: postAuthorPubkey ?? this.postAuthorPubkey,
      postUrl: postUrl ?? this.postUrl,
      polisRepoUrl: polisRepoUrl ?? this.polisRepoUrl,
      reason: reason ?? this.reason,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}
