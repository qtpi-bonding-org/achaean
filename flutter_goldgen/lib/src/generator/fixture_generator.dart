import '../models/type_info.dart';

/// Takes a [TypeInfo] and generates Dart code strings representing edge case
/// values suitable for golden test fixtures.
class FixtureGenerator {
  /// Generate edge case value expressions (as Dart code strings) for a type.
  List<String> generateValues(TypeInfo type) {
    final values = <String>[];

    if (type.isNullable) {
      values.add('null');
    }

    switch (type.kind) {
      case TypeKind.string:
        values.addAll(["''", "'A'", "'Test string'", "'A' * 200"]);
      case TypeKind.int:
        values.addAll(['0', '1', '999999']);
      case TypeKind.double:
        values.addAll(['0.0', '1.5', '999999.99']);
      case TypeKind.bool:
        values.addAll(['true', 'false']);
      case TypeKind.dateTime:
        values.addAll(["DateTime(2026, 1, 1)", "DateTime.now()"]);
      case TypeKind.list:
        final elementType =
            type.typeArguments.isNotEmpty ? type.typeArguments.first : null;
        final elementNormal =
            elementType != null ? generateNormal(elementType) : "'item'";
        values.addAll([
          '<${elementType?.name ?? 'dynamic'}>[]',
          '[$elementNormal]',
          'List.filled(50, $elementNormal)',
        ]);
      case TypeKind.map:
        final keyType =
            type.typeArguments.isNotEmpty ? type.typeArguments[0] : null;
        final valType =
            type.typeArguments.length >= 2 ? type.typeArguments[1] : null;
        final keyNormal =
            keyType != null ? generateNormal(keyType) : "'key'";
        final valNormal =
            valType != null ? generateNormal(valType) : "'value'";
        values.addAll([
          '<${keyType?.name ?? 'String'}, ${valType?.name ?? 'dynamic'}>{}',
          '{$keyNormal: $valNormal}',
        ]);
      case TypeKind.enumType:
        for (final v in type.enumValues ?? []) {
          values.add('${type.name}.$v');
        }
      case TypeKind.customModel:
        values.add('${type.name}()');
      case TypeKind.object:
        values.add("Object()");
    }

    return values;
  }

  /// Generate a single "normal" value for use as baseline.
  String generateNormal(TypeInfo type) {
    return switch (type.kind) {
      TypeKind.string => "'Test string'",
      TypeKind.int => '1',
      TypeKind.double => '1.5',
      TypeKind.bool => 'true',
      TypeKind.dateTime => 'DateTime(2026, 1, 1)',
      TypeKind.list => _normalList(type),
      TypeKind.map => _normalMap(type),
      TypeKind.enumType =>
        '${type.name}.${type.enumValues?.first ?? 'values.first'}',
      TypeKind.customModel => '${type.name}()',
      TypeKind.object => "Object()",
    };
  }

  String _normalList(TypeInfo type) {
    if (type.typeArguments.isEmpty) return "['item']";
    final elementNormal = generateNormal(type.typeArguments.first);
    return '[$elementNormal]';
  }

  String _normalMap(TypeInfo type) {
    if (type.typeArguments.length < 2) return "{'key': 'value'}";
    final keyNormal = generateNormal(type.typeArguments[0]);
    final valNormal = generateNormal(type.typeArguments[1]);
    return '{$keyNormal: $valNormal}';
  }
}
