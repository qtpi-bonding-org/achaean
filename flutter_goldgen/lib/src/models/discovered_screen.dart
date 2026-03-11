/// Models representing discovered Flutter screens and their cubit bindings.

class CubitBinding {
  final String cubitClassName;
  final String stateClassName;

  const CubitBinding({
    required this.cubitClassName,
    required this.stateClassName,
  });

  @override
  String toString() => 'CubitBinding($cubitClassName, $stateClassName)';
}

class DiscoveredScreen {
  final String className;
  final String filePath;
  final String importUri;
  final List<CubitBinding> cubitBindings;

  const DiscoveredScreen({
    required this.className,
    required this.filePath,
    required this.importUri,
    required this.cubitBindings,
  });

  @override
  String toString() =>
      'DiscoveredScreen($className, ${cubitBindings.length} bindings)';
}
