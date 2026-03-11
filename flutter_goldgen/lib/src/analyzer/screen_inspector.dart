import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import '../models/discovered_screen.dart';

/// Scans Flutter widget files to find which screens use which cubits,
/// by looking for `BlocBuilder<CubitX, StateX>` and `BlocProvider<CubitX>`
/// type argument usages in the resolved AST.
class ScreenInspector {
  /// Finds all screens that reference BlocBuilder or BlocProvider in the
  /// given [libPath] directory.
  Future<List<DiscoveredScreen>> findScreens(String libPath) async {
    final absolutePath = p.canonicalize(libPath);

    // Collect all .dart files (excluding generated files)
    final dartFiles = Directory(absolutePath)
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) =>
            f.path.endsWith('.dart') &&
            !f.path.endsWith('.g.dart') &&
            !f.path.endsWith('.freezed.dart'))
        .map((f) => p.canonicalize(f.path))
        .toList();

    if (dartFiles.isEmpty) return [];

    final collection = AnalysisContextCollection(
      includedPaths: [absolutePath],
    );

    final screens = <DiscoveredScreen>[];

    for (final filePath in dartFiles) {
      final context = collection.contextFor(filePath);
      final result =
          await context.currentSession.getResolvedUnit(filePath);

      if (result is! ResolvedUnitResult) continue;

      final visitor = _ScreenVisitor();
      result.unit.accept(visitor);

      // Group bindings by the enclosing widget class
      for (final entry in visitor.classBindings.entries) {
        final className = entry.key;
        final bindings = entry.value;
        if (bindings.isNotEmpty) {
          screens.add(DiscoveredScreen(
            className: className,
            filePath: filePath,
            importUri: filePath,
            cubitBindings: bindings,
          ));
        }
      }
    }

    return screens;
  }
}

/// AST visitor that finds BlocBuilder and BlocProvider type references
/// within widget class declarations.
class _ScreenVisitor extends RecursiveAstVisitor<void> {
  /// Maps widget class name -> list of cubit bindings found within it.
  final Map<String, List<CubitBinding>> classBindings = {};

  String? _currentClassName;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    // Only process StatelessWidget and StatefulWidget subclasses,
    // as well as State<T> subclasses (which contain the build method
    // for StatefulWidgets).
    final element = node.declaredFragment?.element;
    if (element == null) {
      node.visitChildren(this);
      return;
    }

    final isWidget = _isWidgetClass(element);
    final stateWidgetName = _getStatefulWidgetName(element);

    if (isWidget) {
      _currentClassName = element.name3 ?? '';
      classBindings.putIfAbsent(_currentClassName!, () => []);
      node.visitChildren(this);
      _currentClassName = null;
    } else if (stateWidgetName != null) {
      // This is a State<SomeWidget> class — attribute bindings to SomeWidget
      _currentClassName = stateWidgetName;
      classBindings.putIfAbsent(_currentClassName!, () => []);
      node.visitChildren(this);
      _currentClassName = null;
    } else {
      node.visitChildren(this);
    }
  }

  @override
  void visitNamedType(NamedType node) {
    if (_currentClassName != null) {
      final name = node.name2.lexeme;

      if (name == 'BlocBuilder' || _isBlocBuilderSubtype(node)) {
        _extractBlocBuilderBinding(node);
      } else if (name == 'BlocProvider') {
        _extractBlocProviderBinding(node);
      }
    }
    node.visitChildren(this);
  }

  bool _isBlocBuilderSubtype(NamedType node) {
    // Check if the resolved type's element extends BlocBuilder
    final type = node.type;
    if (type is InterfaceType) {
      return type.allSupertypes.any(
        (t) => t.element3.name3 == 'BlocBuilder',
      );
    }
    return false;
  }

  void _extractBlocBuilderBinding(NamedType node) {
    final typeArgs = node.typeArguments?.arguments;
    if (typeArgs != null && typeArgs.length >= 2) {
      final cubitType = typeArgs[0];
      final stateType = typeArgs[1];

      final cubitName = _resolveTypeName(cubitType);
      final stateName = _resolveTypeName(stateType);

      if (cubitName != null && stateName != null) {
        final binding = CubitBinding(
          cubitClassName: cubitName,
          stateClassName: stateName,
        );
        // Avoid duplicates
        final bindings = classBindings[_currentClassName!]!;
        if (!bindings.any((b) =>
            b.cubitClassName == cubitName &&
            b.stateClassName == stateName)) {
          bindings.add(binding);
        }
      }
    }
  }

  void _extractBlocProviderBinding(NamedType node) {
    final typeArgs = node.typeArguments?.arguments;
    if (typeArgs != null && typeArgs.length >= 1) {
      final cubitType = typeArgs[0];
      final cubitName = _resolveTypeName(cubitType);

      if (cubitName != null) {
        // Try to find the state type from the cubit's supertype
        final stateName = _resolveStateFromCubit(cubitType);

        if (stateName != null) {
          final binding = CubitBinding(
            cubitClassName: cubitName,
            stateClassName: stateName,
          );
          final bindings = classBindings[_currentClassName!]!;
          if (!bindings.any((b) =>
              b.cubitClassName == cubitName &&
              b.stateClassName == stateName)) {
            bindings.add(binding);
          }
        }
      }
    }
  }

  String? _resolveTypeName(TypeAnnotation typeNode) {
    if (typeNode is NamedType) {
      return typeNode.name2.lexeme;
    }
    return null;
  }

  /// Given a type annotation for a Cubit, resolve its state type
  /// by looking at the supertype chain (e.g., Cubit<AgoraState>).
  String? _resolveStateFromCubit(TypeAnnotation typeNode) {
    if (typeNode is NamedType) {
      final type = typeNode.type;
      if (type is InterfaceType) {
        // Look through supertypes for Cubit<S> or Bloc<E, S>
        for (final supertype in type.allSupertypes) {
          final name = supertype.element3.name3;
          if (name == 'Cubit' && supertype.typeArguments.isNotEmpty) {
            final stateType = supertype.typeArguments.first;
            return stateType.element3?.name3;
          }
          if (name == 'Bloc' && supertype.typeArguments.length >= 2) {
            final stateType = supertype.typeArguments[1];
            return stateType.element3?.name3;
          }
        }
      }
    }
    return null;
  }

  /// Checks if the class is a StatelessWidget or StatefulWidget subclass.
  bool _isWidgetClass(ClassElement2 element) {
    return element.allSupertypes.any((t) {
      final name = t.element3.name3;
      return name == 'StatelessWidget' || name == 'StatefulWidget';
    });
  }

  /// If this class is a State<SomeWidget>, returns the widget class name.
  String? _getStatefulWidgetName(ClassElement2 element) {
    for (final supertype in element.allSupertypes) {
      if (supertype.element3.name3 == 'State' &&
          supertype.typeArguments.isNotEmpty) {
        final widgetType = supertype.typeArguments.first;
        return widgetType.element3?.name3;
      }
    }
    return null;
  }
}
