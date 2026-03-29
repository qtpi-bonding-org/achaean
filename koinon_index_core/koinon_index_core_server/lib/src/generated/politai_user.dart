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

/// An indexed polites (user) discovered by the aggregator.
abstract class PolitaiUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PolitaiUser._({
    this.id,
    required this.pubkey,
    required this.repoUrl,
    required this.discoveredAt,
    this.lastIndexedAt,
  });

  factory PolitaiUser({
    int? id,
    required String pubkey,
    required String repoUrl,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) = _PolitaiUserImpl;

  factory PolitaiUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return PolitaiUser(
      id: jsonSerialization['id'] as int?,
      pubkey: jsonSerialization['pubkey'] as String,
      repoUrl: jsonSerialization['repoUrl'] as String,
      discoveredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['discoveredAt'],
      ),
      lastIndexedAt: jsonSerialization['lastIndexedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastIndexedAt'],
            ),
    );
  }

  static final t = PolitaiUserTable();

  static const db = PolitaiUserRepository._();

  @override
  int? id;

  /// The polites's public key (unique identity).
  String pubkey;

  /// HTTPS URL of the polites's git repo.
  String repoUrl;

  /// When the aggregator first discovered this user.
  DateTime discoveredAt;

  /// When the aggregator last indexed this user's repo.
  DateTime? lastIndexedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PolitaiUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PolitaiUser copyWith({
    int? id,
    String? pubkey,
    String? repoUrl,
    DateTime? discoveredAt,
    DateTime? lastIndexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'koinon_index_core.PolitaiUser',
      if (id != null) 'id': id,
      'pubkey': pubkey,
      'repoUrl': repoUrl,
      'discoveredAt': discoveredAt.toJson(),
      if (lastIndexedAt != null) 'lastIndexedAt': lastIndexedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'koinon_index_core.PolitaiUser',
      if (id != null) 'id': id,
      'pubkey': pubkey,
      'repoUrl': repoUrl,
      'discoveredAt': discoveredAt.toJson(),
      if (lastIndexedAt != null) 'lastIndexedAt': lastIndexedAt?.toJson(),
    };
  }

  static PolitaiUserInclude include() {
    return PolitaiUserInclude._();
  }

  static PolitaiUserIncludeList includeList({
    _i1.WhereExpressionBuilder<PolitaiUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolitaiUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolitaiUserTable>? orderByList,
    PolitaiUserInclude? include,
  }) {
    return PolitaiUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PolitaiUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PolitaiUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PolitaiUserImpl extends PolitaiUser {
  _PolitaiUserImpl({
    int? id,
    required String pubkey,
    required String repoUrl,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) : super._(
         id: id,
         pubkey: pubkey,
         repoUrl: repoUrl,
         discoveredAt: discoveredAt,
         lastIndexedAt: lastIndexedAt,
       );

  /// Returns a shallow copy of this [PolitaiUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PolitaiUser copyWith({
    Object? id = _Undefined,
    String? pubkey,
    String? repoUrl,
    DateTime? discoveredAt,
    Object? lastIndexedAt = _Undefined,
  }) {
    return PolitaiUser(
      id: id is int? ? id : this.id,
      pubkey: pubkey ?? this.pubkey,
      repoUrl: repoUrl ?? this.repoUrl,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      lastIndexedAt: lastIndexedAt is DateTime?
          ? lastIndexedAt
          : this.lastIndexedAt,
    );
  }
}

class PolitaiUserUpdateTable extends _i1.UpdateTable<PolitaiUserTable> {
  PolitaiUserUpdateTable(super.table);

  _i1.ColumnValue<String, String> pubkey(String value) => _i1.ColumnValue(
    table.pubkey,
    value,
  );

  _i1.ColumnValue<String, String> repoUrl(String value) => _i1.ColumnValue(
    table.repoUrl,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> discoveredAt(DateTime value) =>
      _i1.ColumnValue(
        table.discoveredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastIndexedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastIndexedAt,
        value,
      );
}

class PolitaiUserTable extends _i1.Table<int?> {
  PolitaiUserTable({super.tableRelation})
    : super(tableName: 'koinon_politai_users') {
    updateTable = PolitaiUserUpdateTable(this);
    pubkey = _i1.ColumnString(
      'pubkey',
      this,
    );
    repoUrl = _i1.ColumnString(
      'repoUrl',
      this,
    );
    discoveredAt = _i1.ColumnDateTime(
      'discoveredAt',
      this,
    );
    lastIndexedAt = _i1.ColumnDateTime(
      'lastIndexedAt',
      this,
    );
  }

  late final PolitaiUserUpdateTable updateTable;

  /// The polites's public key (unique identity).
  late final _i1.ColumnString pubkey;

  /// HTTPS URL of the polites's git repo.
  late final _i1.ColumnString repoUrl;

  /// When the aggregator first discovered this user.
  late final _i1.ColumnDateTime discoveredAt;

  /// When the aggregator last indexed this user's repo.
  late final _i1.ColumnDateTime lastIndexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    pubkey,
    repoUrl,
    discoveredAt,
    lastIndexedAt,
  ];
}

class PolitaiUserInclude extends _i1.IncludeObject {
  PolitaiUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PolitaiUser.t;
}

class PolitaiUserIncludeList extends _i1.IncludeList {
  PolitaiUserIncludeList._({
    _i1.WhereExpressionBuilder<PolitaiUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PolitaiUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PolitaiUser.t;
}

class PolitaiUserRepository {
  const PolitaiUserRepository._();

  /// Returns a list of [PolitaiUser]s matching the given query parameters.
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
  Future<List<PolitaiUser>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PolitaiUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolitaiUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolitaiUserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PolitaiUser>(
      where: where?.call(PolitaiUser.t),
      orderBy: orderBy?.call(PolitaiUser.t),
      orderByList: orderByList?.call(PolitaiUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PolitaiUser] matching the given query parameters.
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
  Future<PolitaiUser?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PolitaiUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<PolitaiUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolitaiUserTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PolitaiUser>(
      where: where?.call(PolitaiUser.t),
      orderBy: orderBy?.call(PolitaiUser.t),
      orderByList: orderByList?.call(PolitaiUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PolitaiUser] by its [id] or null if no such row exists.
  Future<PolitaiUser?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PolitaiUser>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PolitaiUser]s in the list and returns the inserted rows.
  ///
  /// The returned [PolitaiUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PolitaiUser>> insert(
    _i1.DatabaseSession session,
    List<PolitaiUser> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PolitaiUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PolitaiUser] and returns the inserted row.
  ///
  /// The returned [PolitaiUser] will have its `id` field set.
  Future<PolitaiUser> insertRow(
    _i1.DatabaseSession session,
    PolitaiUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PolitaiUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PolitaiUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PolitaiUser>> update(
    _i1.DatabaseSession session,
    List<PolitaiUser> rows, {
    _i1.ColumnSelections<PolitaiUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PolitaiUser>(
      rows,
      columns: columns?.call(PolitaiUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PolitaiUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PolitaiUser> updateRow(
    _i1.DatabaseSession session,
    PolitaiUser row, {
    _i1.ColumnSelections<PolitaiUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PolitaiUser>(
      row,
      columns: columns?.call(PolitaiUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PolitaiUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PolitaiUser?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<PolitaiUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PolitaiUser>(
      id,
      columnValues: columnValues(PolitaiUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PolitaiUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PolitaiUser>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PolitaiUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PolitaiUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolitaiUserTable>? orderBy,
    _i1.OrderByListBuilder<PolitaiUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PolitaiUser>(
      columnValues: columnValues(PolitaiUser.t.updateTable),
      where: where(PolitaiUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PolitaiUser.t),
      orderByList: orderByList?.call(PolitaiUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PolitaiUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PolitaiUser>> delete(
    _i1.DatabaseSession session,
    List<PolitaiUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PolitaiUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PolitaiUser].
  Future<PolitaiUser> deleteRow(
    _i1.DatabaseSession session,
    PolitaiUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PolitaiUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PolitaiUser>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PolitaiUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PolitaiUser>(
      where: where(PolitaiUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PolitaiUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PolitaiUser>(
      where: where?.call(PolitaiUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PolitaiUser] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PolitaiUserTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PolitaiUser>(
      where: where(PolitaiUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
