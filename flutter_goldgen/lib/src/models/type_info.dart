/// Models representing resolved type information for code generation.

class TypeInfo {
  final String name;
  final TypeKind kind;
  final bool isNullable;
  final List<TypeInfo> typeArguments;
  final List<ConstructorParam>? constructorParams;
  final List<String>? enumValues;

  const TypeInfo({
    required this.name,
    required this.kind,
    this.isNullable = false,
    this.typeArguments = const [],
    this.constructorParams,
    this.enumValues,
  });
}

enum TypeKind {
  string,
  int,
  double,
  bool,
  list,
  map,
  enumType,
  customModel,
  object,
  dateTime,
}

class ConstructorParam {
  final String name;
  final TypeInfo type;
  final bool isRequired;
  final String? defaultValueCode;

  const ConstructorParam({
    required this.name,
    required this.type,
    this.isRequired = false,
    this.defaultValueCode,
  });
}
