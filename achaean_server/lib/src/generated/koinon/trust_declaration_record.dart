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

/// An indexed trust declaration — an edge in the trust graph.
abstract class TrustDeclarationRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = TrustDeclarationRecordTable();

  static const db = TrustDeclarationRecordRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static TrustDeclarationRecordInclude include() {
    return TrustDeclarationRecordInclude._();
  }

  static TrustDeclarationRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<TrustDeclarationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrustDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrustDeclarationRecordTable>? orderByList,
    TrustDeclarationRecordInclude? include,
  }) {
    return TrustDeclarationRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrustDeclarationRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TrustDeclarationRecord.t),
      include: include,
    );
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

class TrustDeclarationRecordUpdateTable
    extends _i1.UpdateTable<TrustDeclarationRecordTable> {
  TrustDeclarationRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> fromPubkey(String value) => _i1.ColumnValue(
    table.fromPubkey,
    value,
  );

  _i1.ColumnValue<String, String> toPubkey(String value) => _i1.ColumnValue(
    table.toPubkey,
    value,
  );

  _i1.ColumnValue<String, String> subjectRepoUrl(String value) =>
      _i1.ColumnValue(
        table.subjectRepoUrl,
        value,
      );

  _i1.ColumnValue<String, String> level(String value) => _i1.ColumnValue(
    table.level,
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

class TrustDeclarationRecordTable extends _i1.Table<int?> {
  TrustDeclarationRecordTable({super.tableRelation})
    : super(tableName: 'trust_declarations') {
    updateTable = TrustDeclarationRecordUpdateTable(this);
    fromPubkey = _i1.ColumnString(
      'fromPubkey',
      this,
    );
    toPubkey = _i1.ColumnString(
      'toPubkey',
      this,
    );
    subjectRepoUrl = _i1.ColumnString(
      'subjectRepoUrl',
      this,
    );
    level = _i1.ColumnString(
      'level',
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

  late final TrustDeclarationRecordUpdateTable updateTable;

  /// Public key of the truster (author).
  late final _i1.ColumnString fromPubkey;

  /// Public key of the trusted subject.
  late final _i1.ColumnString toPubkey;

  /// Repo URL of the subject (for graph traversal).
  late final _i1.ColumnString subjectRepoUrl;

  /// Trust level: "trust" or "provisional".
  late final _i1.ColumnString level;

  /// When the declaration was made.
  late final _i1.ColumnDateTime timestamp;

  /// When the aggregator indexed this declaration.
  late final _i1.ColumnDateTime indexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    fromPubkey,
    toPubkey,
    subjectRepoUrl,
    level,
    timestamp,
    indexedAt,
  ];
}

class TrustDeclarationRecordInclude extends _i1.IncludeObject {
  TrustDeclarationRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TrustDeclarationRecord.t;
}

class TrustDeclarationRecordIncludeList extends _i1.IncludeList {
  TrustDeclarationRecordIncludeList._({
    _i1.WhereExpressionBuilder<TrustDeclarationRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TrustDeclarationRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TrustDeclarationRecord.t;
}

class TrustDeclarationRecordRepository {
  const TrustDeclarationRecordRepository._();

  /// Returns a list of [TrustDeclarationRecord]s matching the given query parameters.
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
  Future<List<TrustDeclarationRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrustDeclarationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrustDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrustDeclarationRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TrustDeclarationRecord>(
      where: where?.call(TrustDeclarationRecord.t),
      orderBy: orderBy?.call(TrustDeclarationRecord.t),
      orderByList: orderByList?.call(TrustDeclarationRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TrustDeclarationRecord] matching the given query parameters.
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
  Future<TrustDeclarationRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrustDeclarationRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<TrustDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TrustDeclarationRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TrustDeclarationRecord>(
      where: where?.call(TrustDeclarationRecord.t),
      orderBy: orderBy?.call(TrustDeclarationRecord.t),
      orderByList: orderByList?.call(TrustDeclarationRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TrustDeclarationRecord] by its [id] or null if no such row exists.
  Future<TrustDeclarationRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TrustDeclarationRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TrustDeclarationRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [TrustDeclarationRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TrustDeclarationRecord>> insert(
    _i1.DatabaseSession session,
    List<TrustDeclarationRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TrustDeclarationRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TrustDeclarationRecord] and returns the inserted row.
  ///
  /// The returned [TrustDeclarationRecord] will have its `id` field set.
  Future<TrustDeclarationRecord> insertRow(
    _i1.DatabaseSession session,
    TrustDeclarationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TrustDeclarationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TrustDeclarationRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TrustDeclarationRecord>> update(
    _i1.DatabaseSession session,
    List<TrustDeclarationRecord> rows, {
    _i1.ColumnSelections<TrustDeclarationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TrustDeclarationRecord>(
      rows,
      columns: columns?.call(TrustDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrustDeclarationRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TrustDeclarationRecord> updateRow(
    _i1.DatabaseSession session,
    TrustDeclarationRecord row, {
    _i1.ColumnSelections<TrustDeclarationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TrustDeclarationRecord>(
      row,
      columns: columns?.call(TrustDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TrustDeclarationRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TrustDeclarationRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TrustDeclarationRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TrustDeclarationRecord>(
      id,
      columnValues: columnValues(TrustDeclarationRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TrustDeclarationRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TrustDeclarationRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TrustDeclarationRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<TrustDeclarationRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TrustDeclarationRecordTable>? orderBy,
    _i1.OrderByListBuilder<TrustDeclarationRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TrustDeclarationRecord>(
      columnValues: columnValues(TrustDeclarationRecord.t.updateTable),
      where: where(TrustDeclarationRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TrustDeclarationRecord.t),
      orderByList: orderByList?.call(TrustDeclarationRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TrustDeclarationRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TrustDeclarationRecord>> delete(
    _i1.DatabaseSession session,
    List<TrustDeclarationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TrustDeclarationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TrustDeclarationRecord].
  Future<TrustDeclarationRecord> deleteRow(
    _i1.DatabaseSession session,
    TrustDeclarationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TrustDeclarationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TrustDeclarationRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrustDeclarationRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TrustDeclarationRecord>(
      where: where(TrustDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TrustDeclarationRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TrustDeclarationRecord>(
      where: where?.call(TrustDeclarationRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TrustDeclarationRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TrustDeclarationRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TrustDeclarationRecord>(
      where: where(TrustDeclarationRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
