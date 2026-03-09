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

/// An indexed README cosignature — a polites has signed a polis README.
abstract class ReadmeSignatureRecord
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ReadmeSignatureRecordTable();

  static const db = ReadmeSignatureRecordRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
      '__className__': 'ReadmeSignatureRecord',
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReadmeSignatureRecord',
      if (id != null) 'id': id,
      'signerPubkey': signerPubkey,
      'polisRepoUrl': polisRepoUrl,
      'readmeCommit': readmeCommit,
      'readmeHash': readmeHash,
      'timestamp': timestamp.toJson(),
      'indexedAt': indexedAt.toJson(),
    };
  }

  static ReadmeSignatureRecordInclude include() {
    return ReadmeSignatureRecordInclude._();
  }

  static ReadmeSignatureRecordIncludeList includeList({
    _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadmeSignatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadmeSignatureRecordTable>? orderByList,
    ReadmeSignatureRecordInclude? include,
  }) {
    return ReadmeSignatureRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadmeSignatureRecord.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ReadmeSignatureRecord.t),
      include: include,
    );
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

class ReadmeSignatureRecordUpdateTable
    extends _i1.UpdateTable<ReadmeSignatureRecordTable> {
  ReadmeSignatureRecordUpdateTable(super.table);

  _i1.ColumnValue<String, String> signerPubkey(String value) => _i1.ColumnValue(
    table.signerPubkey,
    value,
  );

  _i1.ColumnValue<String, String> polisRepoUrl(String value) => _i1.ColumnValue(
    table.polisRepoUrl,
    value,
  );

  _i1.ColumnValue<String, String> readmeCommit(String value) => _i1.ColumnValue(
    table.readmeCommit,
    value,
  );

  _i1.ColumnValue<String, String> readmeHash(String value) => _i1.ColumnValue(
    table.readmeHash,
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

class ReadmeSignatureRecordTable extends _i1.Table<int?> {
  ReadmeSignatureRecordTable({super.tableRelation})
    : super(tableName: 'readme_signatures') {
    updateTable = ReadmeSignatureRecordUpdateTable(this);
    signerPubkey = _i1.ColumnString(
      'signerPubkey',
      this,
    );
    polisRepoUrl = _i1.ColumnString(
      'polisRepoUrl',
      this,
    );
    readmeCommit = _i1.ColumnString(
      'readmeCommit',
      this,
    );
    readmeHash = _i1.ColumnString(
      'readmeHash',
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

  late final ReadmeSignatureRecordUpdateTable updateTable;

  /// Public key of the signer.
  late final _i1.ColumnString signerPubkey;

  /// Repo URL of the polis whose README was signed.
  late final _i1.ColumnString polisRepoUrl;

  /// Commit hash of the README version that was signed.
  late final _i1.ColumnString readmeCommit;

  /// Content hash of the README.
  late final _i1.ColumnString readmeHash;

  /// When the signature was made.
  late final _i1.ColumnDateTime timestamp;

  /// When the aggregator indexed this signature.
  late final _i1.ColumnDateTime indexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    signerPubkey,
    polisRepoUrl,
    readmeCommit,
    readmeHash,
    timestamp,
    indexedAt,
  ];
}

class ReadmeSignatureRecordInclude extends _i1.IncludeObject {
  ReadmeSignatureRecordInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ReadmeSignatureRecord.t;
}

class ReadmeSignatureRecordIncludeList extends _i1.IncludeList {
  ReadmeSignatureRecordIncludeList._({
    _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReadmeSignatureRecord.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ReadmeSignatureRecord.t;
}

class ReadmeSignatureRecordRepository {
  const ReadmeSignatureRecordRepository._();

  /// Returns a list of [ReadmeSignatureRecord]s matching the given query parameters.
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
  Future<List<ReadmeSignatureRecord>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadmeSignatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadmeSignatureRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReadmeSignatureRecord>(
      where: where?.call(ReadmeSignatureRecord.t),
      orderBy: orderBy?.call(ReadmeSignatureRecord.t),
      orderByList: orderByList?.call(ReadmeSignatureRecord.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ReadmeSignatureRecord] matching the given query parameters.
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
  Future<ReadmeSignatureRecord?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReadmeSignatureRecordTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReadmeSignatureRecordTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReadmeSignatureRecord>(
      where: where?.call(ReadmeSignatureRecord.t),
      orderBy: orderBy?.call(ReadmeSignatureRecord.t),
      orderByList: orderByList?.call(ReadmeSignatureRecord.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReadmeSignatureRecord] by its [id] or null if no such row exists.
  Future<ReadmeSignatureRecord?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReadmeSignatureRecord>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReadmeSignatureRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [ReadmeSignatureRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ReadmeSignatureRecord>> insert(
    _i1.Session session,
    List<ReadmeSignatureRecord> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ReadmeSignatureRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ReadmeSignatureRecord] and returns the inserted row.
  ///
  /// The returned [ReadmeSignatureRecord] will have its `id` field set.
  Future<ReadmeSignatureRecord> insertRow(
    _i1.Session session,
    ReadmeSignatureRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReadmeSignatureRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ReadmeSignatureRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ReadmeSignatureRecord>> update(
    _i1.Session session,
    List<ReadmeSignatureRecord> rows, {
    _i1.ColumnSelections<ReadmeSignatureRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ReadmeSignatureRecord>(
      rows,
      columns: columns?.call(ReadmeSignatureRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadmeSignatureRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReadmeSignatureRecord> updateRow(
    _i1.Session session,
    ReadmeSignatureRecord row, {
    _i1.ColumnSelections<ReadmeSignatureRecordTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReadmeSignatureRecord>(
      row,
      columns: columns?.call(ReadmeSignatureRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReadmeSignatureRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReadmeSignatureRecord?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ReadmeSignatureRecordUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ReadmeSignatureRecord>(
      id,
      columnValues: columnValues(ReadmeSignatureRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReadmeSignatureRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ReadmeSignatureRecord>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ReadmeSignatureRecordUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReadmeSignatureRecordTable>? orderBy,
    _i1.OrderByListBuilder<ReadmeSignatureRecordTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ReadmeSignatureRecord>(
      columnValues: columnValues(ReadmeSignatureRecord.t.updateTable),
      where: where(ReadmeSignatureRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReadmeSignatureRecord.t),
      orderByList: orderByList?.call(ReadmeSignatureRecord.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ReadmeSignatureRecord]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ReadmeSignatureRecord>> delete(
    _i1.Session session,
    List<ReadmeSignatureRecord> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ReadmeSignatureRecord>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ReadmeSignatureRecord].
  Future<ReadmeSignatureRecord> deleteRow(
    _i1.Session session,
    ReadmeSignatureRecord row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReadmeSignatureRecord>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ReadmeSignatureRecord>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ReadmeSignatureRecord>(
      where: where(ReadmeSignatureRecord.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ReadmeSignatureRecord>(
      where: where?.call(ReadmeSignatureRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReadmeSignatureRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReadmeSignatureRecordTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReadmeSignatureRecord>(
      where: where(ReadmeSignatureRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
