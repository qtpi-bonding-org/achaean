/// Models representing discovered freezed state classes that implement
/// `IUiFlowState`.

class DiscoveredField {
  final String name;
  final String typeName;
  final bool isNullable;
  final bool isList;
  final bool isMap;
  final String? listElementType;
  final String? mapKeyType;
  final String? mapValueType;
  final Object? defaultValue;

  const DiscoveredField({
    required this.name,
    required this.typeName,
    this.isNullable = false,
    this.isList = false,
    this.isMap = false,
    this.listElementType,
    this.mapKeyType,
    this.mapValueType,
    this.defaultValue,
  });

  /// Whether this field is one of the standard UiFlow fields (status/error).
  bool get isUiFlowField => name == 'status' || name == 'error';

  @override
  String toString() =>
      'DiscoveredField($name: $typeName${isNullable ? '?' : ''})';
}

class DiscoveredState {
  final String className;
  final String filePath;
  final String importUri;
  final List<DiscoveredField> fields;

  const DiscoveredState({
    required this.className,
    required this.filePath,
    required this.importUri,
    required this.fields,
  });

  /// Fields that are not the standard UiFlow status/error fields.
  List<DiscoveredField> get dataFields =>
      fields.where((f) => !f.isUiFlowField).toList();

  @override
  String toString() =>
      'DiscoveredState($className, ${fields.length} fields)';
}
