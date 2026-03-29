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

/// An indexed observe declaration — non-structural, personal feed only.
abstract class ObserveDeclarationRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ObserveDeclarationRecordTable();

  static const db = ObserveDeclarationRecordRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ObserveDeclarationRecordInclude include() {
    return ObserveDeclarationRecordInclude._();
  }

  static ObserveDeclarationRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObserveDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObserveDeclarationRecordTable>? orderByList,
    ObserveDeclarationRecordInclude? include,
  }) {
    return ObserveDeclarationRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ObserveDeclarationRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ObserveDeclarationRecord.t),
      include: include,
    );
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

class ObserveDeclarationRecordUpdateTable
    extends _i1.UpdateTable<ObserveDeclarationRecordTable> {
  ObserveDeclarationRecordUpdateTable(super.table);

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

class ObserveDeclarationRecordTable extends _i1.Table<int?> {
  ObserveDeclarationRecordTable({super.tableRelation})
    : super(tableName: 'koinon_observe_declarations') {
    updateTable = ObserveDeclarationRecordUpdateTable(this);
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
    timestamp = _i1.ColumnDateTime(
      'timestamp',
      this,
    );
    indexedAt = _i1.ColumnDateTime(
      'indexedAt',
      this,
    );
  }

  late final ObserveDeclarationRecordUpdateTable updateTable;

  /// Public key of the observer (author).
  late final _i1.ColumnString fromPubkey;

  /// Public key of the observed subject.
  late final _i1.ColumnString toPubkey;

  /// Repo URL of the subject (for discovery).
  late final _i1.ColumnString subjectRepoUrl;

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
    timestamp,
    indexedAt,
  ];
}

class ObserveDeclarationRecordInclude extends _i1.IncludeObject {
  ObserveDeclarationRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ObserveDeclarationRecord.t;
}

class ObserveDeclarationRecordIncludeList extends _i1.IncludeList {
  ObserveDeclarationRecordIncludeList._({
    _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ObserveDeclarationRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ObserveDeclarationRecord.t;
}

class ObserveDeclarationRecordRepository {
  const ObserveDeclarationRecordRepository._();

  /// Returns a list of [ObserveDeclarationRecord]s matching the given query parameters.
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
  Future<List<ObserveDeclarationRecord>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObserveDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObserveDeclarationRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ObserveDeclarationRecord>(
      where: where?.call(ObserveDeclarationRecord.t),
      orderBy: orderBy?.call(ObserveDeclarationRecord.t),
      orderByList: orderByList?.call(ObserveDeclarationRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ObserveDeclarationRecord] matching the given query parameters.
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
  Future<ObserveDeclarationRecord?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<ObserveDeclarationRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ObserveDeclarationRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ObserveDeclarationRecord>(
      where: where?.call(ObserveDeclarationRecord.t),
      orderBy: orderBy?.call(ObserveDeclarationRecord.t),
      orderByList: orderByList?.call(ObserveDeclarationRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ObserveDeclarationRecord] by its [id] or null if no such row exists.
  Future<ObserveDeclarationRecord?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ObserveDeclarationRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ObserveDeclarationRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ObserveDeclarationRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ObserveDeclarationRecord>> insert(
    _i1.DatabaseSession session,
    List<ObserveDeclarationRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ObserveDeclarationRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ObserveDeclarationRecord] and returns the inserted row.
  ///
  /// The returned [ObserveDeclarationRecord] will have its `id` field set.
  Future<ObserveDeclarationRecord> insertRow(
    _i1.DatabaseSession session,
    ObserveDeclarationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ObserveDeclarationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ObserveDeclarationRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ObserveDeclarationRecord>> update(
    _i1.DatabaseSession session,
    List<ObserveDeclarationRecord> rows, {
    _i1.ColumnSelections<ObserveDeclarationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ObserveDeclarationRecord>(
      rows,
      columns: columns?.call(ObserveDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ObserveDeclarationRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ObserveDeclarationRecord> updateRow(
    _i1.DatabaseSession session,
    ObserveDeclarationRecord row, {
    _i1.ColumnSelections<ObserveDeclarationRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ObserveDeclarationRecord>(
      row,
      columns: columns?.call(ObserveDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ObserveDeclarationRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ObserveDeclarationRecord?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ObserveDeclarationRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ObserveDeclarationRecord>(
      id,
      columnValues: columnValues(ObserveDeclarationRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ObserveDeclarationRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ObserveDeclarationRecord>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ObserveDeclarationRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ObserveDeclarationRecordTable>? orderBy,
    _i1.OrderByListBuilder<ObserveDeclarationRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ObserveDeclarationRecord>(
      columnValues: columnValues(ObserveDeclarationRecord.t.updateTable),
      where: where(ObserveDeclarationRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ObserveDeclarationRecord.t),
      orderByList: orderByList?.call(ObserveDeclarationRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ObserveDeclarationRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ObserveDeclarationRecord>> delete(
    _i1.DatabaseSession session,
    List<ObserveDeclarationRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ObserveDeclarationRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ObserveDeclarationRecord].
  Future<ObserveDeclarationRecord> deleteRow(
    _i1.DatabaseSession session,
    ObserveDeclarationRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ObserveDeclarationRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ObserveDeclarationRecord>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ObserveDeclarationRecord>(
      where: where(ObserveDeclarationRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ObserveDeclarationRecord>(
      where: where?.call(ObserveDeclarationRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ObserveDeclarationRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ObserveDeclarationRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ObserveDeclarationRecord>(
      where: where(ObserveDeclarationRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
