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

/// An indexed polis — a community repo known to the aggregator.
abstract class PolisDefinition
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  PolisDefinition._({
    this.id,
    required this.repoUrl,
    required this.name,
    this.description,
    required this.membershipThreshold,
    required this.flagThreshold,
    this.parentRepoUrl,
    required this.ownerPubkey,
    this.readmeCommit,
    required this.discoveredAt,
    this.lastIndexedAt,
  });

  factory PolisDefinition({
    int? id,
    required String repoUrl,
    required String name,
    String? description,
    required int membershipThreshold,
    required int flagThreshold,
    String? parentRepoUrl,
    required String ownerPubkey,
    String? readmeCommit,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) = _PolisDefinitionImpl;

  factory PolisDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return PolisDefinition(
      id: jsonSerialization['id'] as int?,
      repoUrl: jsonSerialization['repoUrl'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      membershipThreshold: jsonSerialization['membershipThreshold'] as int,
      flagThreshold: jsonSerialization['flagThreshold'] as int,
      parentRepoUrl: jsonSerialization['parentRepoUrl'] as String?,
      ownerPubkey: jsonSerialization['ownerPubkey'] as String,
      readmeCommit: jsonSerialization['readmeCommit'] as String?,
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

  static final t = PolisDefinitionTable();

  static const db = PolisDefinitionRepository._();

  @override
  int? id;

  /// HTTPS URL of the polis git repo (stable identity).
  String repoUrl;

  /// Display name of the polis.
  String name;

  /// Description / about text.
  String? description;

  /// Membership threshold — mutual trust links required.
  int membershipThreshold;

  /// Flag threshold — number of flags before NSFW blur.
  int flagThreshold;

  /// Parent polis repo URL (null for genesis poleis).
  String? parentRepoUrl;

  /// Public key of the repo owner.
  String ownerPubkey;

  /// Current README commit hash.
  String? readmeCommit;

  /// When the aggregator first discovered this polis.
  DateTime discoveredAt;

  /// When the aggregator last indexed this polis.
  DateTime? lastIndexedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [PolisDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PolisDefinition copyWith({
    int? id,
    String? repoUrl,
    String? name,
    String? description,
    int? membershipThreshold,
    int? flagThreshold,
    String? parentRepoUrl,
    String? ownerPubkey,
    String? readmeCommit,
    DateTime? discoveredAt,
    DateTime? lastIndexedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PolisDefinition',
      if (id != null) 'id': id,
      'repoUrl': repoUrl,
      'name': name,
      if (description != null) 'description': description,
      'membershipThreshold': membershipThreshold,
      'flagThreshold': flagThreshold,
      if (parentRepoUrl != null) 'parentRepoUrl': parentRepoUrl,
      'ownerPubkey': ownerPubkey,
      if (readmeCommit != null) 'readmeCommit': readmeCommit,
      'discoveredAt': discoveredAt.toJson(),
      if (lastIndexedAt != null) 'lastIndexedAt': lastIndexedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PolisDefinition',
      if (id != null) 'id': id,
      'repoUrl': repoUrl,
      'name': name,
      if (description != null) 'description': description,
      'membershipThreshold': membershipThreshold,
      'flagThreshold': flagThreshold,
      if (parentRepoUrl != null) 'parentRepoUrl': parentRepoUrl,
      'ownerPubkey': ownerPubkey,
      if (readmeCommit != null) 'readmeCommit': readmeCommit,
      'discoveredAt': discoveredAt.toJson(),
      if (lastIndexedAt != null) 'lastIndexedAt': lastIndexedAt?.toJson(),
    };
  }

  static PolisDefinitionInclude include() {
    return PolisDefinitionInclude._();
  }

  static PolisDefinitionIncludeList includeList({
    _i1.WhereExpressionBuilder<PolisDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolisDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolisDefinitionTable>? orderByList,
    PolisDefinitionInclude? include,
  }) {
    return PolisDefinitionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PolisDefinition.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PolisDefinition.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PolisDefinitionImpl extends PolisDefinition {
  _PolisDefinitionImpl({
    int? id,
    required String repoUrl,
    required String name,
    String? description,
    required int membershipThreshold,
    required int flagThreshold,
    String? parentRepoUrl,
    required String ownerPubkey,
    String? readmeCommit,
    required DateTime discoveredAt,
    DateTime? lastIndexedAt,
  }) : super._(
         id: id,
         repoUrl: repoUrl,
         name: name,
         description: description,
         membershipThreshold: membershipThreshold,
         flagThreshold: flagThreshold,
         parentRepoUrl: parentRepoUrl,
         ownerPubkey: ownerPubkey,
         readmeCommit: readmeCommit,
         discoveredAt: discoveredAt,
         lastIndexedAt: lastIndexedAt,
       );

  /// Returns a shallow copy of this [PolisDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PolisDefinition copyWith({
    Object? id = _Undefined,
    String? repoUrl,
    String? name,
    Object? description = _Undefined,
    int? membershipThreshold,
    int? flagThreshold,
    Object? parentRepoUrl = _Undefined,
    String? ownerPubkey,
    Object? readmeCommit = _Undefined,
    DateTime? discoveredAt,
    Object? lastIndexedAt = _Undefined,
  }) {
    return PolisDefinition(
      id: id is int? ? id : this.id,
      repoUrl: repoUrl ?? this.repoUrl,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      membershipThreshold: membershipThreshold ?? this.membershipThreshold,
      flagThreshold: flagThreshold ?? this.flagThreshold,
      parentRepoUrl: parentRepoUrl is String?
          ? parentRepoUrl
          : this.parentRepoUrl,
      ownerPubkey: ownerPubkey ?? this.ownerPubkey,
      readmeCommit: readmeCommit is String? ? readmeCommit : this.readmeCommit,
      discoveredAt: discoveredAt ?? this.discoveredAt,
      lastIndexedAt: lastIndexedAt is DateTime?
          ? lastIndexedAt
          : this.lastIndexedAt,
    );
  }
}

class PolisDefinitionUpdateTable extends _i1.UpdateTable<PolisDefinitionTable> {
  PolisDefinitionUpdateTable(super.table);

  _i1.ColumnValue<String, String> repoUrl(String value) => _i1.ColumnValue(
    table.repoUrl,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> membershipThreshold(int value) => _i1.ColumnValue(
    table.membershipThreshold,
    value,
  );

  _i1.ColumnValue<int, int> flagThreshold(int value) => _i1.ColumnValue(
    table.flagThreshold,
    value,
  );

  _i1.ColumnValue<String, String> parentRepoUrl(String? value) =>
      _i1.ColumnValue(
        table.parentRepoUrl,
        value,
      );

  _i1.ColumnValue<String, String> ownerPubkey(String value) => _i1.ColumnValue(
    table.ownerPubkey,
    value,
  );

  _i1.ColumnValue<String, String> readmeCommit(String? value) =>
      _i1.ColumnValue(
        table.readmeCommit,
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

class PolisDefinitionTable extends _i1.Table<int?> {
  PolisDefinitionTable({super.tableRelation})
    : super(tableName: 'polis_definitions') {
    updateTable = PolisDefinitionUpdateTable(this);
    repoUrl = _i1.ColumnString(
      'repoUrl',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    membershipThreshold = _i1.ColumnInt(
      'membershipThreshold',
      this,
    );
    flagThreshold = _i1.ColumnInt(
      'flagThreshold',
      this,
    );
    parentRepoUrl = _i1.ColumnString(
      'parentRepoUrl',
      this,
    );
    ownerPubkey = _i1.ColumnString(
      'ownerPubkey',
      this,
    );
    readmeCommit = _i1.ColumnString(
      'readmeCommit',
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

  late final PolisDefinitionUpdateTable updateTable;

  /// HTTPS URL of the polis git repo (stable identity).
  late final _i1.ColumnString repoUrl;

  /// Display name of the polis.
  late final _i1.ColumnString name;

  /// Description / about text.
  late final _i1.ColumnString description;

  /// Membership threshold — mutual trust links required.
  late final _i1.ColumnInt membershipThreshold;

  /// Flag threshold — number of flags before NSFW blur.
  late final _i1.ColumnInt flagThreshold;

  /// Parent polis repo URL (null for genesis poleis).
  late final _i1.ColumnString parentRepoUrl;

  /// Public key of the repo owner.
  late final _i1.ColumnString ownerPubkey;

  /// Current README commit hash.
  late final _i1.ColumnString readmeCommit;

  /// When the aggregator first discovered this polis.
  late final _i1.ColumnDateTime discoveredAt;

  /// When the aggregator last indexed this polis.
  late final _i1.ColumnDateTime lastIndexedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    repoUrl,
    name,
    description,
    membershipThreshold,
    flagThreshold,
    parentRepoUrl,
    ownerPubkey,
    readmeCommit,
    discoveredAt,
    lastIndexedAt,
  ];
}

class PolisDefinitionInclude extends _i1.IncludeObject {
  PolisDefinitionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => PolisDefinition.t;
}

class PolisDefinitionIncludeList extends _i1.IncludeList {
  PolisDefinitionIncludeList._({
    _i1.WhereExpressionBuilder<PolisDefinitionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PolisDefinition.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => PolisDefinition.t;
}

class PolisDefinitionRepository {
  const PolisDefinitionRepository._();

  /// Returns a list of [PolisDefinition]s matching the given query parameters.
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
  Future<List<PolisDefinition>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PolisDefinitionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolisDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolisDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PolisDefinition>(
      where: where?.call(PolisDefinition.t),
      orderBy: orderBy?.call(PolisDefinition.t),
      orderByList: orderByList?.call(PolisDefinition.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PolisDefinition] matching the given query parameters.
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
  Future<PolisDefinition?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PolisDefinitionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PolisDefinitionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PolisDefinitionTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PolisDefinition>(
      where: where?.call(PolisDefinition.t),
      orderBy: orderBy?.call(PolisDefinition.t),
      orderByList: orderByList?.call(PolisDefinition.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PolisDefinition] by its [id] or null if no such row exists.
  Future<PolisDefinition?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PolisDefinition>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PolisDefinition]s in the list and returns the inserted rows.
  ///
  /// The returned [PolisDefinition]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PolisDefinition>> insert(
    _i1.Session session,
    List<PolisDefinition> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PolisDefinition>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PolisDefinition] and returns the inserted row.
  ///
  /// The returned [PolisDefinition] will have its `id` field set.
  Future<PolisDefinition> insertRow(
    _i1.Session session,
    PolisDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PolisDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PolisDefinition]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PolisDefinition>> update(
    _i1.Session session,
    List<PolisDefinition> rows, {
    _i1.ColumnSelections<PolisDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PolisDefinition>(
      rows,
      columns: columns?.call(PolisDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PolisDefinition]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PolisDefinition> updateRow(
    _i1.Session session,
    PolisDefinition row, {
    _i1.ColumnSelections<PolisDefinitionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PolisDefinition>(
      row,
      columns: columns?.call(PolisDefinition.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PolisDefinition] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PolisDefinition?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PolisDefinitionUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PolisDefinition>(
      id,
      columnValues: columnValues(PolisDefinition.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PolisDefinition]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PolisDefinition>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PolisDefinitionUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<PolisDefinitionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PolisDefinitionTable>? orderBy,
    _i1.OrderByListBuilder<PolisDefinitionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PolisDefinition>(
      columnValues: columnValues(PolisDefinition.t.updateTable),
      where: where(PolisDefinition.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PolisDefinition.t),
      orderByList: orderByList?.call(PolisDefinition.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PolisDefinition]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PolisDefinition>> delete(
    _i1.Session session,
    List<PolisDefinition> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PolisDefinition>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PolisDefinition].
  Future<PolisDefinition> deleteRow(
    _i1.Session session,
    PolisDefinition row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PolisDefinition>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PolisDefinition>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PolisDefinitionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PolisDefinition>(
      where: where(PolisDefinition.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PolisDefinitionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PolisDefinition>(
      where: where?.call(PolisDefinition.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PolisDefinition] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PolisDefinitionTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PolisDefinition>(
      where: where(PolisDefinition.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
