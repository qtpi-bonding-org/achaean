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
import 'greetings/greeting.dart' as _i2;
import 'koinon/flag_record.dart' as _i3;
import 'koinon/polis_definition.dart' as _i4;
import 'koinon/politai_user.dart' as _i5;
import 'koinon/post_reference.dart' as _i6;
import 'koinon/readme_signature_record.dart' as _i7;
import 'koinon/trust_declaration_record.dart' as _i8;
import 'package:achaean_client/src/protocol/koinon/polis_definition.dart'
    as _i9;
import 'package:achaean_client/src/protocol/koinon/readme_signature_record.dart'
    as _i10;
import 'package:achaean_client/src/protocol/koinon/politai_user.dart' as _i11;
import 'package:achaean_client/src/protocol/koinon/trust_declaration_record.dart'
    as _i12;
import 'package:achaean_client/src/protocol/koinon/post_reference.dart' as _i13;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i14;
import 'package:anonaccount_client/anonaccount_client.dart' as _i15;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i16;
export 'greetings/greeting.dart';
export 'koinon/flag_record.dart';
export 'koinon/polis_definition.dart';
export 'koinon/politai_user.dart';
export 'koinon/post_reference.dart';
export 'koinon/readme_signature_record.dart';
export 'koinon/trust_declaration_record.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Greeting) {
      return _i2.Greeting.fromJson(data) as T;
    }
    if (t == _i3.FlagRecord) {
      return _i3.FlagRecord.fromJson(data) as T;
    }
    if (t == _i4.PolisDefinition) {
      return _i4.PolisDefinition.fromJson(data) as T;
    }
    if (t == _i5.PolitaiUser) {
      return _i5.PolitaiUser.fromJson(data) as T;
    }
    if (t == _i6.PostReference) {
      return _i6.PostReference.fromJson(data) as T;
    }
    if (t == _i7.ReadmeSignatureRecord) {
      return _i7.ReadmeSignatureRecord.fromJson(data) as T;
    }
    if (t == _i8.TrustDeclarationRecord) {
      return _i8.TrustDeclarationRecord.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FlagRecord?>()) {
      return (data != null ? _i3.FlagRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.PolisDefinition?>()) {
      return (data != null ? _i4.PolisDefinition.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.PolitaiUser?>()) {
      return (data != null ? _i5.PolitaiUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.PostReference?>()) {
      return (data != null ? _i6.PostReference.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ReadmeSignatureRecord?>()) {
      return (data != null ? _i7.ReadmeSignatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.TrustDeclarationRecord?>()) {
      return (data != null ? _i8.TrustDeclarationRecord.fromJson(data) : null)
          as T;
    }
    if (t == List<_i9.PolisDefinition>) {
      return (data as List)
              .map((e) => deserialize<_i9.PolisDefinition>(e))
              .toList()
          as T;
    }
    if (t == List<_i10.ReadmeSignatureRecord>) {
      return (data as List)
              .map((e) => deserialize<_i10.ReadmeSignatureRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i11.PolitaiUser>) {
      return (data as List)
              .map((e) => deserialize<_i11.PolitaiUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i12.TrustDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i12.TrustDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i13.PostReference>) {
      return (data as List)
              .map((e) => deserialize<_i13.PostReference>(e))
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
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i16.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Greeting => 'Greeting',
      _i3.FlagRecord => 'FlagRecord',
      _i4.PolisDefinition => 'PolisDefinition',
      _i5.PolitaiUser => 'PolitaiUser',
      _i6.PostReference => 'PostReference',
      _i7.ReadmeSignatureRecord => 'ReadmeSignatureRecord',
      _i8.TrustDeclarationRecord => 'TrustDeclarationRecord',
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
      case _i2.Greeting():
        return 'Greeting';
      case _i3.FlagRecord():
        return 'FlagRecord';
      case _i4.PolisDefinition():
        return 'PolisDefinition';
      case _i5.PolitaiUser():
        return 'PolitaiUser';
      case _i6.PostReference():
        return 'PostReference';
      case _i7.ReadmeSignatureRecord():
        return 'ReadmeSignatureRecord';
      case _i8.TrustDeclarationRecord():
        return 'TrustDeclarationRecord';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'anonaccount.$className';
    }
    className = _i16.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
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
      return deserialize<_i2.Greeting>(data['data']);
    }
    if (dataClassName == 'FlagRecord') {
      return deserialize<_i3.FlagRecord>(data['data']);
    }
    if (dataClassName == 'PolisDefinition') {
      return deserialize<_i4.PolisDefinition>(data['data']);
    }
    if (dataClassName == 'PolitaiUser') {
      return deserialize<_i5.PolitaiUser>(data['data']);
    }
    if (dataClassName == 'PostReference') {
      return deserialize<_i6.PostReference>(data['data']);
    }
    if (dataClassName == 'ReadmeSignatureRecord') {
      return deserialize<_i7.ReadmeSignatureRecord>(data['data']);
    }
    if (dataClassName == 'TrustDeclarationRecord') {
      return deserialize<_i8.TrustDeclarationRecord>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('anonaccount.')) {
      data['className'] = dataClassName.substring(12);
      return _i15.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i16.Protocol().deserializeByClassName(data);
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
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i16.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
