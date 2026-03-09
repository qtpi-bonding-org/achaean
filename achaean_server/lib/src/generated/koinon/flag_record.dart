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

/// An indexed post flag — a moderation signal from a polis member.
abstract class FlagRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FlagRecord._({
    this.id,
    required this.flaggedByPubkey,
    required this.postAuthorPubkey,
    required this.postPath,
    required this.polisRepoUrl,
    required this.reason,
    required this.timestamp,
    required this.indexedAt,
  });

  factory FlagRecord({
    int? id,
    required String flaggedByPubkey,
    required String postAuthorPubkey,
    required String postPath,
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
      postPath: jsonSerialization['postPath'] as String,
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

  static final t = FlagRecordTable();

  static const db = FlagRecordRepository._();

  @override
  int? id;

  /// Public key of the flagger.
  String flaggedByPubkey;

  /// Public key of the post author.
  String postAuthorPubkey;

  /// Path to the flagged post file.
  String postPath;

  /// Polis repo URL where this flag applies.
  String polisRepoUrl;

  /// Free-form reason for flagging.
  String reason;

  /// When the flag was made.
  DateTime timestamp;

  /// When the aggregator indexed this flag.
  DateTime indexedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FlagRecord]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FlagRecord copyWith({
    int? id,
    String? flaggedByPubkey,
    String? postAuthorPubkey,
    String? postPath,
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
      'postPath': postPath,
      'polisRepoUrl': polisRepoUrl,
      'reason': reason,
      'timestamp': timestamp.toJson(),
      'indexedAt': indexedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlagRecord',
      if (id != null) 'id': id,
      'flaggedByPubkey': flaggedByPubkey,
      'postAuthorPubkey': postAuthorPubkey,
      'postPath': postPath,
      'polisRepoUrl': polisRepoUrl,
      'reason': reason,
      'timestamp': timestamp.toJson(),
      'indexedAt': indexedAt.toJson(),
    };
  }

  static FlagRecordInclude include() {
    return FlagRecordInclude._();
  }

  static FlagRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<FlagRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlagRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlagRecordTable>? orderByList,
    FlagRecordInclude? include,
  }) {
    return FlagRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlagRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FlagRecord.t),
      include: include,
    );
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
    required String postPath,
    required String polisRepoUrl,
    required String reason,
    required DateTime timestamp,
    required DateTime indexedAt,
  }) : super._(
         id: id,
         flaggedByPubkey: flaggedByPubkey,
         postAuthorPubkey: postAuthorPubkey,
         postPath: postPath,
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
    String? postPath,
    String? polisRepoUrl,
    String? reason,
    DateTime? timestamp,
    DateTime? indexedAt,
  }) {
    return FlagRecord(
      id: id is int? ? id : this.id,
      flaggedByPubkey: flaggedByPubkey ?? this.flaggedByPubkey,
      postAuthorPubkey: postAuthorPubkey ?? this.postAuthorPubkey,
      postPath: postPath ?? this.postPath,
      polisRepoUrl: polisRepoUrl ?? this.polisRepoUrl,
      reason: reason ?? this.reason,
      timestamp: timestamp ?? this.timestamp,
      indexedAt: indexedAt ?? this.indexedAt,
    );
  }
}

class FlagRecordUpdateTable extends _i1.UpdateTable<FlagRecordTable> {
  FlagRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> flaggedByPubkey(String value) =>
      _i1.ColumnValue(
        table.flaggedByPubkey,
        value,
      );

  _i1.ColumnValue<String, String> postAuthorPubkey(String value) =>
      _i1.ColumnValue(
        table.postAuthorPubkey,
        value,
      );

  _i1.ColumnValue<String, String> postPath(String value) => _i1.ColumnValue(
    table.postPath,
    value,
  );

  _i1.ColumnValue<String, String> polisRepoUrl(String value) => _i1.ColumnValue(
    table.polisRepoUrl,
    value,
  );

  _i1.ColumnValue<String, String> reason(String value) => _i1.ColumnValue(
    table.reason,
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
}

class FlagRecordTable extends _i1.Table<int?> {
  FlagRecordTable({super.tableRelation}) : super(tableName: 'flag_records') {
    updateTable = FlagRecordUpdateTable(this);
    flaggedByPubkey = _i1.ColumnString(
      'flaggedByPubkey',
      this,
    );
    postAuthorPubkey = _i1.ColumnString(
      'postAuthorPubkey',
      this,
    );
    postPath = _i1.ColumnString(
      'postPath',
      this,
    );
    polisRepoUrl = _i1.ColumnString(
      'polisRepoUrl',
      this,
    );
    reason = _i1.ColumnString(
      'reason',
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
  }

  late final FlagRecordUpdateTable updateTable;

  /// Public key of the flagger.
  late final _i1.ColumnString flaggedByPubkey;

  /// Public key of the post author.
  late final _i1.ColumnString postAuthorPubkey;

  /// Path to the flagged post file.
  late final _i1.ColumnString postPath;

  /// Polis repo URL where this flag applies.
  late final _i1.ColumnString polisRepoUrl;

  /// Free-form reason for flagging.
  late final _i1.ColumnString reason;

  /// When the flag was made.
  late final _i1.ColumnDateTime timestamp;

  /// When the aggregator indexed this flag.
  late final _i1.ColumnDateTime indexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    flaggedByPubkey,
    postAuthorPubkey,
    postPath,
    polisRepoUrl,
    reason,
    timestamp,
    indexedAt,
  ];
}

class FlagRecordInclude extends _i1.IncludeObject {
  FlagRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FlagRecord.t;
}

class FlagRecordIncludeList extends _i1.IncludeList {
  FlagRecordIncludeList._({
    _i1.WhereExpressionBuilder<FlagRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FlagRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FlagRecord.t;
}

class FlagRecordRepository {
  const FlagRecordRepository._();

  /// Returns a list of [FlagRecord]s matching the given query parameters.
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
  Future<List<FlagRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlagRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlagRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlagRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FlagRecord>(
      where: where?.call(FlagRecord.t),
      orderBy: orderBy?.call(FlagRecord.t),
      orderByList: orderByList?.call(FlagRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FlagRecord] matching the given query parameters.
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
  Future<FlagRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlagRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<FlagRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FlagRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FlagRecord>(
      where: where?.call(FlagRecord.t),
      orderBy: orderBy?.call(FlagRecord.t),
      orderByList: orderByList?.call(FlagRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FlagRecord] by its [id] or null if no such row exists.
  Future<FlagRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FlagRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FlagRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [FlagRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<FlagRecord>> insert(
    _i1.Session session,
    List<FlagRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<FlagRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [FlagRecord] and returns the inserted row.
  ///
  /// The returned [FlagRecord] will have its `id` field set.
  Future<FlagRecord> insertRow(
    _i1.Session session,
    FlagRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FlagRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FlagRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FlagRecord>> update(
    _i1.Session session,
    List<FlagRecord> rows, {
    _i1.ColumnSelections<FlagRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FlagRecord>(
      rows,
      columns: columns?.call(FlagRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlagRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FlagRecord> updateRow(
    _i1.Session session,
    FlagRecord row, {
    _i1.ColumnSelections<FlagRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FlagRecord>(
      row,
      columns: columns?.call(FlagRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FlagRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FlagRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<FlagRecordUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<FlagRecord>(
      id,
      columnValues: columnValues(FlagRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FlagRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<FlagRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<FlagRecordUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<FlagRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FlagRecordTable>? orderBy,
    _i1.OrderByListBuilder<FlagRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<FlagRecord>(
      columnValues: columnValues(FlagRecord.t.updateTable),
      where: where(FlagRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FlagRecord.t),
      orderByList: orderByList?.call(FlagRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [FlagRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FlagRecord>> delete(
    _i1.Session session,
    List<FlagRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FlagRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FlagRecord].
  Future<FlagRecord> deleteRow(
    _i1.Session session,
    FlagRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FlagRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FlagRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FlagRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FlagRecord>(
      where: where(FlagRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FlagRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FlagRecord>(
      where: where?.call(FlagRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FlagRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FlagRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FlagRecord>(
      where: where(FlagRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
