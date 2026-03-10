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
import 'package:serverpod/serverpod.dart' as _i1;

/// A cached post — full content from a polites's RSS feed.
abstract class CachedPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = CachedPostTable();

  static const db = CachedPostRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static CachedPostInclude include() {
    return CachedPostInclude._();
  }

  static CachedPostIncludeList includeList({
    _i1.WhereExpressionBuilder<CachedPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CachedPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CachedPostTable>? orderByList,
    CachedPostInclude? include,
  }) {
    return CachedPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(CachedPost.t),
      include: include,
    );
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

class CachedPostUpdateTable extends _i1.UpdateTable<CachedPostTable> {
  CachedPostUpdateTable(super.table);

  _i1.ColumnValue<String, String> authorPubkey(String value) => _i1.ColumnValue(
    table.authorPubkey,
    value,
  );

  _i1.ColumnValue<String, String> authorRepoUrl(String value) =>
      _i1.ColumnValue(
        table.authorRepoUrl,
        value,
      );

  _i1.ColumnValue<String, String> path(String value) => _i1.ColumnValue(
    table.path,
    value,
  );

  _i1.ColumnValue<String, String> commitHash(String value) => _i1.ColumnValue(
    table.commitHash,
    value,
  );

  _i1.ColumnValue<String, String> link(String value) => _i1.ColumnValue(
    table.link,
    value,
  );

  _i1.ColumnValue<String, String> title(String? value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> text(String value) => _i1.ColumnValue(
    table.text,
    value,
  );

  _i1.ColumnValue<String, String> poleisTags(String? value) => _i1.ColumnValue(
    table.poleisTags,
    value,
  );

  _i1.ColumnValue<String, String> tags(String? value) => _i1.ColumnValue(
    table.tags,
    value,
  );

  _i1.ColumnValue<bool, bool> isReply(bool value) => _i1.ColumnValue(
    table.isReply,
    value,
  );

  _i1.ColumnValue<String, String> parentAuthorPubkey(String? value) =>
      _i1.ColumnValue(
        table.parentAuthorPubkey,
        value,
      );

  _i1.ColumnValue<String, String> parentPath(String? value) => _i1.ColumnValue(
    table.parentPath,
    value,
  );

  _i1.ColumnValue<String, String> contentJson(String value) => _i1.ColumnValue(
    table.contentJson,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> indexedAt(DateTime value) =>
      _i1.ColumnValue(
        table.indexedAt,
        value,
      );

  _i1.ColumnValue<String, String> signature(String value) => _i1.ColumnValue(
    table.signature,
    value,
  );
}

class CachedPostTable extends _i1.Table<int?> {
  CachedPostTable({super.tableRelation}) : super(tableName: 'cached_posts') {
    updateTable = CachedPostUpdateTable(this);
    authorPubkey = _i1.ColumnString(
      'authorPubkey',
      this,
    );
    authorRepoUrl = _i1.ColumnString(
      'authorRepoUrl',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
    );
    commitHash = _i1.ColumnString(
      'commitHash',
      this,
    );
    link = _i1.ColumnString(
      'link',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    text = _i1.ColumnString(
      'text',
      this,
    );
    poleisTags = _i1.ColumnString(
      'poleisTags',
      this,
    );
    tags = _i1.ColumnString(
      'tags',
      this,
    );
    isReply = _i1.ColumnBool(
      'isReply',
      this,
    );
    parentAuthorPubkey = _i1.ColumnString(
      'parentAuthorPubkey',
      this,
    );
    parentPath = _i1.ColumnString(
      'parentPath',
      this,
    );
    contentJson = _i1.ColumnString(
      'contentJson',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    indexedAt = _i1.ColumnDateTime(
      'indexedAt',
      this,
    );
    signature = _i1.ColumnString(
      'signature',
      this,
    );
  }

  late final CachedPostUpdateTable updateTable;

  /// Public key of the post author.
  late final _i1.ColumnString authorPubkey;

  /// Repo URL of the author.
  late final _i1.ColumnString authorRepoUrl;

  /// Path to post.json in the repo (e.g. posts/2026-03-08-hello/post.json).
  late final _i1.ColumnString path;

  /// Git commit hash of this version of the post.
  late final _i1.ColumnString commitHash;

  /// Full URL to post.json in the forge (link element in RSS).
  late final _i1.ColumnString link;

  /// Post title (if present, for search/display).
  late final _i1.ColumnString title;

  /// Post text body.
  late final _i1.ColumnString text;

  /// Polis repo URLs this post is tagged for (comma-separated).
  late final _i1.ColumnString poleisTags;

  /// Hashtags / topic tags (comma-separated).
  late final _i1.ColumnString tags;

  /// Whether this is a reply (has parent reference).
  late final _i1.ColumnBool isReply;

  /// Parent post author pubkey (for thread assembly).
  late final _i1.ColumnString parentAuthorPubkey;

  /// Parent post path (for thread assembly).
  late final _i1.ColumnString parentPath;

  /// Complete post.json as JSON string (returned to clients).
  late final _i1.ColumnString contentJson;

  /// When the post was created.
  late final _i1.ColumnDateTime timestamp;

  /// When the aggregator indexed this post.
  late final _i1.ColumnDateTime indexedAt;

  /// Author's signature for verification.
  late final _i1.ColumnString signature;

  @override
  List<_i1.Column> get columns => [
    id,
    authorPubkey,
    authorRepoUrl,
    path,
    commitHash,
    link,
    title,
    text,
    poleisTags,
    tags,
    isReply,
    parentAuthorPubkey,
    parentPath,
    contentJson,
    timestamp,
    indexedAt,
    signature,
  ];
}

class CachedPostInclude extends _i1.IncludeObject {
  CachedPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => CachedPost.t;
}

class CachedPostIncludeList extends _i1.IncludeList {
  CachedPostIncludeList._({
    _i1.WhereExpressionBuilder<CachedPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CachedPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => CachedPost.t;
}

class CachedPostRepository {
  const CachedPostRepository._();

  /// Returns a list of [CachedPost]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<CachedPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CachedPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CachedPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CachedPostTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CachedPost>(
      where: where?.call(CachedPost.t),
      orderBy: orderBy?.call(CachedPost.t),
      orderByList: orderByList?.call(CachedPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CachedPost] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<CachedPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CachedPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<CachedPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<CachedPostTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CachedPost>(
      where: where?.call(CachedPost.t),
      orderBy: orderBy?.call(CachedPost.t),
      orderByList: orderByList?.call(CachedPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CachedPost] by its [id] or null if no such row exists.
  Future<CachedPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CachedPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CachedPost]s in the list and returns the inserted rows.
  ///
  /// The returned [CachedPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<CachedPost>> insert(
    _i1.Session session,
    List<CachedPost> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<CachedPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [CachedPost] and returns the inserted row.
  ///
  /// The returned [CachedPost] will have its `id` field set.
  Future<CachedPost> insertRow(
    _i1.Session session,
    CachedPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<CachedPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [CachedPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<CachedPost>> update(
    _i1.Session session,
    List<CachedPost> rows, {
    _i1.ColumnSelections<CachedPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<CachedPost>(
      rows,
      columns: columns?.call(CachedPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CachedPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CachedPost> updateRow(
    _i1.Session session,
    CachedPost row, {
    _i1.ColumnSelections<CachedPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<CachedPost>(
      row,
      columns: columns?.call(CachedPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CachedPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CachedPost?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<CachedPostUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<CachedPost>(
      id,
      columnValues: columnValues(CachedPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CachedPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<CachedPost>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<CachedPostUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<CachedPostTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<CachedPostTable>? orderBy,
    _i1.OrderByListBuilder<CachedPostTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<CachedPost>(
      columnValues: columnValues(CachedPost.t.updateTable),
      where: where(CachedPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedPost.t),
      orderByList: orderByList?.call(CachedPost.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [CachedPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<CachedPost>> delete(
    _i1.Session session,
    List<CachedPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<CachedPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [CachedPost].
  Future<CachedPost> deleteRow(
    _i1.Session session,
    CachedPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CachedPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<CachedPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CachedPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<CachedPost>(
      where: where(CachedPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<CachedPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<CachedPost>(
      where: where?.call(CachedPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CachedPost] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<CachedPostTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CachedPost>(
      where: where(CachedPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
