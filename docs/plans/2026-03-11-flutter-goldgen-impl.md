# flutter_goldgen Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a standalone Dart CLI that auto-generates golden tests for Flutter apps using the UiFlowStatus/freezed pattern.

**Architecture:** A CLI tool (`dart run flutter_goldgen`) that uses the Dart `analyzer` package to scan a Flutter project's source code. It finds freezed states implementing `IUiFlowState`, discovers which screens use which cubits via `BlocBuilder`/`BlocProvider`, recursively generates edge-case fixtures from field types, and outputs self-contained golden test files.

**Tech Stack:** Dart CLI, `analyzer` package for AST inspection, `args` package for CLI parsing, `dart_style` for formatting generated code, `path` for file path handling.

**Design doc:** `docs/plans/2026-03-11-flutter-goldgen-design.md`

---

### Task 1: Scaffold the package

**Files:**
- Create: `flutter_goldgen/pubspec.yaml`
- Create: `flutter_goldgen/bin/flutter_goldgen.dart`
- Create: `flutter_goldgen/lib/flutter_goldgen.dart`

**Step 1: Create pubspec.yaml**

```yaml
name: flutter_goldgen
description: Auto-generates golden tests for Flutter apps using UiFlowStatus/freezed patterns.
version: 0.0.1
publish_to: none

environment:
  sdk: ^3.8.0

dependencies:
  analyzer: ^7.4.1
  args: ^2.4.2
  dart_style: ^3.0.1
  path: ^1.9.1
  yaml: ^3.1.3

dev_dependencies:
  test: ^1.25.0
  mocktail: ^1.0.0
```

**Step 2: Create CLI entry point**

```dart
// bin/flutter_goldgen.dart
import 'package:flutter_goldgen/src/cli/cli_runner.dart';

Future<void> main(List<String> args) async {
  await CliRunner().run(args);
}
```

**Step 3: Create barrel export**

```dart
// lib/flutter_goldgen.dart
library flutter_goldgen;

export 'src/cli/cli_runner.dart';
```

**Step 4: Verify package resolves**

Run: `cd flutter_goldgen && dart pub get`
Expected: Dependencies resolve successfully.

**Step 5: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): scaffold flutter_goldgen package"
```

---

### Task 2: CLI runner with arg parsing

**Files:**
- Create: `flutter_goldgen/lib/src/cli/cli_runner.dart`

**Step 1: Write the test**

```dart
// flutter_goldgen/test/cli/cli_runner_test.dart
import 'package:flutter_goldgen/src/cli/cli_runner.dart';
import 'package:test/test.dart';

void main() {
  group('CliRunner', () {
    late CliRunner runner;

    setUp(() {
      runner = CliRunner();
    });

    test('parses --project-path argument', () {
      final config = runner.parseArgs(['--project-path', '/some/path']);
      expect(config.projectPath, '/some/path');
    });

    test('defaults project-path to current directory', () {
      final config = runner.parseArgs([]);
      expect(config.projectPath, '.');
    });

    test('parses --output argument', () {
      final config = runner.parseArgs(['--output', 'test/my_goldens']);
      expect(config.outputPath, 'test/my_goldens');
    });

    test('defaults output to test/goldens/generated', () {
      final config = runner.parseArgs([]);
      expect(config.outputPath, 'test/goldens/generated');
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_goldgen && dart test test/cli/cli_runner_test.dart`
Expected: FAIL — files don't exist yet.

**Step 3: Create CliConfig model**

```dart
// flutter_goldgen/lib/src/cli/cli_config.dart
class CliConfig {
  final String projectPath;
  final String outputPath;

  const CliConfig({
    required this.projectPath,
    required this.outputPath,
  });
}
```

**Step 4: Implement CliRunner**

```dart
// flutter_goldgen/lib/src/cli/cli_runner.dart
import 'dart:io';

import 'package:args/args.dart';

import 'cli_config.dart';

class CliRunner {
  CliConfig parseArgs(List<String> args) {
    final parser = ArgParser()
      ..addOption(
        'project-path',
        abbr: 'p',
        help: 'Path to the Flutter project to scan.',
        defaultsTo: '.',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output directory for generated test files.',
        defaultsTo: 'test/goldens/generated',
      );

    final results = parser.parse(args);

    return CliConfig(
      projectPath: results['project-path'] as String,
      outputPath: results['output'] as String,
    );
  }

  Future<void> run(List<String> args) async {
    final config = parseArgs(args);

    stdout.writeln('flutter_goldgen');
    stdout.writeln('  Project: ${config.projectPath}');
    stdout.writeln('  Output:  ${config.outputPath}');
    stdout.writeln('');

    // TODO: Wire up pipeline steps
    stdout.writeln('Done.');
  }
}
```

**Step 5: Run tests**

Run: `cd flutter_goldgen && dart test test/cli/cli_runner_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add CLI runner with arg parsing"
```

---

### Task 3: State inspector — find IUiFlowState classes

**Files:**
- Create: `flutter_goldgen/lib/src/analyzer/state_inspector.dart`
- Create: `flutter_goldgen/lib/src/models/discovered_state.dart`
- Test: `flutter_goldgen/test/analyzer/state_inspector_test.dart`

**Step 1: Create the model for discovered states**

```dart
// flutter_goldgen/lib/src/models/discovered_state.dart
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

  /// Whether this field is the standard `status` or `error` field from IUiFlowState.
  bool get isUiFlowField => name == 'status' || name == 'error';
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

  /// Data fields only (excludes status and error).
  List<DiscoveredField> get dataFields =>
      fields.where((f) => !f.isUiFlowField).toList();
}
```

**Step 2: Write test with a real Dart source file as fixture**

Create a test fixture file:

```dart
// flutter_goldgen/test/fixtures/fake_state.dart
// This file is parsed by the analyzer in tests, not compiled.
import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fake_state.freezed.dart';

@freezed
abstract class FakeState with _$FakeState implements IUiFlowState {
  const FakeState._();
  const factory FakeState({
    @Default(UiFlowStatus.idle) UiFlowStatus status,
    Object? error,
    @Default([]) List<String> items,
    String? title,
    @Default(0) int count,
  }) = _FakeState;

  @override
  bool get isIdle => status == UiFlowStatus.idle;
  @override
  bool get isLoading => status == UiFlowStatus.loading;
  @override
  bool get isSuccess => status == UiFlowStatus.success;
  @override
  bool get isFailure => status == UiFlowStatus.failure;
  @override
  bool get hasError => error != null;
}
```

```dart
// flutter_goldgen/test/analyzer/state_inspector_test.dart
import 'package:flutter_goldgen/src/analyzer/state_inspector.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('StateInspector', () {
    late StateInspector inspector;

    setUp(() {
      inspector = StateInspector();
    });

    test('finds classes implementing IUiFlowState', () async {
      final fixturePath = p.absolute('test/fixtures');
      final states = await inspector.findStates(fixturePath);

      expect(states, hasLength(1));
      expect(states.first.className, 'FakeState');
    });

    test('extracts data fields excluding status and error', () async {
      final fixturePath = p.absolute('test/fixtures');
      final states = await inspector.findStates(fixturePath);
      final dataFields = states.first.dataFields;

      expect(dataFields, hasLength(3));
      expect(dataFields.map((f) => f.name), containsAll(['items', 'title', 'count']));
    });

    test('detects field types correctly', () async {
      final fixturePath = p.absolute('test/fixtures');
      final states = await inspector.findStates(fixturePath);
      final fields = {for (final f in states.first.dataFields) f.name: f};

      expect(fields['items']!.isList, true);
      expect(fields['items']!.listElementType, 'String');
      expect(fields['title']!.isNullable, true);
      expect(fields['count']!.typeName, 'int');
    });
  });
}
```

**Step 3: Run test to verify it fails**

Run: `cd flutter_goldgen && dart test test/analyzer/state_inspector_test.dart`
Expected: FAIL — `StateInspector` doesn't exist yet.

**Step 4: Implement StateInspector**

```dart
// flutter_goldgen/lib/src/analyzer/state_inspector.dart
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as p;

import '../models/discovered_state.dart';

class StateInspector {
  /// Scan [directory] for all freezed classes implementing IUiFlowState.
  Future<List<DiscoveredState>> findStates(String directory) async {
    final absolutePath = p.absolute(directory);
    final dartFiles = _findDartFiles(absolutePath);

    if (dartFiles.isEmpty) return [];

    final collection = AnalysisContextCollection(
      includedPaths: [absolutePath],
    );

    final states = <DiscoveredState>[];

    for (final context in collection.contexts) {
      for (final filePath in dartFiles) {
        final result = await context.currentSession.getResolvedUnit(filePath);
        if (result is! ResolvedUnitResult) continue;

        final visitor = _UiFlowStateVisitor(filePath);
        result.unit.visitChildren(visitor);
        states.addAll(visitor.discoveredStates);
      }
    }

    return states;
  }

  List<String> _findDartFiles(String directory) {
    final dir = Directory(directory);
    if (!dir.existsSync()) return [];

    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .where((f) => !f.path.endsWith('.freezed.dart'))
        .where((f) => !f.path.endsWith('.g.dart'))
        .map((f) => p.normalize(f.path))
        .toList();
  }
}

class _UiFlowStateVisitor extends RecursiveAstVisitor<void> {
  final String filePath;
  final List<DiscoveredState> discoveredStates = [];

  _UiFlowStateVisitor(this.filePath);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final element = node.declaredElement;
    if (element == null) return;

    // Check if this class implements IUiFlowState
    final implementsUiFlow = element.allSupertypes.any(
      (t) => t.element.name == 'IUiFlowState',
    );
    if (!implementsUiFlow) return;

    // Check if it's a freezed class (has @freezed annotation)
    final isFreezed = element.metadata.any(
      (m) => m.element?.enclosingElement?.name == 'freezed' ||
             m.computeConstantValue()?.type?.element?.name == 'Freezed',
    );
    if (!isFreezed) return;

    // Find the factory constructor to extract fields
    final fields = _extractFields(element);

    discoveredStates.add(DiscoveredState(
      className: element.name,
      filePath: filePath,
      importUri: _computeImportUri(filePath),
      fields: fields,
    ));

    super.visitClassDeclaration(node);
  }

  List<DiscoveredField> _extractFields(ClassElement element) {
    // Find the unnamed factory constructor (freezed pattern)
    final factory = element.constructors.firstWhere(
      (c) => c.isFactory && c.name.isEmpty,
      orElse: () => element.constructors.first,
    );

    return factory.parameters.map((param) {
      final type = param.type;
      return DiscoveredField(
        name: param.name,
        typeName: type.getDisplayString(),
        isNullable: type.nullabilitySuffix != NullabilitySuffix.none,
        isList: _isList(type),
        isMap: _isMap(type),
        listElementType: _listElementType(type),
        mapKeyType: _mapKeyType(type),
        mapValueType: _mapValueType(type),
      );
    }).toList();
  }

  bool _isList(DartType type) =>
      type.isDartCoreList ||
      (type is InterfaceType && type.element.name == 'List');

  bool _isMap(DartType type) =>
      type.isDartCoreMap ||
      (type is InterfaceType && type.element.name == 'Map');

  String? _listElementType(DartType type) {
    if (type is InterfaceType && _isList(type) && type.typeArguments.isNotEmpty) {
      return type.typeArguments.first.getDisplayString();
    }
    return null;
  }

  String? _mapKeyType(DartType type) {
    if (type is InterfaceType && _isMap(type) && type.typeArguments.length >= 2) {
      return type.typeArguments[0].getDisplayString();
    }
    return null;
  }

  String? _mapValueType(DartType type) {
    if (type is InterfaceType && _isMap(type) && type.typeArguments.length >= 2) {
      return type.typeArguments[1].getDisplayString();
    }
    return null;
  }

  String _computeImportUri(String filePath) {
    // Simplified — will need adjustment based on package resolution
    return filePath;
  }
}
```

**Step 5: Run tests**

Run: `cd flutter_goldgen && dart test test/analyzer/state_inspector_test.dart`
Expected: PASS

Note: The test fixture may need adjustment — the analyzer needs to resolve `cubit_ui_flow` and `freezed_annotation` imports. If resolution fails, create a simpler fixture that uses a local interface definition instead of the real package import. Adjust the test accordingly.

**Step 6: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add state inspector to find IUiFlowState classes"
```

---

### Task 4: Screen inspector — discover cubit-screen mappings

**Files:**
- Create: `flutter_goldgen/lib/src/analyzer/screen_inspector.dart`
- Create: `flutter_goldgen/lib/src/models/discovered_screen.dart`
- Test: `flutter_goldgen/test/analyzer/screen_inspector_test.dart`

**Step 1: Create the model**

```dart
// flutter_goldgen/lib/src/models/discovered_screen.dart
class CubitBinding {
  final String cubitClassName;
  final String stateClassName;

  const CubitBinding({
    required this.cubitClassName,
    required this.stateClassName,
  });
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
}
```

**Step 2: Write the test**

Create a test fixture:

```dart
// flutter_goldgen/test/fixtures/fake_screen.dart
// Parsed by analyzer, not compiled.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Fake types for analysis
class FakeCubit extends Cubit<FakeState> {
  FakeCubit() : super(const FakeState());
}

class FakeState {
  const FakeState();
}

class FakeScreen extends StatelessWidget {
  const FakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FakeCubit>(
      create: (_) => FakeCubit(),
      child: BlocBuilder<FakeCubit, FakeState>(
        builder: (context, state) => const Text('hello'),
      ),
    );
  }
}
```

```dart
// flutter_goldgen/test/analyzer/screen_inspector_test.dart
import 'package:flutter_goldgen/src/analyzer/screen_inspector.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('ScreenInspector', () {
    late ScreenInspector inspector;

    setUp(() {
      inspector = ScreenInspector();
    });

    test('finds screens with BlocBuilder usage', () async {
      final fixturePath = p.absolute('test/fixtures');
      final screens = await inspector.findScreens(fixturePath);

      expect(screens, hasLength(1));
      expect(screens.first.className, 'FakeScreen');
    });

    test('extracts cubit-state bindings from BlocBuilder type args', () async {
      final fixturePath = p.absolute('test/fixtures');
      final screens = await inspector.findScreens(fixturePath);
      final bindings = screens.first.cubitBindings;

      expect(bindings, hasLength(1));
      expect(bindings.first.cubitClassName, 'FakeCubit');
      expect(bindings.first.stateClassName, 'FakeState');
    });
  });
}
```

**Step 3: Run test to verify it fails**

Run: `cd flutter_goldgen && dart test test/analyzer/screen_inspector_test.dart`
Expected: FAIL

**Step 4: Implement ScreenInspector**

The inspector scans for `BlocBuilder<X, Y>` and `BlocProvider<X>` type argument usages in widget classes. It uses the same `AnalysisContextCollection` approach as the state inspector but looks for generic type invocations instead of interface implementations.

Key approach: visit `TypeName` nodes in the AST, look for `BlocBuilder` and `BlocProvider` with 2 type arguments, extract the cubit and state class names.

**Step 5: Run tests**

Run: `cd flutter_goldgen && dart test test/analyzer/screen_inspector_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add screen inspector to discover cubit-screen mappings"
```

---

### Task 5: Field inspector — recursive type introspection

**Files:**
- Create: `flutter_goldgen/lib/src/analyzer/field_inspector.dart`
- Create: `flutter_goldgen/lib/src/models/type_info.dart`
- Test: `flutter_goldgen/test/analyzer/field_inspector_test.dart`

**Step 1: Create TypeInfo model for recursive type representation**

```dart
// flutter_goldgen/lib/src/models/type_info.dart

/// Represents a fully resolved type with enough info to generate fixtures.
class TypeInfo {
  final String name;
  final TypeKind kind;
  final bool isNullable;
  final List<TypeInfo> typeArguments; // for generics (List<X>, Map<K,V>)
  final List<ConstructorParam>? constructorParams; // for custom models
  final List<String>? enumValues; // for enums

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
  object, // fallback for unknown types
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
```

**Step 2: Write tests**

```dart
// flutter_goldgen/test/analyzer/field_inspector_test.dart
import 'package:flutter_goldgen/src/analyzer/field_inspector.dart';
import 'package:flutter_goldgen/src/models/type_info.dart';
import 'package:test/test.dart';

void main() {
  group('FieldInspector', () {
    late FieldInspector inspector;

    setUp(() {
      inspector = FieldInspector();
    });

    test('resolves String type', () {
      final info = inspector.resolveType('String', isNullable: false);
      expect(info.kind, TypeKind.string);
    });

    test('resolves nullable type', () {
      final info = inspector.resolveType('String', isNullable: true);
      expect(info.isNullable, true);
    });

    test('resolves List<String>', () {
      final info = inspector.resolveType('List<String>', isNullable: false);
      expect(info.kind, TypeKind.list);
      expect(info.typeArguments.first.kind, TypeKind.string);
    });

    test('resolves Map<String, int>', () {
      final info = inspector.resolveType('Map<String, int>', isNullable: false);
      expect(info.kind, TypeKind.map);
      expect(info.typeArguments[0].kind, TypeKind.string);
      expect(info.typeArguments[1].kind, TypeKind.int);
    });
  });
}
```

**Step 3: Implement FieldInspector**

Resolves type strings to `TypeInfo` objects. For primitive types, uses a lookup table. For custom models, uses the analyzer to inspect the model's constructor and recurse. Depth-limited to prevent circular reference issues (default max depth: 3).

**Step 4: Run tests, verify pass**

**Step 5: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add field inspector for recursive type introspection"
```

---

### Task 6: Fixture generator — generate edge case values per type

**Files:**
- Create: `flutter_goldgen/lib/src/generator/fixture_generator.dart`
- Test: `flutter_goldgen/test/generator/fixture_generator_test.dart`

**Step 1: Write tests**

```dart
// flutter_goldgen/test/generator/fixture_generator_test.dart
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
      expect(values.any((v) => v.contains('* 200')), true);
    });

    test('generates nullable String edge cases including null', () {
      final type = TypeInfo(name: 'String', kind: TypeKind.string, isNullable: true);
      final values = generator.generateValues(type);

      expect(values, contains('null'));
    });

    test('generates List edge cases', () {
      final type = TypeInfo(
        name: 'List<String>',
        kind: TypeKind.list,
        typeArguments: [TypeInfo(name: 'String', kind: TypeKind.string)],
      );
      final values = generator.generateValues(type);

      expect(values, contains('[]'));
      expect(values.any((v) => v.contains('List.filled')), true);
    });

    test('generates int edge cases', () {
      final type = TypeInfo(name: 'int', kind: TypeKind.int);
      final values = generator.generateValues(type);

      expect(values, contains('0'));
      expect(values, contains('1'));
      expect(values, contains('999999'));
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

    test('generates normal default for baseline', () {
      final type = TypeInfo(name: 'String', kind: TypeKind.string);
      final normal = generator.generateNormal(type);

      expect(normal, "'Test string'");
    });
  });
}
```

**Step 2: Run tests, verify fail**

**Step 3: Implement FixtureGenerator**

```dart
// flutter_goldgen/lib/src/generator/fixture_generator.dart
import '../models/type_info.dart';

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
        final elementType = type.typeArguments.isNotEmpty
            ? type.typeArguments.first
            : null;
        final elementNormal = elementType != null
            ? generateNormal(elementType)
            : "'item'";
        values.addAll([
          '[]',
          '[$elementNormal]',
          'List.filled(50, $elementNormal)',
        ]);
      case TypeKind.map:
        final keyNormal = type.typeArguments.isNotEmpty
            ? generateNormal(type.typeArguments[0])
            : "'key'";
        final valNormal = type.typeArguments.length >= 2
            ? generateNormal(type.typeArguments[1])
            : "'value'";
        values.addAll([
          '{}',
          '{$keyNormal: $valNormal}',
          '{for (var i = 0; i < 20; i++) \'\$i\': $valNormal}',
        ]);
      case TypeKind.enumType:
        for (final v in type.enumValues ?? []) {
          values.add('${type.name}.$v');
        }
      case TypeKind.customModel:
        final normalConstruction = _constructModel(type);
        values.add(normalConstruction);
      case TypeKind.object:
        values.add("'unknown'");
    }

    return values;
  }

  /// Generate a single "normal" value for use as baseline.
  String generateNormal(TypeInfo type) {
    if (type.isNullable) {
      // For baseline, use a non-null value
      return _nonNullNormal(type);
    }
    return _nonNullNormal(type);
  }

  String _nonNullNormal(TypeInfo type) {
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
      TypeKind.customModel => _constructModel(type),
      TypeKind.object => "'test'",
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

  String _constructModel(TypeInfo type) {
    if (type.constructorParams == null || type.constructorParams!.isEmpty) {
      return '${type.name}()';
    }

    final params = type.constructorParams!
        .where((p) => p.isRequired && p.defaultValueCode == null)
        .map((p) => '${p.name}: ${generateNormal(p.type)}')
        .join(', ');

    return '${type.name}($params)';
  }
}
```

**Step 4: Run tests, verify pass**

**Step 5: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add fixture generator for edge case values"
```

---

### Task 7: Golden test generator — generate test files

**Files:**
- Create: `flutter_goldgen/lib/src/generator/golden_test_generator.dart`
- Test: `flutter_goldgen/test/generator/golden_test_generator_test.dart`

**Step 1: Write tests**

```dart
// flutter_goldgen/test/generator/golden_test_generator_test.dart
import 'package:flutter_goldgen/src/generator/golden_test_generator.dart';
import 'package:flutter_goldgen/src/models/discovered_screen.dart';
import 'package:flutter_goldgen/src/models/discovered_state.dart';
import 'package:test/test.dart';

void main() {
  group('GoldenTestGenerator', () {
    late GoldenTestGenerator generator;

    setUp(() {
      generator = GoldenTestGenerator(
        sizes: [('phoneSE', 375, 812)],
        locales: ['en'],
      );
    });

    test('generates fixture file for a state', () {
      final state = DiscoveredState(
        className: 'FakeState',
        filePath: 'lib/features/fake/cubit/fake_state.dart',
        importUri: 'package:my_app/features/fake/cubit/fake_state.dart',
        fields: [
          DiscoveredField(name: 'status', typeName: 'UiFlowStatus'),
          DiscoveredField(name: 'error', typeName: 'Object', isNullable: true),
          DiscoveredField(name: 'title', typeName: 'String', isNullable: true),
          DiscoveredField(name: 'count', typeName: 'int'),
        ],
      );

      final output = generator.generateFixtureFile(state);

      expect(output, contains('class FakeStateFixtures'));
      expect(output, contains('GENERATED CODE'));
    });

    test('generates golden test file for a screen', () {
      final screen = DiscoveredScreen(
        className: 'FakeScreen',
        filePath: 'lib/features/fake/widgets/fake_screen.dart',
        importUri: 'package:my_app/features/fake/widgets/fake_screen.dart',
        cubitBindings: [
          CubitBinding(cubitClassName: 'FakeCubit', stateClassName: 'FakeState'),
        ],
      );

      final states = {
        'FakeState': DiscoveredState(
          className: 'FakeState',
          filePath: 'lib/features/fake/cubit/fake_state.dart',
          importUri: 'package:my_app/features/fake/cubit/fake_state.dart',
          fields: [
            DiscoveredField(name: 'status', typeName: 'UiFlowStatus'),
            DiscoveredField(name: 'error', typeName: 'Object', isNullable: true),
            DiscoveredField(name: 'title', typeName: 'String', isNullable: true),
          ],
        ),
      };

      final output = generator.generateTestFile(screen, states);

      expect(output, contains('testWidgets'));
      expect(output, contains('matchesGoldenFile'));
      expect(output, contains('FakeScreen'));
      expect(output, contains('MockFakeCubit'));
    });
  });
}
```

**Step 2: Run tests, verify fail**

**Step 3: Implement GoldenTestGenerator**

This is the main code generation class. It produces two kinds of files:

1. **Fixture files** — one per state class, containing a class with named fixture instances varying one field at a time
2. **Test files** — one per screen, containing `testWidgets` with `matchesGoldenFile` for each combo of status × fixture × size × locale

The generated test files are self-contained: they import `flutter_test`, `mocktail`, the screen widget, the state class, and the generated fixture file. They inline the mock cubit class, the `MaterialApp` wrapper, and all setup.

Key method: `generateTestFile(DiscoveredScreen, Map<String, DiscoveredState>)` produces a complete Dart test file as a `String`, using `StringBuffer` to build it up.

The vary-one-at-a-time strategy: for each cubit on the screen, iterate through its fixtures and statuses while holding all other cubits at their default state.

**Step 4: Run tests, verify pass**

**Step 5: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add golden test generator for fixture and test files"
```

---

### Task 8: Wire up the CLI pipeline

**Files:**
- Modify: `flutter_goldgen/lib/src/cli/cli_runner.dart`
- Test: `flutter_goldgen/test/cli/cli_runner_integration_test.dart`

**Step 1: Write integration test**

```dart
// flutter_goldgen/test/cli/cli_runner_integration_test.dart
import 'dart:io';

import 'package:flutter_goldgen/src/cli/cli_runner.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('CliRunner integration', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('goldgen_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('generates output files from fixture project', () async {
      final runner = CliRunner();
      final fixturePath = p.absolute('test/fixtures');
      final outputPath = p.join(tempDir.path, 'goldens');

      await runner.run([
        '--project-path', fixturePath,
        '--output', outputPath,
      ]);

      final outputDir = Directory(outputPath);
      expect(outputDir.existsSync(), true);

      final generatedFiles = outputDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList();

      expect(generatedFiles, isNotEmpty);
    });
  });
}
```

**Step 2: Update CliRunner.run() to wire up the pipeline**

```dart
Future<void> run(List<String> args) async {
  final config = parseArgs(args);

  stdout.writeln('flutter_goldgen');
  stdout.writeln('  Project: ${config.projectPath}');
  stdout.writeln('  Output:  ${config.outputPath}');
  stdout.writeln('');

  // 1. Find states
  stdout.writeln('Scanning for IUiFlowState classes...');
  final stateInspector = StateInspector();
  final states = await stateInspector.findStates(config.projectPath);
  stdout.writeln('  Found ${states.length} states.');

  // 2. Find screens
  stdout.writeln('Scanning for screens with BlocBuilder...');
  final screenInspector = ScreenInspector();
  final screens = await screenInspector.findScreens(config.projectPath);
  stdout.writeln('  Found ${screens.length} screens.');

  // 3. Generate fixtures + tests
  stdout.writeln('Generating fixtures and golden tests...');
  final stateMap = {for (final s in states) s.className: s};
  final generator = GoldenTestGenerator(
    sizes: [('phoneSE', 375, 812)], // TODO: read from config file
    locales: ['en'],                 // TODO: read from config file
  );

  final outputDir = Directory(config.outputPath);
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Generate fixture files
  final fixturesDir = Directory(p.join(config.outputPath, 'fixtures'));
  fixturesDir.createSync(recursive: true);

  for (final state in states) {
    final content = generator.generateFixtureFile(state);
    final fileName = _toSnakeCase(state.className) + '_fixtures.dart';
    File(p.join(fixturesDir.path, fileName)).writeAsStringSync(content);
  }

  // Generate test files
  final testsDir = Directory(p.join(config.outputPath, 'tests'));
  testsDir.createSync(recursive: true);

  for (final screen in screens) {
    final content = generator.generateTestFile(screen, stateMap);
    final fileName = _toSnakeCase(screen.className) + '_golden_test.dart';
    File(p.join(testsDir.path, fileName)).writeAsStringSync(content);
  }

  stdout.writeln('');
  stdout.writeln('Generated ${states.length} fixture files.');
  stdout.writeln('Generated ${screens.length} golden test files.');
  stdout.writeln('');
  stdout.writeln('Next: flutter test --update-goldens ${config.outputPath}/tests/');
}
```

**Step 3: Run integration test**

Run: `cd flutter_goldgen && dart test test/cli/cli_runner_integration_test.dart`
Expected: PASS

**Step 4: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): wire up CLI pipeline end-to-end"
```

---

### Task 9: Config file reader

**Files:**
- Create: `flutter_goldgen/lib/src/config/config_reader.dart`
- Test: `flutter_goldgen/test/config/config_reader_test.dart`

**Step 1: Design the config format**

Since the config file references app types (`appTheme`, localization delegates) that can't be imported by the CLI tool directly, use a YAML config file instead of Dart:

```yaml
# goldgen.yaml
sizes:
  - name: phoneSE
    width: 375
    height: 812
  - name: phoneMax
    width: 430
    height: 932
  - name: tablet
    width: 768
    height: 1024

locales:
  - en
  - de

theme_import: "package:my_app/design_system/theme/app_theme.dart"
theme_variable: appTheme

l10n_delegates_import: "package:my_app/l10n/app_localizations.dart"
l10n_delegates_variable: AppLocalizations.localizationsDelegates
```

**Step 2: Write tests**

```dart
// flutter_goldgen/test/config/config_reader_test.dart
import 'dart:io';

import 'package:flutter_goldgen/src/config/config_reader.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('ConfigReader', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('goldgen_config_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('reads sizes from yaml', () {
      final configFile = File(p.join(tempDir.path, 'goldgen.yaml'));
      configFile.writeAsStringSync('''
sizes:
  - name: phoneSE
    width: 375
    height: 812
locales:
  - en
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
''');

      final config = ConfigReader().read(configFile.path);

      expect(config.sizes, hasLength(1));
      expect(config.sizes.first.name, 'phoneSE');
      expect(config.sizes.first.width, 375);
      expect(config.sizes.first.height, 812);
    });

    test('reads locales from yaml', () {
      final configFile = File(p.join(tempDir.path, 'goldgen.yaml'));
      configFile.writeAsStringSync('''
sizes:
  - name: phoneSE
    width: 375
    height: 812
locales:
  - en
  - de
  - ja
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
''');

      final config = ConfigReader().read(configFile.path);

      expect(config.locales, ['en', 'de', 'ja']);
    });
  });
}
```

**Step 3: Implement ConfigReader**

Parse the YAML file into a config model with sizes, locales, theme import/variable, and l10n delegates import/variable.

**Step 4: Wire ConfigReader into CliRunner**

Replace the hardcoded sizes/locales in `CliRunner.run()` with values read from `goldgen.yaml`.

**Step 5: Run tests, verify pass**

**Step 6: Commit**

```bash
git add flutter_goldgen/
git commit -m "feat(goldgen): add YAML config reader for sizes, locales, theme"
```

---

### Task 10: End-to-end test against achaean_flutter

**Files:**
- Test: `flutter_goldgen/test/e2e/achaean_e2e_test.dart`

**Step 1: Write e2e test**

```dart
// flutter_goldgen/test/e2e/achaean_e2e_test.dart
import 'dart:io';

import 'package:flutter_goldgen/src/cli/cli_runner.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

void main() {
  group('E2E: achaean_flutter', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('goldgen_e2e_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('generates golden tests for achaean_flutter', () async {
      final runner = CliRunner();
      final projectPath = p.normalize(p.absolute('../../achaean_flutter'));
      final outputPath = p.join(tempDir.path, 'goldens');

      await runner.run([
        '--project-path', projectPath,
        '--output', outputPath,
      ]);

      final fixtureFiles = Directory(p.join(outputPath, 'fixtures'))
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList();

      final testFiles = Directory(p.join(outputPath, 'tests'))
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList();

      // achaean_flutter has 13 states and multiple screens
      expect(fixtureFiles.length, greaterThanOrEqualTo(5));
      expect(testFiles.length, greaterThanOrEqualTo(3));

      // Verify generated files are valid Dart (no syntax errors)
      for (final file in [...fixtureFiles, ...testFiles]) {
        final content = file.readAsStringSync();
        expect(content, contains('// GENERATED CODE'));
      }
    });
  }, timeout: Timeout(Duration(minutes: 2)));
}
```

**Step 2: Run e2e test**

Run: `cd flutter_goldgen && dart test test/e2e/achaean_e2e_test.dart --timeout 120s`
Expected: PASS — generates fixture + test files for all discovered states and screens.

**Step 3: Fix any issues found**

The analyzer may have trouble resolving types from packages not in flutter_goldgen's own dependency tree. Fix by using the project's own analysis context (point the analyzer at the project's root, not the fixture directory).

**Step 4: Commit**

```bash
git add flutter_goldgen/
git commit -m "test(goldgen): add e2e test against achaean_flutter"
```

---

### Task 11: Polish and document

**Files:**
- Modify: `flutter_goldgen/bin/flutter_goldgen.dart`
- Create: `flutter_goldgen/README.md`

**Step 1: Add --help flag**

Add a `--help` flag to the CLI that prints usage information.

**Step 2: Add error handling**

Wrap the CLI runner in try/catch with helpful error messages for common failures (no goldgen.yaml found, no states found, analyzer resolution errors).

**Step 3: Write README**

Document:
- What flutter_goldgen does
- How to add it as a dev dependency
- How to create `goldgen.yaml`
- How to run it
- How to view results
- How to reuse fixtures in unit tests

**Step 4: Commit**

```bash
git add flutter_goldgen/
git commit -m "docs(goldgen): add README and CLI help"
```

---

Plan complete and saved to `docs/plans/2026-03-11-flutter-goldgen-impl.md`. Two execution options:

**1. Subagent-Driven (this session)** — I dispatch a fresh subagent per task, review between tasks, fast iteration

**2. Parallel Session (separate)** — Open new session with executing-plans, batch execution with checkpoints

Which approach?