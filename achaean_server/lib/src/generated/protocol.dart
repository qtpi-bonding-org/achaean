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
import 'greetings/greeting.dart' as _i3;
import 'koinon/flag_record.dart' as _i4;
import 'koinon/polis_definition.dart' as _i5;
import 'koinon/politai_user.dart' as _i6;
import 'koinon/post_reference.dart' as _i7;
import 'koinon/readme_signature_record.dart' as _i8;
import 'koinon/trust_declaration_record.dart' as _i9;
import 'package:achaean_server/src/generated/koinon/polis_definition.dart'
    as _i10;
import 'package:achaean_server/src/generated/koinon/readme_signature_record.dart'
    as _i11;
import 'package:achaean_server/src/generated/koinon/politai_user.dart' as _i12;
import 'package:achaean_server/src/generated/koinon/trust_declaration_record.dart'
    as _i13;
import 'package:achaean_server/src/generated/koinon/flag_record.dart' as _i14;
import 'package:achaean_server/src/generated/koinon/post_reference.dart'
    as _i15;
export 'greetings/greeting.dart';
export 'koinon/flag_record.dart';
export 'koinon/polis_definition.dart';
export 'koinon/politai_user.dart';
export 'koinon/post_reference.dart';
export 'koinon/readme_signature_record.dart';
export 'koinon/trust_declaration_record.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'flag_records',
      dartName: 'FlagRecord',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'flag_records_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'flaggedByPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'postAuthorPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'postUrl',
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
          name: 'reason',
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
          indexName: 'flag_records_pkey',
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
          indexName: 'flag_records_flagger_post_polis_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'flaggedByPubkey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'postUrl',
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
          indexName: 'flag_records_post_polis_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'postUrl',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'polisRepoUrl',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'flag_records_author_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'postAuthorPubkey',
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
      name: 'polis_definitions',
      dartName: 'PolisDefinition',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'polis_definitions_id_seq\'::regclass)',
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
          indexName: 'polis_definitions_pkey',
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
          indexName: 'polis_definitions_repo_url_idx',
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
      name: 'politai_users',
      dartName: 'PolitaiUser',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'politai_users_id_seq\'::regclass)',
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
          name: 'displayName',
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
          indexName: 'politai_users_pkey',
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
          indexName: 'politai_users_pubkey_idx',
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
          indexName: 'politai_users_repo_url_idx',
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
      name: 'post_references',
      dartName: 'PostReference',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'post_references_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authorPubkey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'authorRepoUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'postUrl',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'commitHash',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'poleisTags',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'timestamp',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'parentPostUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
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
          indexName: 'post_references_pkey',
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
          indexName: 'post_references_post_url_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'postUrl',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'post_references_timestamp_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'timestamp',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'post_references_parent_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parentPostUrl',
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
      name: 'readme_signatures',
      dartName: 'ReadmeSignatureRecord',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'readme_signatures_id_seq\'::regclass)',
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
          indexName: 'readme_signatures_pkey',
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
          indexName: 'readme_signatures_signer_polis_idx',
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
          indexName: 'readme_signatures_polis_idx',
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
      name: 'trust_declarations',
      dartName: 'TrustDeclarationRecord',
      schema: 'public',
      module: 'achaean',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'trust_declarations_id_seq\'::regclass)',
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
          indexName: 'trust_declarations_pkey',
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
          indexName: 'trust_declarations_from_to_idx',
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
          indexName: 'trust_declarations_to_pubkey_idx',
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
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
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

    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.FlagRecord) {
      return _i4.FlagRecord.fromJson(data) as T;
    }
    if (t == _i5.PolisDefinition) {
      return _i5.PolisDefinition.fromJson(data) as T;
    }
    if (t == _i6.PolitaiUser) {
      return _i6.PolitaiUser.fromJson(data) as T;
    }
    if (t == _i7.PostReference) {
      return _i7.PostReference.fromJson(data) as T;
    }
    if (t == _i8.ReadmeSignatureRecord) {
      return _i8.ReadmeSignatureRecord.fromJson(data) as T;
    }
    if (t == _i9.TrustDeclarationRecord) {
      return _i9.TrustDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.FlagRecord?>()) {
      return (data != null ? _i4.FlagRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.PolisDefinition?>()) {
      return (data != null ? _i5.PolisDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PolitaiUser?>()) {
      return (data != null ? _i6.PolitaiUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.PostReference?>()) {
      return (data != null ? _i7.PostReference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ReadmeSignatureRecord?>()) {
      return (data != null ? _i8.ReadmeSignatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.TrustDeclarationRecord?>()) {
      return (data != null ? _i9.TrustDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == List<_i10.PolisDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i10.PolisDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.ReadmeSignatureRecord>) {
      return (data as List)
              .map((e) => deserialize<_i11.ReadmeSignatureRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.PolitaiUser>) {
      return (data as List)
              .map((e) => deserialize<_i12.PolitaiUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.TrustDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i13.TrustDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.FlagRecord>) {
      return (data as List).map((e) => deserialize<_i14.FlagRecord>(e)).toList()
          as T;
    }
    if (t == List<_i15.PostReference>) {
      return (data as List)
              .map((e) => deserialize<_i15.PostReference>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i3.Greeting => 'Greeting',
      _i4.FlagRecord => 'FlagRecord',
      _i5.PolisDefinition => 'PolisDefinition',
      _i6.PolitaiUser => 'PolitaiUser',
      _i7.PostReference => 'PostReference',
      _i8.ReadmeSignatureRecord => 'ReadmeSignatureRecord',
      _i9.TrustDeclarationRecord => 'TrustDeclarationRecord',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('achaean.', '');
    }

    switch (data) {
      case _i3.Greeting():
        return 'Greeting';
      case _i4.FlagRecord():
        return 'FlagRecord';
      case _i5.PolisDefinition():
        return 'PolisDefinition';
      case _i6.PolitaiUser():
        return 'PolitaiUser';
      case _i7.PostReference():
        return 'PostReference';
      case _i8.ReadmeSignatureRecord():
        return 'ReadmeSignatureRecord';
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
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'FlagRecord') {
      return deserialize<_i4.FlagRecord>(data['data']);
    }
    if (dataClassName == 'PolisDefinition') {
      return deserialize<_i5.PolisDefinition>(data['data']);
    }
    if (dataClassName == 'PolitaiUser') {
      return deserialize<_i6.PolitaiUser>(data['data']);
    }
    if (dataClassName == 'PostReference') {
      return deserialize<_i7.PostReference>(data['data']);
    }
    if (dataClassName == 'ReadmeSignatureRecord') {
      return deserialize<_i8.ReadmeSignatureRecord>(data['data']);
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
      case _i4.FlagRecord:
        return _i4.FlagRecord.t;
      case _i5.PolisDefinition:
        return _i5.PolisDefinition.t;
      case _i6.PolitaiUser:
        return _i6.PolitaiUser.t;
      case _i7.PostReference:
        return _i7.PostReference.t;
      case _i8.ReadmeSignatureRecord:
        return _i8.ReadmeSignatureRecord.t;
      case _i9.TrustDeclarationRecord:
        return _i9.TrustDeclarationRecord.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'achaean';

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
