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
import 'koinon/observe_declaration_record.dart' as _i4;
import 'koinon/polis_definition.dart' as _i5;
import 'koinon/politai_user.dart' as _i6;
import 'koinon/post_reference.dart' as _i7;
import 'koinon/readme_signature_record.dart' as _i8;
import 'koinon/trust_declaration_record.dart' as _i9;
import 'package:achaean_client/src/protocol/koinon/polis_definition.dart'
    as _i10;
import 'package:achaean_client/src/protocol/koinon/readme_signature_record.dart'
    as _i11;
import 'package:achaean_client/src/protocol/koinon/politai_user.dart' as _i12;
import 'package:achaean_client/src/protocol/koinon/trust_declaration_record.dart'
    as _i13;
import 'package:achaean_client/src/protocol/koinon/observe_declaration_record.dart'
    as _i14;
import 'package:achaean_client/src/protocol/koinon/flag_record.dart' as _i15;
import 'package:achaean_client/src/protocol/koinon/post_reference.dart' as _i16;
export 'greetings/greeting.dart';
export 'koinon/flag_record.dart';
export 'koinon/observe_declaration_record.dart';
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
    if (t == _i4.ObserveDeclarationRecord) {
      return _i4.ObserveDeclarationRecord.fromJson(data) as T;
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
    if (t == _i1.getType<_i2.Greeting?>()) {
      return (data != null ? _i2.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FlagRecord?>()) {
      return (data != null ? _i3.FlagRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ObserveDeclarationRecord?>()) {
      return (data != null ? _i4.ObserveDeclarationRecord.fromJson(data) : null)
          as T;
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
    if (t == List<_i14.ObserveDeclarationRecord>) {
      return (data as List)
              .map((e) => deserialize<_i14.ObserveDeclarationRecord>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.FlagRecord>) {
      return (data as List).map((e) => deserialize<_i15.FlagRecord>(e)).toList()
          as T;
    }
    if (t == List<_i16.PostReference>) {
      return (data as List)
              .map((e) => deserialize<_i16.PostReference>(e))
              .toList()
          as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
          )
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Greeting => 'Greeting',
      _i3.FlagRecord => 'FlagRecord',
      _i4.ObserveDeclarationRecord => 'ObserveDeclarationRecord',
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
      case _i2.Greeting():
        return 'Greeting';
      case _i3.FlagRecord():
        return 'FlagRecord';
      case _i4.ObserveDeclarationRecord():
        return 'ObserveDeclarationRecord';
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
    if (dataClassName == 'ObserveDeclarationRecord') {
      return deserialize<_i4.ObserveDeclarationRecord>(data['data']);
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
