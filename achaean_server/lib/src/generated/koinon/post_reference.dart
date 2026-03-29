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

/// An indexed post reference — a metadata pointer to a post in a polites's repo.
abstract class PostReference
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
      indexedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['indexedAt'],
      ),
    );
  }

  static final t = PostReferenceTable();

  static const db = PostReferenceRepository._();

  @override
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

  /// When the aggregator indexed this post.
  DateTime indexedAt;

  @override
  _i1.Table<int?> get table => t;

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
    DateTime? indexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PostReference',
      if (id != null) 'id': id,
      'authorPubkey': authorPubkey,
      'authorRepoUrl': authorRepoUrl,
      'postUrl': postUrl,
      'commitHash': commitHash,
      if (title != null) 'title': title,
      if (poleisTags != null) 'poleisTags': poleisTags,
      'timestamp': timestamp.toJson(),
      if (parentPostUrl != null) 'parentPostUrl': parentPostUrl,
      'indexedAt': indexedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PostReference',
      if (id != null) 'id': id,
      'authorPubkey': authorPubkey,
      'authorRepoUrl': authorRepoUrl,
      'postUrl': postUrl,
      'commitHash': commitHash,
      if (title != null) 'title': title,
      if (poleisTags != null) 'poleisTags': poleisTags,
      'timestamp': timestamp.toJson(),
      if (parentPostUrl != null) 'parentPostUrl': parentPostUrl,
      'indexedAt': indexedAt.toJson(),
    };
  }

  static PostReferenceInclude include() {
    return PostReferenceInclude._();
  }

  static PostReferenceIncludeList includeList({
    _i1.WhereExpressionBuilder<PostReferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostReferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostReferenceTable>? orderByList,
    PostReferenceInclude? include,
  }) {
    return PostReferenceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostReference.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PostReference.t),
      include: include,
    );
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
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}

class PostReferenceUpdateTable extends _i1.UpdateTable<PostReferenceTable> {
  PostReferenceUpdateTable(super.table);

  _i1.ColumnValue<String, String> authorPubkey(String value) => _i1.ColumnValue(
    table.authorPubkey,
    value,
  );

  _i1.ColumnValue<String, String> authorRepoUrl(String value) =>
      _i1.ColumnValue(
        table.authorRepoUrl,
        value,
      );

  _i1.ColumnValue<String, String> postUrl(String value) => _i1.ColumnValue(
    table.postUrl,
    value,
  );

  _i1.ColumnValue<String, String> commitHash(String value) => _i1.ColumnValue(
    table.commitHash,
    value,
  );

  _i1.ColumnValue<String, String> title(String? value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> poleisTags(String? value) => _i1.ColumnValue(
    table.poleisTags,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> timestamp(DateTime value) =>
      _i1.ColumnValue(
        table.timestamp,
        value,
      );

  _i1.ColumnValue<String, String> parentPostUrl(String? value) =>
      _i1.ColumnValue(
        table.parentPostUrl,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> indexedAt(DateTime value) =>
      _i1.ColumnValue(
        table.indexedAt,
        value,
      );
}

class PostReferenceTable extends _i1.Table<int?> {
  PostReferenceTable({super.tableRelation})
    : super(tableName: 'post_references') {
    updateTable = PostReferenceUpdateTable(this);
    authorPubkey = _i1.ColumnString(
      'authorPubkey',
      this,
    );
    authorRepoUrl = _i1.ColumnString(
      'authorRepoUrl',
      this,
    );
    postUrl = _i1.ColumnString(
      'postUrl',
      this,
    );
    commitHash = _i1.ColumnString(
      'commitHash',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    poleisTags = _i1.ColumnString(
      'poleisTags',
      this,
    );
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    parentPostUrl = _i1.ColumnString(
      'parentPostUrl',
      this,
    );
    indexedAt = _i1.ColumnDateTime(
      'indexedAt',
      this,
    );
  }

  late final PostReferenceUpdateTable updateTable;

  /// Public key of the post author.
  late final _i1.ColumnString authorPubkey;

  /// Repo URL of the author (e.g. https://forge.example/alice/koinon).
  late final _i1.ColumnString authorRepoUrl;

  /// Full URL to the post.json file on the forge.
  late final _i1.ColumnString postUrl;

  /// Git commit hash of this version of the post.
  late final _i1.ColumnString commitHash;

  /// Post title (if present, for search/display).
  late final _i1.ColumnString title;

  /// Polis repo URLs this post is tagged for (comma-separated).
  late final _i1.ColumnString poleisTags;

  /// When the post was created.
  late final _i1.ColumnDateTime timestamp;

  /// Full URL to the parent post.json (if this is a reply).
  late final _i1.ColumnString parentPostUrl;

  /// When the aggregator indexed this post.
  late final _i1.ColumnDateTime indexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    authorPubkey,
    authorRepoUrl,
    postUrl,
    commitHash,
    title,
    poleisTags,
    timestamp,
    parentPostUrl,
    indexedAt,
  ];
}

class PostReferenceInclude extends _i1.IncludeObject {
  PostReferenceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PostReference.t;
}

class PostReferenceIncludeList extends _i1.IncludeList {
  PostReferenceIncludeList._({
    _i1.WhereExpressionBuilder<PostReferenceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PostReference.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PostReference.t;
}

class PostReferenceRepository {
  const PostReferenceRepository._();

  /// Returns a list of [PostReference]s matching the given query parameters.
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
  Future<List<PostReference>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PostReferenceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostReferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostReferenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PostReference>(
      where: where?.call(PostReference.t),
      orderBy: orderBy?.call(PostReference.t),
      orderByList: orderByList?.call(PostReference.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PostReference] matching the given query parameters.
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
  Future<PostReference?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PostReferenceTable>? where,
    int? offset,
    _i1.OrderByBuilder<PostReferenceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PostReferenceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PostReference>(
      where: where?.call(PostReference.t),
      orderBy: orderBy?.call(PostReference.t),
      orderByList: orderByList?.call(PostReference.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PostReference] by its [id] or null if no such row exists.
  Future<PostReference?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PostReference>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PostReference]s in the list and returns the inserted rows.
  ///
  /// The returned [PostReference]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PostReference>> insert(
    _i1.DatabaseSession session,
    List<PostReference> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PostReference>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PostReference] and returns the inserted row.
  ///
  /// The returned [PostReference] will have its `id` field set.
  Future<PostReference> insertRow(
    _i1.DatabaseSession session,
    PostReference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PostReference>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PostReference]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PostReference>> update(
    _i1.DatabaseSession session,
    List<PostReference> rows, {
    _i1.ColumnSelections<PostReferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PostReference>(
      rows,
      columns: columns?.call(PostReference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostReference]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PostReference> updateRow(
    _i1.DatabaseSession session,
    PostReference row, {
    _i1.ColumnSelections<PostReferenceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PostReference>(
      row,
      columns: columns?.call(PostReference.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PostReference] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PostReference?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PostReferenceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PostReference>(
      id,
      columnValues: columnValues(PostReference.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PostReference]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PostReference>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PostReferenceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PostReferenceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PostReferenceTable>? orderBy,
    _i1.OrderByListBuilder<PostReferenceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PostReference>(
      columnValues: columnValues(PostReference.t.updateTable),
      where: where(PostReference.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PostReference.t),
      orderByList: orderByList?.call(PostReference.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PostReference]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PostReference>> delete(
    _i1.DatabaseSession session,
    List<PostReference> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PostReference>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PostReference].
  Future<PostReference> deleteRow(
    _i1.DatabaseSession session,
    PostReference row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PostReference>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PostReference>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PostReferenceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PostReference>(
      where: where(PostReference.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PostReferenceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PostReference>(
      where: where?.call(PostReference.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PostReference] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PostReferenceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PostReference>(
      where: where(PostReference.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
