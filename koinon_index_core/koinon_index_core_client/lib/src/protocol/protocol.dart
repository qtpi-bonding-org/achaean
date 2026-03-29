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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'observe_declaration_record.dart' as _i2;
import 'polis_definition.dart' as _i3;
import 'polis_member.dart' as _i4;
import 'politai_user.dart' as _i5;
import 'readme_signature_record.dart' as _i6;
import 'relationships.dart' as _i7;
import 'trust_declaration_record.dart' as _i8;
import 'package:koinon_index_core_client/src/protocol/polis_definition.dart'
    as _i9;
import 'package:koinon_index_core_client/src/protocol/polis_member.dart'
    as _i10;
export 'observe_declaration_record.dart';
export 'polis_definition.dart';
export 'polis_member.dart';
export 'politai_user.dart';
export 'readme_signature_record.dart';
export 'relationships.dart';
export 'trust_declaration_record.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.ObserveDeclarationRecord) {
      return _i2.ObserveDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i3.PolisDefinition) {
      return _i3.PolisDefinition.fromJson(data) as T;
    }
    if (t == _i4.PolisMember) {
      return _i4.PolisMember.fromJson(data) as T;
    }
    if (t == _i5.PolitaiUser) {
      return _i5.PolitaiUser.fromJson(data) as T;
    }
    if (t == _i6.ReadmeSignatureRecord) {
      return _i6.ReadmeSignatureRecord.fromJson(data) as T;
    }
    if (t == _i7.Relationships) {
      return _i7.Relationships.fromJson(data) as T;
    }
    if (t == _i8.TrustDeclarationRecord) {
      return _i8.TrustDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ObserveDeclarationRecord?>()) {
      return (data != null ? _i2.ObserveDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.PolisDefinition?>()) {
      return (data != null ? _i3.PolisDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.PolisMember?>()) {
      return (data != null ? _i4.PolisMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.PolitaiUser?>()) {
      return (data != null ? _i5.PolitaiUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ReadmeSignatureRecord?>()) {
      return (data != null ? _i6.ReadmeSignatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.Relationships?>()) {
      return (data != null ? _i7.Relationships.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.TrustDeclarationRecord?>()) {
      return (data != null ? _i8.TrustDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == List<_i8.TrustDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i8.TrustDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i2.ObserveDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i2.ObserveDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i9.PolisDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i9.PolisDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.PolisMember>) {
      return (data as List)
              .map((e) => deserialize<_i10.PolisMember>(e))
              .toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.ObserveDeclarationRecord => 'ObserveDeclarationRecord',
      _i3.PolisDefinition => 'PolisDefinition',
      _i4.PolisMember => 'PolisMember',
      _i5.PolitaiUser => 'PolitaiUser',
      _i6.ReadmeSignatureRecord => 'ReadmeSignatureRecord',
      _i7.Relationships => 'Relationships',
      _i8.TrustDeclarationRecord => 'TrustDeclarationRecord',
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
      case _i2.ObserveDeclarationRecord():
        return 'ObserveDeclarationRecord';
      case _i3.PolisDefinition():
        return 'PolisDefinition';
      case _i4.PolisMember():
        return 'PolisMember';
      case _i5.PolitaiUser():
        return 'PolitaiUser';
      case _i6.ReadmeSignatureRecord():
        return 'ReadmeSignatureRecord';
      case _i7.Relationships():
        return 'Relationships';
      case _i8.TrustDeclarationRecord():
        return 'TrustDeclarationRecord';
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
      return deserialize<_i2.ObserveDeclarationRecord>(data['data']);
    }
    if (dataClassName == 'PolisDefinition') {
      return deserialize<_i3.PolisDefinition>(data['data']);
    }
    if (dataClassName == 'PolisMember') {
      return deserialize<_i4.PolisMember>(data['data']);
    }
    if (dataClassName == 'PolitaiUser') {
      return deserialize<_i5.PolitaiUser>(data['data']);
    }
    if (dataClassName == 'ReadmeSignatureRecord') {
      return deserialize<_i6.ReadmeSignatureRecord>(data['data']);
    }
    if (dataClassName == 'Relationships') {
      return deserialize<_i7.Relationships>(data['data']);
    }
    if (dataClassName == 'TrustDeclarationRecord') {
      return deserialize<_i8.TrustDeclarationRecord>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
