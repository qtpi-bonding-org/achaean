import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import '../models/discovered_state.dart';

/// Scans a directory of Dart files to find freezed classes implementing
/// `IUiFlowState`, extracting their fields.
class StateInspector {
  /// Finds all freezed state classes implementing `IUiFlowState` in the
  /// given [libPath] directory.
  ///
  /// The [libPath] should be an absolute path to a `lib/` directory of a
  /// Dart/Flutter project that has resolved dependencies.
  Future<List<DiscoveredState>> findStates(String libPath) async {
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

    final states = <DiscoveredState>[];

    for (final filePath in dartFiles) {
      final context = collection.contextFor(filePath);
      final result = await context.currentSession.getResolvedLibrary(filePath);

      if (result is! ResolvedLibraryResult) continue;

      final library = result.element2;

      for (final cls in library.classes) {
        if (_isFreezedUiFlowState(cls)) {
          final discovered = _extractState(cls, filePath);
          if (discovered != null) {
            states.add(discovered);
          }
        }
      }
    }

    return states;
  }

  /// Checks if a class is annotated with `@freezed` and implements
  /// `IUiFlowState`.
  bool _isFreezedUiFlowState(ClassElement2 element) {
    final hasFreezed = element.metadata2.annotations.any((annotation) {
      final value = annotation.computeConstantValue();
      if (value == null) return false;
      final typeName = value.type?.element3?.name3;
      return typeName == 'Freezed' || typeName == 'freezed';
    });

    if (!hasFreezed) return false;

    final implementsUiFlow = element.allSupertypes
        .any((t) => t.element3.name3 == 'IUiFlowState');

    return implementsUiFlow;
  }

  /// Extracts state information from a freezed class element.
  DiscoveredState? _extractState(ClassElement2 element, String filePath) {
    // Find the unnamed factory constructor (name3 is 'new' for unnamed)
    final factories = element.constructors2.where(
      (c) => c.isFactory && c.name3 == 'new',
    );

    if (factories.isEmpty) return null;

    final params = factories.first.formalParameters;
    final fields = <DiscoveredField>[];

    for (final param in params) {
      fields.add(_extractField(param));
    }

    return DiscoveredState(
      className: element.name3 ?? '',
      filePath: filePath,
      importUri: filePath, // Will be refined in later tasks
      fields: fields,
    );
  }

  /// Extracts field information from a constructor parameter.
  DiscoveredField _extractField(FormalParameterElement param) {
    final type = param.type;
    final isNullable = type.nullabilitySuffix == NullabilitySuffix.question;

    final isList = _isList(type);
    final isMap = _isMap(type);

    String? listElementType;
    String? mapKeyType;
    String? mapValueType;

    if (isList && type is InterfaceType && type.typeArguments.isNotEmpty) {
      listElementType = type.typeArguments.first.getDisplayString();
    }

    if (isMap && type is InterfaceType && type.typeArguments.length >= 2) {
      mapKeyType = type.typeArguments[0].getDisplayString();
      mapValueType = type.typeArguments[1].getDisplayString();
    }

    // Extract default value from @Default annotation
    Object? defaultValue;
    for (final annotation in param.metadata2.annotations) {
      final value = annotation.computeConstantValue();
      if (value?.type?.element3?.name3 == 'Default') {
        final field = value?.getField('defaultValue');
        if (field != null) {
          defaultValue = field.toString();
        }
        break;
      }
    }

    return DiscoveredField(
      name: param.name3 ?? '',
      typeName: type.getDisplayString(),
      isNullable: isNullable,
      isList: isList,
      isMap: isMap,
      listElementType: listElementType,
      mapKeyType: mapKeyType,
      mapValueType: mapValueType,
      defaultValue: defaultValue,
    );
  }

  bool _isList(DartType type) {
    if (type is InterfaceType) {
      final name = type.element3.name3;
      return name == 'List' || name == 'ImmutableList';
    }
    return false;
  }

  bool _isMap(DartType type) {
    if (type is InterfaceType) {
      final name = type.element3.name3;
      return name == 'Map' || name == 'ImmutableMap';
    }
    return false;
  }
}
