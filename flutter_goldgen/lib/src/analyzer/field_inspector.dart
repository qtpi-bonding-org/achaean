import '../models/discovered_state.dart';
import '../models/type_info.dart';

/// Converts [DiscoveredField] into [TypeInfo] with full type resolution.
///
/// For primitive types (String, int, bool, double, DateTime), it's a direct
/// mapping. For List/Map, it recurses into type arguments. For custom models,
/// it marks them as [TypeKind.customModel] with the type name.
class FieldInspector {
  /// Resolve a [DiscoveredField] into a fully described [TypeInfo].
  TypeInfo resolveField(DiscoveredField field) {
    return _resolveType(field.typeName, field.isNullable, field);
  }

  TypeInfo _resolveType(String typeName, bool isNullable,
      [DiscoveredField? field]) {
    // Strip nullable suffix for matching
    final baseName = typeName.replaceAll('?', '').trim();

    // Check primitives
    final kind = _primitiveKind(baseName);
    if (kind != null) {
      return TypeInfo(name: baseName, kind: kind, isNullable: isNullable);
    }

    // Check List
    if (field?.isList == true || baseName.startsWith('List')) {
      final elementType = field?.listElementType;
      return TypeInfo(
        name: baseName,
        kind: TypeKind.list,
        isNullable: isNullable,
        typeArguments:
            elementType != null ? [_resolveType(elementType, false)] : [],
      );
    }

    // Check Map
    if (field?.isMap == true || baseName.startsWith('Map')) {
      return TypeInfo(
        name: baseName,
        kind: TypeKind.map,
        isNullable: isNullable,
        typeArguments: [
          if (field?.mapKeyType != null)
            _resolveType(field!.mapKeyType!, false),
          if (field?.mapValueType != null)
            _resolveType(field!.mapValueType!, false),
        ],
      );
    }

    // Everything else is a custom model
    return TypeInfo(
      name: baseName,
      kind: TypeKind.customModel,
      isNullable: isNullable,
    );
  }

  TypeKind? _primitiveKind(String typeName) {
    return switch (typeName) {
      'String' => TypeKind.string,
      'int' => TypeKind.int,
      'double' => TypeKind.double,
      'bool' => TypeKind.bool,
      'DateTime' => TypeKind.dateTime,
      'Object' => TypeKind.object,
      'dynamic' => TypeKind.object,
      _ => null,
    };
  }
}
