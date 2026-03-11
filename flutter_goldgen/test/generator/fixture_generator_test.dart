import 'package:flutter_goldgen/src/generator/fixture_generator.dart';
import 'package:flutter_goldgen/src/models/type_info.dart';
import 'package:test/test.dart';

void main() {
  group('FixtureGenerator', () {
    late FixtureGenerator generator;

    setUp(() {
      generator = FixtureGenerator();
    });

    test('generates String edge cases', () {
      final type = TypeInfo(name: 'String', kind: TypeKind.string);
      final values = generator.generateValues(type);

      expect(values, contains("''"));
      expect(values, contains("'A'"));
      expect(values.any((v) => v.contains('200')), true);
    });

    test('generates nullable String includes null', () {
      final type = TypeInfo(
          name: 'String', kind: TypeKind.string, isNullable: true);
      final values = generator.generateValues(type);
      expect(values, contains('null'));
      expect(values.length, greaterThan(4)); // null + 4 string values
    });

    test('generates int edge cases', () {
      final type = TypeInfo(name: 'int', kind: TypeKind.int);
      final values = generator.generateValues(type);
      expect(values, contains('0'));
      expect(values, contains('1'));
      expect(values, contains('999999'));
    });

    test('generates bool edge cases', () {
      final type = TypeInfo(name: 'bool', kind: TypeKind.bool);
      final values = generator.generateValues(type);
      expect(values, contains('true'));
      expect(values, contains('false'));
    });

    test('generates List edge cases', () {
      final type = TypeInfo(
        name: 'List<String>',
        kind: TypeKind.list,
        typeArguments: [TypeInfo(name: 'String', kind: TypeKind.string)],
      );
      final values = generator.generateValues(type);

      expect(values.any((v) => v.contains('[]')), true);
      expect(values.any((v) => v.contains('List.filled')), true);
    });

    test('generates Map edge cases', () {
      final type = TypeInfo(
        name: 'Map<String, int>',
        kind: TypeKind.map,
        typeArguments: [
          TypeInfo(name: 'String', kind: TypeKind.string),
          TypeInfo(name: 'int', kind: TypeKind.int),
        ],
      );
      final values = generator.generateValues(type);
      expect(values.any((v) => v.contains('{}')), true);
    });

    test('generates enum edge cases', () {
      final type = TypeInfo(
        name: 'MyEnum',
        kind: TypeKind.enumType,
        enumValues: ['valueA', 'valueB', 'valueC'],
      );
      final values = generator.generateValues(type);
      expect(values, contains('MyEnum.valueA'));
      expect(values, contains('MyEnum.valueB'));
      expect(values, contains('MyEnum.valueC'));
    });

    test('generates custom model value', () {
      final type = TypeInfo(name: 'MyModel', kind: TypeKind.customModel);
      final values = generator.generateValues(type);
      expect(values, contains('MyModel()'));
    });

    test('generateNormal returns sensible defaults', () {
      expect(
          generator.generateNormal(
              TypeInfo(name: 'String', kind: TypeKind.string)),
          "'Test string'");
      expect(
          generator
              .generateNormal(TypeInfo(name: 'int', kind: TypeKind.int)),
          '1');
      expect(
          generator
              .generateNormal(TypeInfo(name: 'bool', kind: TypeKind.bool)),
          'true');
    });
  });
}
