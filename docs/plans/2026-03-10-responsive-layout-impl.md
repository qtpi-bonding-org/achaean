# Flutter Responsive Layout Package Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build a declarative responsive layout package with three group types (row, col, grid) that adapt to available space, using a single unit system based on a pluggable `baseSpacing`.

**Architecture:** Pure Flutter package, no external dependencies. One `InheritedWidget` for config, three `StatelessWidget` group types that use `LayoutBuilder` internally, one abstract interface for app-provided spacing widgets. All numeric parameters are multiples of `baseSpacing`.

**Tech Stack:** Flutter, `flutter_test` for widget testing

---

## Task 1: Package scaffold

Create the package directory, pubspec, analysis options, barrel export, and add to workspace.

**Files:**
- Create: `flutter_responsive_layout/pubspec.yaml`
- Create: `flutter_responsive_layout/analysis_options.yaml`
- Create: `flutter_responsive_layout/lib/flutter_responsive_layout.dart`
- Modify: `pubspec.yaml` (root workspace)

**Step 1: Create package directory**

Run: `mkdir -p flutter_responsive_layout/lib/src flutter_responsive_layout/test`

**Step 2: Create pubspec.yaml**

Create `flutter_responsive_layout/pubspec.yaml`:

```yaml
name: flutter_responsive_layout
description: Declarative responsive layout system. Three group types (row, col, grid) that adapt to available space.
version: 0.1.0
publish_to: 'none'

resolution: workspace

environment:
  sdk: '^3.8.0'
  flutter: '>=3.32.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: '>=3.0.0 <7.0.0'
```

**Step 3: Create analysis_options.yaml**

Create `flutter_responsive_layout/analysis_options.yaml`:

```yaml
include: package:flutter_lints/flutter.yaml
```

**Step 4: Create barrel export**

Create `flutter_responsive_layout/lib/flutter_responsive_layout.dart`:

```dart
library flutter_responsive_layout;

export 'src/config/responsive_layout_config.dart';
export 'src/groups/layout_group.dart';
export 'src/spacing/responsive_space.dart';
```

**Step 5: Add to workspace**

In root `pubspec.yaml`, add `flutter_responsive_layout` to the `workspace:` list.

**Step 6: Verify**

Run: `cd flutter_responsive_layout && flutter pub get`
Expected: Resolves successfully.

**Step 7: Commit**

```bash
git add flutter_responsive_layout/ pubspec.yaml
git commit -m "feat: scaffold flutter_responsive_layout package"
```

---

## Task 2: ResponsiveSpace interface

The interface that app-provided spacing widgets implement. The package recognizes these between children and uses them as spacing constraints.

**Files:**
- Create: `flutter_responsive_layout/lib/src/spacing/responsive_space.dart`
- Create: `flutter_responsive_layout/test/responsive_space_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/responsive_space_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

/// Test implementation of ResponsiveSpace
class TestHSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;

  const TestHSpace(this.size, {super.key});

  @override
  Axis get axis => Axis.horizontal;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}

class TestVSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;

  const TestVSpace(this.size, {super.key});

  @override
  Axis get axis => Axis.vertical;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

void main() {
  group('ResponsiveSpace', () {
    test('horizontal space has correct axis and size', () {
      const space = TestHSpace(3);
      expect(space.axis, Axis.horizontal);
      expect(space.size, 3);
    });

    test('vertical space has correct axis and size', () {
      const space = TestVSpace(2.5);
      expect(space.axis, Axis.vertical);
      expect(space.size, 2.5);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/responsive_space_test.dart`
Expected: FAIL — `ResponsiveSpace` not found.

**Step 3: Implement ResponsiveSpace**

Create `flutter_responsive_layout/lib/src/spacing/responsive_space.dart`:

```dart
import 'package:flutter/widgets.dart';

/// Interface for app-provided spacing widgets.
///
/// Implement this on your `HSpace` and `VSpace` widgets so the layout
/// system recognizes them as spacing constraints between children.
///
/// [size] is in multiples of `baseSpacing` — a size of 3 means
/// `3 × baseSpacing` pixels.
///
/// [axis] declares whether this spacing applies in horizontal or
/// vertical layout mode. In a row that's currently horizontal, only
/// [Axis.horizontal] spaces apply. If it collapses to vertical, only
/// [Axis.vertical] spaces apply.
abstract class ResponsiveSpace implements Widget {
  /// Spacing amount in baseSpacing multiples.
  double get size;

  /// Which layout axis this spacing applies to.
  Axis get axis;
}
```

**Step 4: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/responsive_space_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add ResponsiveSpace interface"
```

---

## Task 3: ResponsiveLayoutConfig

InheritedWidget that provides `baseSpacing` to all descendant layout groups.

**Files:**
- Create: `flutter_responsive_layout/lib/src/config/responsive_layout_config.dart`
- Create: `flutter_responsive_layout/test/responsive_layout_config_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/responsive_layout_config_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

void main() {
  group('ResponsiveLayoutConfig', () {
    testWidgets('provides baseSpacing to descendants', (tester) async {
      double? capturedSpacing;

      await tester.pumpWidget(
        ResponsiveLayoutConfig(
          baseSpacing: 12.0,
          child: Builder(
            builder: (context) {
              capturedSpacing = ResponsiveLayoutConfig.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedSpacing, 12.0);
    });

    testWidgets('defaults to 8.0 when no ancestor config exists', (tester) async {
      double? capturedSpacing;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            capturedSpacing = ResponsiveLayoutConfig.of(context);
            return const SizedBox();
          },
        ),
      );

      expect(capturedSpacing, 8.0);
    });

    testWidgets('nearest ancestor wins when nested', (tester) async {
      double? capturedSpacing;

      await tester.pumpWidget(
        ResponsiveLayoutConfig(
          baseSpacing: 10.0,
          child: ResponsiveLayoutConfig(
            baseSpacing: 16.0,
            child: Builder(
              builder: (context) {
                capturedSpacing = ResponsiveLayoutConfig.of(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(capturedSpacing, 16.0);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/responsive_layout_config_test.dart`
Expected: FAIL — `ResponsiveLayoutConfig` not found.

**Step 3: Implement ResponsiveLayoutConfig**

Create `flutter_responsive_layout/lib/src/config/responsive_layout_config.dart`:

```dart
import 'package:flutter/widgets.dart';

/// Provides [baseSpacing] to all descendant layout groups.
///
/// Place at the app level (above `MaterialApp` or equivalent):
///
/// ```dart
/// ResponsiveLayoutConfig(
///   baseSpacing: AppSizes.space,  // your scaled base unit
///   child: MaterialApp(...),
/// )
/// ```
///
/// All numeric parameters in layout groups are multiples of [baseSpacing].
class ResponsiveLayoutConfig extends InheritedWidget {
  /// The base spacing unit in logical pixels.
  ///
  /// All spacing and size parameters in layout groups are
  /// multiplied by this value. Typically sourced from your
  /// design system's base spacing (e.g., `AppSizes.space`).
  final double baseSpacing;

  const ResponsiveLayoutConfig({
    super.key,
    required this.baseSpacing,
    required super.child,
  });

  /// Returns the [baseSpacing] from the nearest ancestor config,
  /// or `8.0` if no config exists in the tree.
  static double of(BuildContext context) {
    final config =
        context.dependOnInheritedWidgetOfExactType<ResponsiveLayoutConfig>();
    return config?.baseSpacing ?? 8.0;
  }

  @override
  bool updateShouldNotify(ResponsiveLayoutConfig oldWidget) {
    return baseSpacing != oldWidget.baseSpacing;
  }
}
```

**Step 4: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/responsive_layout_config_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add ResponsiveLayoutConfig InheritedWidget"
```

---

## Task 4: Spacing helpers (internal)

Internal utility that extracts `ResponsiveSpace` widgets from a children list, calculates resolved pixel spacing between children, and separates content widgets from spacing widgets.

**Files:**
- Create: `flutter_responsive_layout/lib/src/spacing/spacing_resolver.dart`
- Create: `flutter_responsive_layout/test/spacing_resolver_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/spacing_resolver_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/src/spacing/spacing_resolver.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

class TestHSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestHSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.horizontal;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class TestVSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestVSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.vertical;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  group('SpacingResolver', () {
    test('separates content from spacing widgets', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const TestHSpace(2),
        const SizedBox(key: ValueKey('b')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 8.0,
        fallbackSpacing: null,
      );

      expect(result.contentWidgets, hasLength(2));
      expect(result.gaps, hasLength(1));
      expect(result.gaps[0], 16.0); // 2 * 8.0
    });

    test('uses fallbackSpacing when no matching space widget', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const SizedBox(key: ValueKey('b')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 8.0,
        fallbackSpacing: 3,
      );

      expect(result.gaps, hasLength(1));
      expect(result.gaps[0], 24.0); // 3 * 8.0
    });

    test('uses baseSpacing when no fallback and no space widget', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const SizedBox(key: ValueKey('b')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 10.0,
        fallbackSpacing: null,
      );

      expect(result.gaps, hasLength(1));
      expect(result.gaps[0], 10.0); // 1 * 10.0
    });

    test('ignores spacing widgets on wrong axis', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const TestVSpace(5), // vertical space in horizontal context
        const SizedBox(key: ValueKey('b')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 8.0,
        fallbackSpacing: null,
      );

      // VSpace is ignored in horizontal mode, default gap applied
      expect(result.contentWidgets, hasLength(2));
      expect(result.gaps, hasLength(1));
      expect(result.gaps[0], 8.0); // 1 * baseSpacing
    });

    test('handles consecutive spacing widgets between same pair', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const TestHSpace(2),
        const TestVSpace(4),
        const SizedBox(key: ValueKey('b')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 8.0,
        fallbackSpacing: null,
      );

      expect(result.contentWidgets, hasLength(2));
      expect(result.gaps, hasLength(1));
      expect(result.gaps[0], 16.0); // HSpace(2) applies, VSpace ignored
    });

    test('handles multiple content widgets with mixed spacing', () {
      final children = <Widget>[
        const SizedBox(key: ValueKey('a')),
        const TestHSpace(3),
        const SizedBox(key: ValueKey('b')),
        const SizedBox(key: ValueKey('c')),
      ];

      final result = SpacingResolver.resolve(
        children: children,
        axis: Axis.horizontal,
        baseSpacing: 8.0,
        fallbackSpacing: null,
      );

      expect(result.contentWidgets, hasLength(3));
      expect(result.gaps, hasLength(2));
      expect(result.gaps[0], 24.0); // HSpace(3)
      expect(result.gaps[1], 8.0);  // default
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/spacing_resolver_test.dart`
Expected: FAIL — `SpacingResolver` not found.

**Step 3: Implement SpacingResolver**

Create `flutter_responsive_layout/lib/src/spacing/spacing_resolver.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'responsive_space.dart';

/// Result of resolving spacing between children.
class ResolvedSpacing {
  /// Content widgets with spacing widgets removed.
  final List<Widget> contentWidgets;

  /// Pixel gaps between each pair of adjacent content widgets.
  /// Length is always `contentWidgets.length - 1`.
  final List<double> gaps;

  const ResolvedSpacing({
    required this.contentWidgets,
    required this.gaps,
  });
}

/// Extracts [ResponsiveSpace] widgets from a children list and
/// resolves pixel gaps between content widgets.
class SpacingResolver {
  SpacingResolver._();

  /// Resolve spacing for the given [axis].
  ///
  /// Walks [children], separating content widgets from [ResponsiveSpace]
  /// widgets. For each pair of adjacent content widgets, finds the
  /// matching-axis space widget between them (if any) and computes
  /// the pixel gap as `size × baseSpacing`.
  ///
  /// If no matching space widget exists between a pair, uses
  /// `(fallbackSpacing ?? 1) × baseSpacing`.
  static ResolvedSpacing resolve({
    required List<Widget> children,
    required Axis axis,
    required double baseSpacing,
    required double? fallbackSpacing,
  }) {
    final contentWidgets = <Widget>[];
    final gaps = <double>[];

    // Collect spacing between current pair of content widgets
    double? pendingGap;
    bool hasPendingContent = false;

    for (final child in children) {
      if (child is ResponsiveSpace) {
        // Only apply if axis matches
        if (child.axis == axis && hasPendingContent) {
          pendingGap = child.size * baseSpacing;
        }
      } else {
        if (hasPendingContent) {
          // There's a previous content widget — record the gap
          gaps.add(pendingGap ?? (fallbackSpacing ?? 1) * baseSpacing);
          pendingGap = null;
        }
        contentWidgets.add(child);
        hasPendingContent = true;
      }
    }

    return ResolvedSpacing(
      contentWidgets: contentWidgets,
      gaps: gaps,
    );
  }
}
```

**Step 4: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/spacing_resolver_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add SpacingResolver for extracting gaps between children"
```

---

## Task 5: LayoutGroup.col

Always-vertical group. The simplest group — no adaptation logic. Good foundation for the others.

**Files:**
- Create: `flutter_responsive_layout/lib/src/groups/col_group.dart`
- Create: `flutter_responsive_layout/lib/src/groups/layout_group.dart`
- Create: `flutter_responsive_layout/test/col_group_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/col_group_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

class TestVSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestVSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.vertical;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  group('LayoutGroup.col', () {
    testWidgets('renders children vertically', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResponsiveLayoutConfig(
            baseSpacing: 10.0,
            child: LayoutGroup.col(
              children: [
                const SizedBox(key: ValueKey('a'), height: 50),
                const SizedBox(key: ValueKey('b'), height: 50),
              ],
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // b should be below a, separated by default spacing (1 * 10.0)
      expect(b.dy, a.dy + 50 + 10.0);
    });

    testWidgets('uses fallbackSpacing when set', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResponsiveLayoutConfig(
            baseSpacing: 10.0,
            child: LayoutGroup.col(
              fallbackSpacing: 3,
              children: [
                const SizedBox(key: ValueKey('a'), height: 50),
                const SizedBox(key: ValueKey('b'), height: 50),
              ],
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      expect(b.dy, a.dy + 50 + 30.0); // 3 * 10.0
    });

    testWidgets('respects VSpace between children', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: ResponsiveLayoutConfig(
            baseSpacing: 10.0,
            child: LayoutGroup.col(
              children: [
                const SizedBox(key: ValueKey('a'), height: 50),
                const TestVSpace(5),
                const SizedBox(key: ValueKey('b'), height: 50),
              ],
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      expect(b.dy, a.dy + 50 + 50.0); // 5 * 10.0
    });

    testWidgets('children get full available width', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 400,
            child: ResponsiveLayoutConfig(
              baseSpacing: 8.0,
              child: LayoutGroup.col(
                children: [
                  Container(key: const ValueKey('a'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final size = tester.getSize(find.byKey(const ValueKey('a')));
      expect(size.width, 400.0);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/col_group_test.dart`
Expected: FAIL — `LayoutGroup` not found.

**Step 3: Implement LayoutGroup base and ColGroup**

Create `flutter_responsive_layout/lib/src/groups/layout_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'col_group.dart';

/// Declarative layout group — describe content relationships and
/// the system handles responsive arrangement.
///
/// Three types:
/// - [LayoutGroup.col] — always vertical
/// - [LayoutGroup.row] — side-by-side when room, vertical when tight
/// - [LayoutGroup.grid] — auto-column count based on min item width
abstract class LayoutGroup extends StatelessWidget {
  const LayoutGroup({super.key});

  /// Always-vertical group. No adaptation.
  ///
  /// [fallbackSpacing] is in baseSpacing multiples. Used as the gap
  /// between children when no [ResponsiveSpace] widget is present.
  /// Defaults to 1 (1× baseSpacing).
  static Widget col({
    Key? key,
    required List<Widget> children,
    double? fallbackSpacing,
  }) {
    return ColGroup(
      key: key,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }
}
```

Create `flutter_responsive_layout/lib/src/groups/col_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import '../config/responsive_layout_config.dart';
import '../spacing/spacing_resolver.dart';
import 'layout_group.dart';

/// Always-vertical layout group.
class ColGroup extends LayoutGroup {
  final List<Widget> children;
  final double? fallbackSpacing;

  const ColGroup({
    super.key,
    required this.children,
    this.fallbackSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final baseSpacing = ResponsiveLayoutConfig.of(context);

    final resolved = SpacingResolver.resolve(
      children: children,
      axis: Axis.vertical,
      baseSpacing: baseSpacing,
      fallbackSpacing: fallbackSpacing,
    );

    final columnChildren = <Widget>[];
    for (int i = 0; i < resolved.contentWidgets.length; i++) {
      if (i > 0) {
        columnChildren.add(SizedBox(height: resolved.gaps[i - 1]));
      }
      columnChildren.add(
        SizedBox(
          width: double.infinity,
          child: resolved.contentWidgets[i],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }
}
```

**Step 4: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/col_group_test.dart`
Expected: PASS

**Step 5: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add LayoutGroup.col — always-vertical group"
```

---

## Task 6: LayoutGroup.row

Side-by-side when room, collapses to vertical when tight. Uses `LayoutBuilder` to read available width and decide.

**Files:**
- Create: `flutter_responsive_layout/lib/src/groups/row_group.dart`
- Modify: `flutter_responsive_layout/lib/src/groups/layout_group.dart`
- Create: `flutter_responsive_layout/test/row_group_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/row_group_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

class TestHSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestHSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.horizontal;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class TestVSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestVSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.vertical;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  group('LayoutGroup.row', () {
    testWidgets('lays out children horizontally when enough space',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 20, // 20 * 10 = 200dp each
                children: [
                  const SizedBox(key: ValueKey('a'), height: 50),
                  const SizedBox(key: ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // Same vertical position (side-by-side)
      expect(b.dy, a.dy);
      // b is to the right of a
      expect(b.dx, greaterThan(a.dx));
    });

    testWidgets('collapses to vertical when not enough space',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 300,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 20, // 20 * 10 = 200dp each, need 400 + gap
                children: [
                  const SizedBox(key: ValueKey('a'), height: 50),
                  const SizedBox(key: ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // b should be below a (collapsed to vertical)
      expect(b.dy, greaterThan(a.dy));
      // Same horizontal position
      expect(b.dx, a.dx);
    });

    testWidgets('uses HSpace in horizontal mode', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 10,
                children: [
                  const SizedBox(key: ValueKey('a'), width: 100, height: 50),
                  const TestHSpace(4),
                  const SizedBox(key: ValueKey('b'), width: 100, height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final aSize = tester.getSize(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // b should be side-by-side, same y
      expect(b.dy, a.dy);
    });

    testWidgets('uses VSpace when collapsed to vertical', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 200,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 20, // 200dp min each, only 200 available
                children: [
                  const SizedBox(key: ValueKey('a'), height: 50),
                  const TestHSpace(4),
                  const TestVSpace(2),
                  const SizedBox(key: ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // Collapsed, VSpace(2) = 20dp gap
      expect(b.dy, a.dy + 50 + 20.0);
    });

    testWidgets('uses fallbackSpacing in collapsed mode when no VSpace',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 200,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 20,
                fallbackSpacing: 3,
                children: [
                  const SizedBox(key: ValueKey('a'), height: 50),
                  const SizedBox(key: ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      expect(b.dy, a.dy + 50 + 30.0); // 3 * 10.0
    });

    testWidgets('children share width equally in horizontal mode',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.row(
                minChildWidth: 10,
                children: [
                  Container(key: const ValueKey('a'), height: 50),
                  Container(key: const ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final aSize = tester.getSize(find.byKey(const ValueKey('a')));
      final bSize = tester.getSize(find.byKey(const ValueKey('b')));

      // Equal width, accounting for gap (800 - 10) / 2 = 395
      expect(aSize.width, bSize.width);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/row_group_test.dart`
Expected: FAIL — `LayoutGroup.row` not found.

**Step 3: Add row factory to LayoutGroup**

Modify `flutter_responsive_layout/lib/src/groups/layout_group.dart` — add after the `col` factory:

```dart
import 'row_group.dart';

  /// Side-by-side when room, collapses to vertical when tight.
  ///
  /// [minChildWidth] is in baseSpacing multiples. If any child would
  /// get less than this width, the entire row collapses to vertical.
  /// Defaults to 20 (20× baseSpacing).
  ///
  /// [fallbackSpacing] is in baseSpacing multiples. Used as the gap
  /// when no matching [ResponsiveSpace] widget exists between a pair
  /// of children. Defaults to 1 (1× baseSpacing).
  static Widget row({
    Key? key,
    required List<Widget> children,
    double? minChildWidth,
    double? fallbackSpacing,
  }) {
    return RowGroup(
      key: key,
      minChildWidth: minChildWidth,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }
```

The full updated `layout_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'col_group.dart';
import 'row_group.dart';

/// Declarative layout group — describe content relationships and
/// the system handles responsive arrangement.
///
/// Three types:
/// - [LayoutGroup.col] — always vertical
/// - [LayoutGroup.row] — side-by-side when room, vertical when tight
/// - [LayoutGroup.grid] — auto-column count based on min item width
abstract class LayoutGroup extends StatelessWidget {
  const LayoutGroup({super.key});

  /// Always-vertical group. No adaptation.
  static Widget col({
    Key? key,
    required List<Widget> children,
    double? fallbackSpacing,
  }) {
    return ColGroup(
      key: key,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }

  /// Side-by-side when room, collapses to vertical when tight.
  ///
  /// [minChildWidth] is in baseSpacing multiples. If any child would
  /// get less than this width, the entire row collapses to vertical.
  /// Defaults to 20 (20× baseSpacing).
  ///
  /// [fallbackSpacing] is in baseSpacing multiples. Used as the gap
  /// when no matching [ResponsiveSpace] widget exists between a pair
  /// of children. Defaults to 1 (1× baseSpacing).
  static Widget row({
    Key? key,
    required List<Widget> children,
    double? minChildWidth,
    double? fallbackSpacing,
  }) {
    return RowGroup(
      key: key,
      minChildWidth: minChildWidth,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }
}
```

**Step 4: Implement RowGroup**

Create `flutter_responsive_layout/lib/src/groups/row_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import '../config/responsive_layout_config.dart';
import '../spacing/spacing_resolver.dart';
import 'layout_group.dart';

/// Side-by-side layout that collapses to vertical when tight.
class RowGroup extends LayoutGroup {
  final List<Widget> children;
  final double? minChildWidth;
  final double? fallbackSpacing;

  const RowGroup({
    super.key,
    required this.children,
    this.minChildWidth,
    this.fallbackSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final baseSpacing = ResponsiveLayoutConfig.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final minWidth = (minChildWidth ?? 20) * baseSpacing;

        // Resolve horizontal spacing to calculate if children fit
        final hResolved = SpacingResolver.resolve(
          children: children,
          axis: Axis.horizontal,
          baseSpacing: baseSpacing,
          fallbackSpacing: fallbackSpacing,
        );

        final contentCount = hResolved.contentWidgets.length;
        final totalGapWidth =
            hResolved.gaps.fold<double>(0, (sum, gap) => sum + gap);
        final widthPerChild =
            contentCount > 0
                ? (availableWidth - totalGapWidth) / contentCount
                : availableWidth;

        final isHorizontal = widthPerChild >= minWidth;

        if (isHorizontal) {
          return _buildHorizontal(hResolved, baseSpacing);
        } else {
          return _buildVertical(baseSpacing);
        }
      },
    );
  }

  Widget _buildHorizontal(ResolvedSpacing resolved, double baseSpacing) {
    final rowChildren = <Widget>[];
    for (int i = 0; i < resolved.contentWidgets.length; i++) {
      if (i > 0) {
        rowChildren.add(SizedBox(width: resolved.gaps[i - 1]));
      }
      rowChildren.add(
        Expanded(child: resolved.contentWidgets[i]),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }

  Widget _buildVertical(double baseSpacing) {
    // Re-resolve for vertical axis
    final vResolved = SpacingResolver.resolve(
      children: children,
      axis: Axis.vertical,
      baseSpacing: baseSpacing,
      fallbackSpacing: fallbackSpacing,
    );

    final columnChildren = <Widget>[];
    for (int i = 0; i < vResolved.contentWidgets.length; i++) {
      if (i > 0) {
        columnChildren.add(SizedBox(height: vResolved.gaps[i - 1]));
      }
      columnChildren.add(
        SizedBox(
          width: double.infinity,
          child: vResolved.contentWidgets[i],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: columnChildren,
    );
  }
}
```

**Step 5: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/row_group_test.dart`
Expected: PASS

**Step 6: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add LayoutGroup.row — adaptive horizontal/vertical group"
```

---

## Task 7: LayoutGroup.grid

Auto-column grid based on min item width. Column count adjusts continuously with available space.

**Files:**
- Create: `flutter_responsive_layout/lib/src/groups/grid_group.dart`
- Modify: `flutter_responsive_layout/lib/src/groups/layout_group.dart`
- Create: `flutter_responsive_layout/test/grid_group_test.dart`

**Step 1: Write the test**

Create `flutter_responsive_layout/test/grid_group_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

void main() {
  group('LayoutGroup.grid', () {
    testWidgets('shows 2 columns when width fits 2 items', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 600,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.grid(
                minItemWidth: 25, // 250dp min per item
                children: [
                  SizedBox(key: const ValueKey('a'), height: 50),
                  SizedBox(key: const ValueKey('b'), height: 50),
                  SizedBox(key: const ValueKey('c'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));
      final c = tester.getTopLeft(find.byKey(const ValueKey('c')));

      // a and b on same row
      expect(b.dy, a.dy);
      expect(b.dx, greaterThan(a.dx));

      // c on next row
      expect(c.dy, greaterThan(a.dy));
    });

    testWidgets('shows 1 column when width fits only 1 item', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 200,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.grid(
                minItemWidth: 25, // 250dp min, only 200 available
                children: [
                  SizedBox(key: const ValueKey('a'), height: 50),
                  SizedBox(key: const ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));

      // Stacked vertically
      expect(b.dy, greaterThan(a.dy));
      expect(b.dx, a.dx);
    });

    testWidgets('shows 3 columns when width fits 3 items', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 900,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.grid(
                minItemWidth: 25, // 250dp min per item
                children: [
                  SizedBox(key: const ValueKey('a'), height: 50),
                  SizedBox(key: const ValueKey('b'), height: 50),
                  SizedBox(key: const ValueKey('c'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final b = tester.getTopLeft(find.byKey(const ValueKey('b')));
      final c = tester.getTopLeft(find.byKey(const ValueKey('c')));

      // All on same row
      expect(b.dy, a.dy);
      expect(c.dy, a.dy);
    });

    testWidgets('items have equal width', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 600,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.grid(
                minItemWidth: 25,
                children: [
                  Container(key: const ValueKey('a'), height: 50),
                  Container(key: const ValueKey('b'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final aSize = tester.getSize(find.byKey(const ValueKey('a')));
      final bSize = tester.getSize(find.byKey(const ValueKey('b')));

      expect(aSize.width, bSize.width);
    });

    testWidgets('uses baseSpacing for gaps', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 600,
            child: ResponsiveLayoutConfig(
              baseSpacing: 10.0,
              child: LayoutGroup.grid(
                minItemWidth: 25,
                children: [
                  SizedBox(key: const ValueKey('a'), height: 50),
                  SizedBox(key: const ValueKey('b'), height: 50),
                  SizedBox(key: const ValueKey('c'), height: 50),
                  SizedBox(key: const ValueKey('d'), height: 50),
                ],
              ),
            ),
          ),
        ),
      );

      final a = tester.getTopLeft(find.byKey(const ValueKey('a')));
      final c = tester.getTopLeft(find.byKey(const ValueKey('c')));

      // c is on next row, gap should be baseSpacing
      expect(c.dy, a.dy + 50 + 10.0);
    });
  });
}
```

**Step 2: Run test to verify it fails**

Run: `cd flutter_responsive_layout && flutter test test/grid_group_test.dart`
Expected: FAIL — `LayoutGroup.grid` not found.

**Step 3: Add grid factory to LayoutGroup**

Add to `flutter_responsive_layout/lib/src/groups/layout_group.dart`:

```dart
import 'grid_group.dart';

  /// Auto-column grid based on min item width.
  ///
  /// [minItemWidth] is in baseSpacing multiples. Column count is
  /// calculated continuously: `availableWidth ~/ (minItemWidth × baseSpacing)`.
  /// Items fill left-to-right, equal width.
  static Widget grid({
    Key? key,
    required double minItemWidth,
    required List<Widget> children,
  }) {
    return GridGroup(
      key: key,
      minItemWidth: minItemWidth,
      children: children,
    );
  }
```

The full updated `layout_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'col_group.dart';
import 'grid_group.dart';
import 'row_group.dart';

/// Declarative layout group — describe content relationships and
/// the system handles responsive arrangement.
///
/// Three types:
/// - [LayoutGroup.col] — always vertical
/// - [LayoutGroup.row] — side-by-side when room, vertical when tight
/// - [LayoutGroup.grid] — auto-column count based on min item width
abstract class LayoutGroup extends StatelessWidget {
  const LayoutGroup({super.key});

  /// Always-vertical group. No adaptation.
  static Widget col({
    Key? key,
    required List<Widget> children,
    double? fallbackSpacing,
  }) {
    return ColGroup(
      key: key,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }

  /// Side-by-side when room, collapses to vertical when tight.
  static Widget row({
    Key? key,
    required List<Widget> children,
    double? minChildWidth,
    double? fallbackSpacing,
  }) {
    return RowGroup(
      key: key,
      minChildWidth: minChildWidth,
      fallbackSpacing: fallbackSpacing,
      children: children,
    );
  }

  /// Auto-column grid based on min item width.
  ///
  /// [minItemWidth] is in baseSpacing multiples. Column count is
  /// calculated continuously: `availableWidth ~/ (minItemWidth × baseSpacing)`.
  /// Items fill left-to-right, equal width.
  static Widget grid({
    Key? key,
    required double minItemWidth,
    required List<Widget> children,
  }) {
    return GridGroup(
      key: key,
      minItemWidth: minItemWidth,
      children: children,
    );
  }
}
```

**Step 4: Implement GridGroup**

Create `flutter_responsive_layout/lib/src/groups/grid_group.dart`:

```dart
import 'package:flutter/widgets.dart';
import '../config/responsive_layout_config.dart';
import 'layout_group.dart';

/// Auto-column grid that adjusts column count continuously.
class GridGroup extends LayoutGroup {
  final double minItemWidth;
  final List<Widget> children;

  const GridGroup({
    super.key,
    required this.minItemWidth,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final baseSpacing = ResponsiveLayoutConfig.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final minWidthPx = minItemWidth * baseSpacing;
        final gap = baseSpacing;

        // Calculate how many columns fit
        // Account for gaps: n columns need (n-1) gaps
        // availableWidth >= n * minWidthPx + (n-1) * gap
        // availableWidth + gap >= n * (minWidthPx + gap)
        // n = (availableWidth + gap) / (minWidthPx + gap)
        int columns = ((availableWidth + gap) / (minWidthPx + gap)).floor();
        if (columns < 1) columns = 1;
        if (columns > children.length) columns = children.length;

        final itemWidth =
            (availableWidth - (columns - 1) * gap) / columns;

        // Build rows
        final rows = <Widget>[];
        for (int i = 0; i < children.length; i += columns) {
          final rowChildren = <Widget>[];
          for (int j = 0; j < columns && i + j < children.length; j++) {
            if (j > 0) {
              rowChildren.add(SizedBox(width: gap));
            }
            rowChildren.add(
              SizedBox(
                width: itemWidth,
                child: children[i + j],
              ),
            );
          }

          // Pad incomplete last row
          final itemsInRow = rowChildren.where((w) {
            if (w is SizedBox && w.child == null) return false;
            return true;
          }).length;
          if (itemsInRow < columns) {
            final remaining = columns - itemsInRow;
            for (int k = 0; k < remaining; k++) {
              rowChildren.add(SizedBox(width: gap));
              rowChildren.add(SizedBox(width: itemWidth));
            }
          }

          if (rows.isNotEmpty) {
            rows.add(SizedBox(height: gap));
          }
          rows.add(Row(children: rowChildren));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: rows,
        );
      },
    );
  }
}
```

**Step 5: Run test to verify it passes**

Run: `cd flutter_responsive_layout && flutter test test/grid_group_test.dart`
Expected: PASS

**Step 6: Run all tests**

Run: `cd flutter_responsive_layout && flutter test`
Expected: All tests pass.

**Step 7: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add LayoutGroup.grid — auto-column responsive grid"
```

---

## Task 8: Full package analysis + integration test

Verify the entire package compiles, all tests pass, and write one integration test that uses all three group types nested together.

**Files:**
- Create: `flutter_responsive_layout/test/integration_test.dart`

**Step 1: Write integration test**

Create `flutter_responsive_layout/test/integration_test.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_responsive_layout/flutter_responsive_layout.dart';

class TestHSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestHSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.horizontal;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

class TestVSpace extends StatelessWidget implements ResponsiveSpace {
  @override
  final double size;
  const TestVSpace(this.size, {super.key});
  @override
  Axis get axis => Axis.vertical;
  @override
  Widget build(BuildContext context) => const SizedBox();
}

void main() {
  group('Integration: nested groups', () {
    testWidgets('col containing row and grid renders without error',
        (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 800,
            height: 600,
            child: ResponsiveLayoutConfig(
              baseSpacing: 8.0,
              child: SingleChildScrollView(
                child: LayoutGroup.col(
                  children: [
                    LayoutGroup.row(
                      minChildWidth: 20,
                      children: [
                        const SizedBox(
                            key: ValueKey('sidebar'), height: 100),
                        const TestHSpace(2),
                        const SizedBox(
                            key: ValueKey('content'), height: 100),
                      ],
                    ),
                    const TestVSpace(3),
                    LayoutGroup.grid(
                      minItemWidth: 20,
                      children: [
                        SizedBox(key: const ValueKey('card1'), height: 80),
                        SizedBox(key: const ValueKey('card2'), height: 80),
                        SizedBox(key: const ValueKey('card3'), height: 80),
                        SizedBox(key: const ValueKey('card4'), height: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Row should be horizontal (800dp is enough for 2 × 160dp)
      final sidebar = tester.getTopLeft(find.byKey(const ValueKey('sidebar')));
      final content = tester.getTopLeft(find.byKey(const ValueKey('content')));
      expect(content.dy, sidebar.dy); // same row
      expect(content.dx, greaterThan(sidebar.dx)); // side by side

      // Grid should have multiple columns
      final card1 = tester.getTopLeft(find.byKey(const ValueKey('card1')));
      final card2 = tester.getTopLeft(find.byKey(const ValueKey('card2')));
      expect(card2.dy, card1.dy); // same row
      expect(card2.dx, greaterThan(card1.dx)); // side by side

      // Grid should be below the row
      expect(card1.dy, greaterThan(sidebar.dy));
    });

    testWidgets('everything collapses on narrow screen', (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            width: 200,
            height: 800,
            child: ResponsiveLayoutConfig(
              baseSpacing: 8.0,
              child: SingleChildScrollView(
                child: LayoutGroup.col(
                  children: [
                    LayoutGroup.row(
                      minChildWidth: 20, // 160dp min, only 200 available
                      children: [
                        const SizedBox(
                            key: ValueKey('sidebar'), height: 100),
                        const SizedBox(
                            key: ValueKey('content'), height: 100),
                      ],
                    ),
                    LayoutGroup.grid(
                      minItemWidth: 30, // 240dp min, only 200 available
                      children: [
                        SizedBox(key: const ValueKey('card1'), height: 80),
                        SizedBox(key: const ValueKey('card2'), height: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      // Row should be collapsed (vertical)
      final sidebar = tester.getTopLeft(find.byKey(const ValueKey('sidebar')));
      final content = tester.getTopLeft(find.byKey(const ValueKey('content')));
      expect(content.dy, greaterThan(sidebar.dy));

      // Grid should be single column
      final card1 = tester.getTopLeft(find.byKey(const ValueKey('card1')));
      final card2 = tester.getTopLeft(find.byKey(const ValueKey('card2')));
      expect(card2.dy, greaterThan(card1.dy));
      expect(card2.dx, card1.dx);
    });
  });
}
```

**Step 2: Run all tests**

Run: `cd flutter_responsive_layout && flutter test`
Expected: All tests pass.

**Step 3: Analyze the package**

Run: `cd flutter_responsive_layout && flutter analyze`
Expected: No issues.

**Step 4: Commit**

```bash
git add flutter_responsive_layout/
git commit -m "feat: add integration tests, complete flutter_responsive_layout package"
```

---

## Implementation Order

```
Task 1 (scaffold)              — no deps
Task 2 (ResponsiveSpace)       — needs Task 1
Task 3 (ResponsiveLayoutConfig) — needs Task 1
Task 4 (SpacingResolver)       — needs Task 2
Task 5 (LayoutGroup.col)       — needs Tasks 3, 4
Task 6 (LayoutGroup.row)       — needs Tasks 3, 4, 5
Task 7 (LayoutGroup.grid)      — needs Tasks 3, 5
Task 8 (integration + verify)  — needs all above
```

Tasks 2 and 3 can run in parallel after Task 1. Tasks 5 and 7 can run in parallel after Task 4. Task 8 is last.

---

## Critical Files to Reference

| File | What it provides |
|------|------------------|
| `achaean_flutter/lib/design_system/primitives/ui_scaler.dart` | How UiScaler works — this package complements it |
| `achaean_flutter/lib/design_system/primitives/app_sizes.dart` | `AppSizes.space` — typical `baseSpacing` value |
| `dart_git/pubspec.yaml` | Package structure pattern for workspace |
| `dart_koinon/pubspec.yaml` | Package structure pattern for workspace |
| `pubspec.yaml` (root) | Workspace configuration |
| `docs/plans/2026-03-10-responsive-layout-design.md` | Design doc for this package |

## Verification

1. `flutter test` in `flutter_responsive_layout/` — all tests pass
2. `flutter analyze` in `flutter_responsive_layout/` — no issues
3. All three group types work nested inside each other
4. Spacing respects `ResponsiveLayoutConfig.baseSpacing`
5. `ResponsiveSpace` widgets are recognized and applied correctly
6. `LayoutGroup.row` collapses at the right threshold
7. `LayoutGroup.grid` adjusts column count continuously
