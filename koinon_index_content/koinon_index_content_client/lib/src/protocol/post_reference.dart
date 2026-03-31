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

/// An indexed post reference — a metadata pointer to a post in a polites's repo.
abstract class PostReference implements _i1.SerializableModel {
  PostReference._({
    this.id,
    required this.authorPubkey,
    required this.authorRepoUrl,
    required this.postUrl,
    required this.commitHash,
    this.title,
    this.poleisTags,
    required this.timestamp,
    this.parentPostUrl,
    required this.encrypted,
    required this.indexedAt,
  });

  factory PostReference({
    int? id,
    required String authorPubkey,
    required String authorRepoUrl,
    required String postUrl,
    required String commitHash,
    String? title,
    String? poleisTags,
    required DateTime timestamp,
    String? parentPostUrl,
    required bool encrypted,
    required DateTime indexedAt,
  }) = _PostReferenceImpl;

  factory PostReference.fromJson(Map<String, dynamic> jsonSerialization) {
    return PostReference(
      id: jsonSerialization['id'] as int?,
      authorPubkey: jsonSerialization['authorPubkey'] as String,
      authorRepoUrl: jsonSerialization['authorRepoUrl'] as String,
      postUrl: jsonSerialization['postUrl'] as String,
      commitHash: jsonSerialization['commitHash'] as String,
      title: jsonSerialization['title'] as String?,
      poleisTags: jsonSerialization['poleisTags'] as String?,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      parentPostUrl: jsonSerialization['parentPostUrl'] as String?,
      encrypted: _i1.BoolJsonExtension.fromJson(jsonSerialization['encrypted']),
      indexedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['indexedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Public key of the post author.
  String authorPubkey;

  /// Repo URL of the author (e.g. https://forge.example/alice/koinon).
  String authorRepoUrl;

  /// Full URL to the post.json file on the forge.
  String postUrl;

  /// Git commit hash of this version of the post.
  String commitHash;

  /// Post title (if present, for search/display).
  String? title;

  /// Polis repo URLs this post is tagged for (comma-separated).
  String? poleisTags;

  /// When the post was created.
  DateTime timestamp;

  /// Full URL to the parent post.json (if this is a reply).
  String? parentPostUrl;

  /// Whether this post is encrypted.
  bool encrypted;

  /// When the aggregator indexed this post.
  DateTime indexedAt;

  /// Returns a shallow copy of this [PostReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PostReference copyWith({
    int? id,
    String? authorPubkey,
    String? authorRepoUrl,
    String? postUrl,
    String? commitHash,
    String? title,
    String? poleisTags,
    DateTime? timestamp,
    String? parentPostUrl,
    bool? encrypted,
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_content.PostReference',
      if (id != null) 'id': id,
      'authorPubkey': authorPubkey,
      'authorRepoUrl': authorRepoUrl,
      'postUrl': postUrl,
      'commitHash': commitHash,
      if (title != null) 'title': title,
      if (poleisTags != null) 'poleisTags': poleisTags,
      'timestamp': timestamp.toJson(),
      if (parentPostUrl != null) 'parentPostUrl': parentPostUrl,
      'encrypted': encrypted,
      'indexedAt': indexedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PostReferenceImpl extends PostReference {
  _PostReferenceImpl({
    int? id,
    required String authorPubkey,
    required String authorRepoUrl,
    required String postUrl,
    required String commitHash,
    String? title,
    String? poleisTags,
    required DateTime timestamp,
    String? parentPostUrl,
    required bool encrypted,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         authorPubkey: authorPubkey,
         authorRepoUrl: authorRepoUrl,
         postUrl: postUrl,
         commitHash: commitHash,
         title: title,
         poleisTags: poleisTags,
         timestamp: timestamp,
         parentPostUrl: parentPostUrl,
         encrypted: encrypted,
         indexedAt: indexedAt,
       );

  /// Returns a shallow copy of this [PostReference]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PostReference copyWith({
    Object? id = _Undefined,
    String? authorPubkey,
    String? authorRepoUrl,
    String? postUrl,
    String? commitHash,
    Object? title = _Undefined,
    Object? poleisTags = _Undefined,
    DateTime? timestamp,
    Object? parentPostUrl = _Undefined,
    bool? encrypted,
    DateTime? indexedAt,
  }) {
    return PostReference(
      id: id is int? ? id : this.id,
      authorPubkey: authorPubkey ?? this.authorPubkey,
      authorRepoUrl: authorRepoUrl ?? this.authorRepoUrl,
      postUrl: postUrl ?? this.postUrl,
      commitHash: commitHash ?? this.commitHash,
      title: title is String? ? title : this.title,
      poleisTags: poleisTags is String? ? poleisTags : this.poleisTags,
      timestamp: timestamp ?? this.timestamp,
      parentPostUrl: parentPostUrl is String?
          ? parentPostUrl
          : this.parentPostUrl,
      encrypted: encrypted ?? this.encrypted,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}
