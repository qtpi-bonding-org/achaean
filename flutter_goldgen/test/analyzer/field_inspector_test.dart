import 'package:flutter_goldgen/src/analyzer/field_inspector.dart';
import 'package:flutter_goldgen/src/models/discovered_state.dart';
import 'package:flutter_goldgen/src/models/type_info.dart';
import 'package:test/test.dart';

void main() {
  group('FieldInspector', () {
    late FieldInspector inspector;

    setUp(() {
      inspector = FieldInspector();
    });

    test('resolves String field', () {
      final field = DiscoveredField(name: 'title', typeName: 'String');
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.string);
      expect(info.isNullable, false);
    });

    test('resolves nullable String field', () {
      final field = DiscoveredField(
          name: 'title', typeName: 'String?', isNullable: true);
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.string);
      expect(info.isNullable, true);
    });

    test('resolves int field', () {
      final field = DiscoveredField(name: 'count', typeName: 'int');
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.int);
    });

    test('resolves bool field', () {
      final field = DiscoveredField(name: 'hasMore', typeName: 'bool');
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.bool);
    });

    test('resolves List<String> field', () {
      final field = DiscoveredField(
        name: 'items',
        typeName: 'List<String>',
        isList: true,
        listElementType: 'String',
      );
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.list);
      expect(info.typeArguments, hasLength(1));
      expect(info.typeArguments.first.kind, TypeKind.string);
    });

    test('resolves Map<String, int> field', () {
      final field = DiscoveredField(
        name: 'counts',
        typeName: 'Map<String, int>',
        isMap: true,
        mapKeyType: 'String',
        mapValueType: 'int',
      );
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.map);
      expect(info.typeArguments, hasLength(2));
      expect(info.typeArguments[0].kind, TypeKind.string);
      expect(info.typeArguments[1].kind, TypeKind.int);
    });

    test('resolves custom model as customModel', () {
      final field =
          DiscoveredField(name: 'result', typeName: 'AccountCreationResult');
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.customModel);
      expect(info.name, 'AccountCreationResult');
    });

    test('resolves List<CustomModel> field', () {
      final field = DiscoveredField(
        name: 'posts',
        typeName: 'List<CachedPost>',
        isList: true,
        listElementType: 'CachedPost',
      );
      final info = inspector.resolveField(field);
      expect(info.kind, TypeKind.list);
      expect(info.typeArguments.first.kind, TypeKind.customModel);
      expect(info.typeArguments.first.name, 'CachedPost');
    });
  });
}
