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

/// A cached post — full content from a polites's RSS feed.
abstract class CachedPost implements _i1.SerializableModel {
  CachedPost._({
    this.id,
    required this.authorPubkey,
    required this.authorRepoUrl,
    required this.path,
    required this.commitHash,
    required this.link,
    this.title,
    required this.text,
    this.poleisTags,
    this.tags,
    required this.isReply,
    this.parentAuthorPubkey,
    this.parentPath,
    required this.contentJson,
    required this.timestamp,
    required this.indexedAt,
    required this.signature,
  });

  factory CachedPost({
    int? id,
    required String authorPubkey,
    required String authorRepoUrl,
    required String path,
    required String commitHash,
    required String link,
    String? title,
    required String text,
    String? poleisTags,
    String? tags,
    required bool isReply,
    String? parentAuthorPubkey,
    String? parentPath,
    required String contentJson,
    required DateTime timestamp,
    required DateTime indexedAt,
    required String signature,
  }) = _CachedPostImpl;

  factory CachedPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedPost(
      id: jsonSerialization['id'] as int?,
      authorPubkey: jsonSerialization['authorPubkey'] as String,
      authorRepoUrl: jsonSerialization['authorRepoUrl'] as String,
      path: jsonSerialization['path'] as String,
      commitHash: jsonSerialization['commitHash'] as String,
      link: jsonSerialization['link'] as String,
      title: jsonSerialization['title'] as String?,
      text: jsonSerialization['text'] as String,
      poleisTags: jsonSerialization['poleisTags'] as String?,
      tags: jsonSerialization['tags'] as String?,
      isReply: _i1.BoolJsonExtension.fromJson(jsonSerialization['isReply']),
      parentAuthorPubkey: jsonSerialization['parentAuthorPubkey'] as String?,
      parentPath: jsonSerialization['parentPath'] as String?,
      contentJson: jsonSerialization['contentJson'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      indexedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['indexedAt'],
      ),
      signature: jsonSerialization['signature'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Public key of the post author.
  String authorPubkey;

  /// Repo URL of the author.
  String authorRepoUrl;

  /// Path to post.json in the repo (e.g. posts/2026-03-08-hello/post.json).
  String path;

  /// Git commit hash of this version of the post.
  String commitHash;

  /// Full URL to post.json in the forge (link element in RSS).
  String link;

  /// Post title (if present, for search/display).
  String? title;

  /// Post text body.
  String text;

  /// Polis repo URLs this post is tagged for (comma-separated).
  String? poleisTags;

  /// Hashtags / topic tags (comma-separated).
  String? tags;

  /// Whether this is a reply (has parent reference).
  bool isReply;

  /// Parent post author pubkey (for thread assembly).
  String? parentAuthorPubkey;

  /// Parent post path (for thread assembly).
  String? parentPath;

  /// Complete post.json as JSON string (returned to clients).
  String contentJson;

  /// When the post was created.
  DateTime timestamp;

  /// When the aggregator indexed this post.
  DateTime indexedAt;

  /// Author's signature for verification.
  String signature;

  /// Returns a shallow copy of this [CachedPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CachedPost copyWith({
    int? id,
    String? authorPubkey,
    String? authorRepoUrl,
    String? path,
    String? commitHash,
    String? link,
    String? title,
    String? text,
    String? poleisTags,
    String? tags,
    bool? isReply,
    String? parentAuthorPubkey,
    String? parentPath,
    String? contentJson,
    DateTime? timestamp,
    DateTime? indexedAt,
    String? signature,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedPost',
      if (id != null) 'id': id,
      'authorPubkey': authorPubkey,
      'authorRepoUrl': authorRepoUrl,
      'path': path,
      'commitHash': commitHash,
      'link': link,
      if (title != null) 'title': title,
      'text': text,
      if (poleisTags != null) 'poleisTags': poleisTags,
      if (tags != null) 'tags': tags,
      'isReply': isReply,
      if (parentAuthorPubkey != null) 'parentAuthorPubkey': parentAuthorPubkey,
      if (parentPath != null) 'parentPath': parentPath,
      'contentJson': contentJson,
      'timestamp': timestamp.toJson(),
      'indexedAt': indexedAt.toJson(),
      'signature': signature,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachedPostImpl extends CachedPost {
  _CachedPostImpl({
    int? id,
    required String authorPubkey,
    required String authorRepoUrl,
    required String path,
    required String commitHash,
    required String link,
    String? title,
    required String text,
    String? poleisTags,
    String? tags,
    required bool isReply,
    String? parentAuthorPubkey,
    String? parentPath,
    required String contentJson,
    required DateTime timestamp,
    required DateTime indexedAt,
    required String signature,
  }) : super._(
         id: id,
         authorPubkey: authorPubkey,
         authorRepoUrl: authorRepoUrl,
         path: path,
         commitHash: commitHash,
         link: link,
         title: title,
         text: text,
         poleisTags: poleisTags,
         tags: tags,
         isReply: isReply,
         parentAuthorPubkey: parentAuthorPubkey,
         parentPath: parentPath,
         contentJson: contentJson,
         timestamp: timestamp,
         indexedAt: indexedAt,
         signature: signature,
       );

  /// Returns a shallow copy of this [CachedPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CachedPost copyWith({
    Object? id = _Undefined,
    String? authorPubkey,
    String? authorRepoUrl,
    String? path,
    String? commitHash,
    String? link,
    Object? title = _Undefined,
    String? text,
    Object? poleisTags = _Undefined,
    Object? tags = _Undefined,
    bool? isReply,
    Object? parentAuthorPubkey = _Undefined,
    Object? parentPath = _Undefined,
    String? contentJson,
    DateTime? timestamp,
    DateTime? indexedAt,
    String? signature,
  }) {
    return CachedPost(
      id: id is int? ? id : this.id,
      authorPubkey: authorPubkey ?? this.authorPubkey,
      authorRepoUrl: authorRepoUrl ?? this.authorRepoUrl,
      path: path ?? this.path,
      commitHash: commitHash ?? this.commitHash,
      link: link ?? this.link,
      title: title is String? ? title : this.title,
      text: text ?? this.text,
      poleisTags: poleisTags is String? ? poleisTags : this.poleisTags,
      tags: tags is String? ? tags : this.tags,
      isReply: isReply ?? this.isReply,
      parentAuthorPubkey: parentAuthorPubkey is String?
          ? parentAuthorPubkey
          : this.parentAuthorPubkey,
      parentPath: parentPath is String? ? parentPath : this.parentPath,
      contentJson: contentJson ?? this.contentJson,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
      signature: signature ?? this.signature,
    );
  }
}
