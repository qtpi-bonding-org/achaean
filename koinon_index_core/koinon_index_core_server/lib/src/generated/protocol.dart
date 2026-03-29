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
import 'package:serverpod/protocol.dart' as _i2;
import 'observe_declaration_record.dart' as _i3;
import 'polis_definition.dart' as _i4;
import 'polis_member.dart' as _i5;
import 'politai_user.dart' as _i6;
import 'readme_signature_record.dart' as _i7;
import 'relationships.dart' as _i8;
import 'trust_declaration_record.dart' as _i9;
import 'package:koinon_index_core_server/src/generated/polis_definition.dart'
    as _i10;
import 'package:koinon_index_core_server/src/generated/polis_member.dart'
    as _i11;
export 'observe_declaration_record.dart';
export 'polis_definition.dart';
export 'polis_member.dart';
export 'politai_user.dart';
export 'readme_signature_record.dart';
export 'relationships.dart';
export 'trust_declaration_record.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'koinon_observe_declarations',
      dartName: 'ObserveDeclarationRecord',
      schema: 'public',
      module: 'koinon_index_core',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'koinon_observe_declarations_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fromPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'toPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subjectRepoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'indexedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'koinon_observe_declarations_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_observe_declarations_from_to_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromPubkey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toPubkey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_observe_declarations_from_pubkey_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromPubkey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_observe_declarations_to_pubkey_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toPubkey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'koinon_polis_definitions',
      dartName: 'PolisDefinition',
      schema: 'public',
      module: 'koinon_index_core',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'koinon_polis_definitions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'repoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'membershipThreshold',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'flagThreshold',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'parentRepoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ownerPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'readmeCommit',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'discoveredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastIndexedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'koinon_polis_definitions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_polis_definitions_repo_url_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'repoUrl',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'koinon_politai_users',
      dartName: 'PolitaiUser',
      schema: 'public',
      module: 'koinon_index_core',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'koinon_politai_users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'pubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'repoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'discoveredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastIndexedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'koinon_politai_users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_politai_users_pubkey_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'pubkey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_politai_users_repo_url_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'repoUrl',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'koinon_readme_signatures',
      dartName: 'ReadmeSignatureRecord',
      schema: 'public',
      module: 'koinon_index_core',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'koinon_readme_signatures_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'signerPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'polisRepoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'readmeCommit',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'readmeHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'indexedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'koinon_readme_signatures_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_readme_signatures_signer_polis_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'signerPubkey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'polisRepoUrl',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_readme_signatures_polis_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'polisRepoUrl',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'koinon_trust_declarations',
      dartName: 'TrustDeclarationRecord',
      schema: 'public',
      module: 'koinon_index_core',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'koinon_trust_declarations_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'fromPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'toPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subjectRepoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'indexedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'koinon_trust_declarations_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_trust_declarations_from_to_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'fromPubkey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toPubkey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'koinon_trust_declarations_to_pubkey_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'toPubkey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    if (className == null) return null;
    if (!className.startsWith('koinon_index_core.')) return className;
    return className.substring(18);
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i3.ObserveDeclarationRecord) {
      return _i3.ObserveDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i4.PolisDefinition) {
      return _i4.PolisDefinition.fromJson(data) as T;
    }
    if (t == _i5.PolisMember) {
      return _i5.PolisMember.fromJson(data) as T;
    }
    if (t == _i6.PolitaiUser) {
      return _i6.PolitaiUser.fromJson(data) as T;
    }
    if (t == _i7.ReadmeSignatureRecord) {
      return _i7.ReadmeSignatureRecord.fromJson(data) as T;
    }
    if (t == _i8.Relationships) {
      return _i8.Relationships.fromJson(data) as T;
    }
    if (t == _i9.TrustDeclarationRecord) {
      return _i9.TrustDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.ObserveDeclarationRecord?>()) {
      return (data != null ? _i3.ObserveDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i4.PolisDefinition?>()) {
      return (data != null ? _i4.PolisDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.PolisMember?>()) {
      return (data != null ? _i5.PolisMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PolitaiUser?>()) {
      return (data != null ? _i6.PolitaiUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ReadmeSignatureRecord?>()) {
      return (data != null ? _i7.ReadmeSignatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.Relationships?>()) {
      return (data != null ? _i8.Relationships.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.TrustDeclarationRecord?>()) {
      return (data != null ? _i9.TrustDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == List<_i9.TrustDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i9.TrustDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i3.ObserveDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i3.ObserveDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.PolisDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i10.PolisDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.PolisMember>) {
      return (data as List)
              .map((e) => deserialize<_i11.PolisMember>(e))
              .toList()
          as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i3.ObserveDeclarationRecord => 'ObserveDeclarationRecord',
      _i4.PolisDefinition => 'PolisDefinition',
      _i5.PolisMember => 'PolisMember',
      _i6.PolitaiUser => 'PolitaiUser',
      _i7.ReadmeSignatureRecord => 'ReadmeSignatureRecord',
      _i8.Relationships => 'Relationships',
      _i9.TrustDeclarationRecord => 'TrustDeclarationRecord',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'koinon_index_core.',
        '',
      );
    }

    switch (data) {
      case _i3.ObserveDeclarationRecord():
        return 'ObserveDeclarationRecord';
      case _i4.PolisDefinition():
        return 'PolisDefinition';
      case _i5.PolisMember():
        return 'PolisMember';
      case _i6.PolitaiUser():
        return 'PolitaiUser';
      case _i7.ReadmeSignatureRecord():
        return 'ReadmeSignatureRecord';
      case _i8.Relationships():
        return 'Relationships';
      case _i9.TrustDeclarationRecord():
        return 'TrustDeclarationRecord';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ObserveDeclarationRecord') {
      return deserialize<_i3.ObserveDeclarationRecord>(data['data']);
    }
    if (dataClassName == 'PolisDefinition') {
      return deserialize<_i4.PolisDefinition>(data['data']);
    }
    if (dataClassName == 'PolisMember') {
      return deserialize<_i5.PolisMember>(data['data']);
    }
    if (dataClassName == 'PolitaiUser') {
      return deserialize<_i6.PolitaiUser>(data['data']);
    }
    if (dataClassName == 'ReadmeSignatureRecord') {
      return deserialize<_i7.ReadmeSignatureRecord>(data['data']);
    }
    if (dataClassName == 'Relationships') {
      return deserialize<_i8.Relationships>(data['data']);
    }
    if (dataClassName == 'TrustDeclarationRecord') {
      return deserialize<_i9.TrustDeclarationRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i3.ObserveDeclarationRecord:
        return _i3.ObserveDeclarationRecord.t;
      case _i4.PolisDefinition:
        return _i4.PolisDefinition.t;
      case _i6.PolitaiUser:
        return _i6.PolitaiUser.t;
      case _i7.ReadmeSignatureRecord:
        return _i7.ReadmeSignatureRecord.t;
      case _i9.TrustDeclarationRecord:
        return _i9.TrustDeclarationRecord.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'koinon_index_core';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i2.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
