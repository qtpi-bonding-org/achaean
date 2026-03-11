# flutter_goldgen Design

## Scope

A standalone Dart CLI that auto-generates golden tests for Flutter apps using the UiFlowStatus/freezed pattern. Scans your code, generates fixtures and test files, outputs PNGs you can scroll through. No build_runner, no runtime dependency, no annotations.

## Key Decisions

- **Standalone CLI** (not build_runner) — decoupled from app build lifecycle, run on demand
- **Auto-discovers everything** — scans freezed states implementing `IUiFlowState`, scans screens for `BlocBuilder`/`BlocProvider` to find cubit-state-screen mappings
- **Recursive fixture generation** — inspects freezed fields, recurses into nested models (freezed or constructor-based), generates edge case values per type
- **Inline generated code** — no runtime dependency, generated test files are self-contained using only `flutter_test` + `mocktail`
- **Screen-level testing** — golden tests render full screens, varying one cubit at a time while holding others at default
- **Configurable combos** — sizes × locales is the default cartesian product, with per-widget overrides for specific combos

---

## Config

One file per project:

```dart
// goldgen.dart
const goldgenConfig = GoldgenConfig(
  sizes: [
    ('phoneSE', Size(375, 812)),
    ('phoneMax', Size(430, 932)),
    ('tablet', Size(768, 1024)),
  ],
  locales: [
    Locale('en'),
    Locale('de'),
  ],
  theme: appTheme,
);
```

---

## CLI Flow

`dart run flutter_goldgen` does:

1. **Read config** — parse `goldgen.dart` for sizes, locales, theme import
2. **Scan states** — find all classes implementing `IUiFlowState` via analyzer
3. **Scan screens** — find `BlocBuilder<CubitX, StateX>` and `BlocProvider<CubitX>` usages to map screens → cubits → states
4. **Inspect fields** — for each state class, extract fields and types recursively
5. **Generate fixtures** — edge case values per field type (see table below)
6. **Generate test files** — self-contained Dart test files with `matchesGoldenFile`
7. **Write output** — to `test/goldens/generated/`

---

## Fixture Generation

Per-type edge cases, vary one field at a time (baseline + boundary):

| Type | Generated values |
|---|---|
| `String` | `''`, `'A'`, `'Test string'`, `'A' * 200` |
| `String?` | `null`, plus above |
| `int` | `0`, `1`, `999999` |
| `double` | `0.0`, `1.5`, `999999.99` |
| `bool` | `true`, `false` |
| `List<X>` | `[]`, `[oneX]`, `List.filled(50, oneX)` |
| `Map<K, V>` | `{}`, `{oneEntry}`, `{manyEntries}` |
| `T?` (optional) | `null` + non-null variants |
| Custom model | Recursively construct from its constructor fields |
| Enum | Each enum value |

Strategy: vary one field at a time, hold others at "normal" defaults. Linear growth (`fields × variants`), not exponential (`variants ^ fields`).

Circular references handled with depth limit.

---

## Screen-Level Testing

For a screen with multiple cubits, vary one at a time:

```
Screen with CubitA, CubitB, CubitC:

Vary A: A=idle/loading/success/failure × fixtures, B=default, C=default
Vary B: A=default, B=idle/loading/success/failure × fixtures, C=default
Vary C: A=default, B=default, C=idle/loading/success/failure × fixtures
```

Linear: `N cubits × 4 statuses × M fixtures`, not `4^N`.

---

## Generated Test File Shape

Self-contained, no runtime dependency:

```dart
// test/goldens/generated/tests/agora_screen_golden_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// ... app imports for screen, states, theme, l10n

void main() {
  final agoraFixtures = [
    AgoraState(),
    AgoraState(status: UiFlowStatus.success, posts: [generatedPost]),
    AgoraState(status: UiFlowStatus.success, posts: []),
    AgoraState(status: UiFlowStatus.success, posts: List.filled(50, generatedPost)),
  ];

  final flagDefault = FlagState();

  for (final fixture in agoraFixtures) {
    for (final status in UiFlowStatus.values) {
      testWidgets('agora_${status.name}_${fixture.label}', (tester) async {
        // Set screen size
        tester.view.physicalSize = const Size(375, 812);
        tester.view.devicePixelRatio = 1.0;

        // Build screen with mock cubits
        await tester.pumpWidget(
          MaterialApp(
            theme: appTheme,
            locale: const Locale('en'),
            localizationsDelegates: [...],
            home: MultiBlocProvider(
              providers: [
                BlocProvider<AgoraCubit>(
                  create: (_) => MockAgoraCubit(fixture.copyWith(status: status)),
                ),
                BlocProvider<FlagCubit>(
                  create: (_) => MockFlagCubit(flagDefault),
                ),
              ],
              child: const AgoraScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await expectLater(
          find.byType(AgoraScreen),
          matchesGoldenFile('phoneSE_en/agora_screen_agora_${status.name}_${fixture.label}.png'),
        );
      });
    }
  }
}
```

---

## Output Structure

```
test/goldens/
  generated/
    fixtures/
      agora_state_fixtures.dart
      trust_state_fixtures.dart
      flag_state_fixtures.dart
      ...
    tests/
      agora_screen_golden_test.dart
      trust_screen_golden_test.dart
      ...
  phoneSE_en/
    agora_screen_agora_idle_default.png
    agora_screen_agora_loading_default.png
    agora_screen_agora_success_normal.png
    agora_screen_agora_success_empty.png
    agora_screen_agora_success_large.png
    agora_screen_agora_failure_default.png
    agora_screen_flag_idle_default.png
    ...
  phoneSE_de/
    ...
  tablet_en/
    ...
```

---

## Package Structure

```
flutter_goldgen/
  bin/
    flutter_goldgen.dart              ← CLI entry point
  lib/
    src/
      analyzer/
        state_inspector.dart          ← finds IUiFlowState classes
        field_inspector.dart          ← extracts field types recursively
        model_inspector.dart          ← inspects nested models
        screen_inspector.dart         ← finds BlocBuilder/BlocProvider in screens
      generator/
        fixture_generator.dart        ← generates edge case values per type
        golden_test_generator.dart    ← generates test files
      config/
        goldgen_config.dart           ← config model
      cli/
        cli_runner.dart               ← arg parsing, orchestration
  pubspec.yaml
```

---

## Workflow

1. Build your feature (state, cubit, screen) as normal
2. `dart run flutter_goldgen` → generates fixture + test files
3. `flutter test --update-goldens test/goldens/` → generates PNGs
4. Open combo folder, scroll through pictures
5. Reuse generated fixtures in unit/cubit tests

---

## Fixture Reuse

Generated fixtures are importable from unit and cubit tests:

```dart
import 'package:my_app/../test/goldens/generated/fixtures/agora_state_fixtures.dart';

test('cubit emits success with posts', () async {
  when(() => mockService.load()).thenAnswer((_) async => agoraFixtures.normalPosts);
  await cubit.load();
  expect(cubit.state.posts, agoraFixtures.normalPosts);
});
```

---

## What's NOT in scope

- No build_runner integration
- No annotations
- No widget-cubit mapping file
- No interactive widgetbook UI
- No CI integration (just generates files, CI runs `flutter test` as normal)
