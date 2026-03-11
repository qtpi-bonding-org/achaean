# flutter_goldgen

Auto-generates golden tests for Flutter apps that use the BlocBuilder + IUiFlowState pattern. Point it at your project, and it produces fixture files (one per state class, with factory constructors for every field combination) and golden test files (one per screen, covering every state x size x locale).

## Quick start

1. Add to `dev_dependencies`:

```yaml
dev_dependencies:
  flutter_goldgen:
    path: ../flutter_goldgen  # or your package location
```

2. Create a `goldgen.yaml` in your project root (see format below).

3. Run:

```bash
dart run flutter_goldgen
```

4. Generate golden images:

```bash
flutter test --update-goldens test/goldens/generated/tests/
```

## goldgen.yaml format

```yaml
sizes:
  - name: phone
    width: 375
    height: 812
  - name: tablet
    width: 1024
    height: 768

locales:
  - en
  - ar

theme_import: "package:my_app/theme/app_theme.dart"
theme_variable: appTheme

l10n_delegates_import: "package:my_app/l10n/l10n.dart"
l10n_delegates_variable: AppLocalizations.localizationsDelegates
l10n_supported_locales_variable: AppLocalizations.supportedLocales
```

## CLI options

```
dart run flutter_goldgen [options]

  -p, --project-path    Path to the Flutter project's lib/ directory (default: ".")
  -o, --output          Output directory for generated files (default: "test/goldens/generated")
  -c, --config          Path to goldgen.yaml config file (default: "goldgen.yaml")
  -h, --help            Show this help message
```

## Output structure

```
test/goldens/generated/
  fixtures/
    login_state_fixtures.dart       # Factory constructors for LoginState
    dashboard_state_fixtures.dart   # Factory constructors for DashboardState
  tests/
    login_screen_golden_test.dart   # Golden tests for LoginScreen
    dashboard_screen_golden_test.dart
```

- **Fixture files** expose a class with static methods that return state instances with sensible defaults for every field. Each field gets a dedicated factory that sets that field to a non-default value.
- **Test files** render each screen in a `MaterialApp` with the configured theme, locales, and sizes, producing one golden image per combination.

## Viewing results

After generation, run the golden tests to create baseline images:

```bash
flutter test --update-goldens test/goldens/generated/tests/
```

Golden images land next to the test files. Re-run without `--update-goldens` to assert against the baselines in CI.

## Reusing fixtures in unit tests

The generated fixture files are plain Dart with no test-framework dependency. Import them anywhere:

```dart
import 'package:my_app/../test/goldens/generated/fixtures/login_state_fixtures.dart';

void main() {
  test('some unit test', () {
    final state = LoginStateFixtures.withEmailError();
    // ...
  });
}
```

This keeps golden tests and unit tests sharing the same state factories, so you only maintain one set of test data.
