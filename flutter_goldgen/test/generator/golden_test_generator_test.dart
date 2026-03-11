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
        themeImport: 'package:my_app/theme.dart',
        themeVariable: 'appTheme',
        l10nDelegatesImport: 'package:my_app/l10n.dart',
        l10nDelegatesVariable: 'AppLocalizations.localizationsDelegates',
        l10nSupportedLocalesVariable: 'AppLocalizations.supportedLocales',
      );
    });

    test('generates fixture file with GENERATED CODE header', () {
      final state = _fakeState();
      final output = generator.generateFixtureFile(state);

      expect(output, contains('GENERATED CODE'));
      expect(output, contains('class FakeStateFixtures'));
    });

    test('generates fixture file with baseline', () {
      final state = _fakeState();
      final output = generator.generateFixtureFile(state);

      expect(output, contains('baseline'));
    });

    test('generates fixture file with field variants', () {
      final state = _fakeState();
      final output = generator.generateFixtureFile(state);

      // Should have variants for the 'title' field (String?)
      expect(output, contains('title'));
    });

    test('generates fixture file with all list', () {
      final state = _fakeState();
      final output = generator.generateFixtureFile(state);

      expect(output, contains('static final all'));
    });

    test('generates test file with GENERATED CODE header', () {
      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = generator.generateTestFile(screen, states);

      expect(output, contains('GENERATED CODE'));
    });

    test('generates test file with testWidgets', () {
      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = generator.generateTestFile(screen, states);

      expect(output, contains('testWidgets'));
    });

    test('generates test file with matchesGoldenFile', () {
      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = generator.generateTestFile(screen, states);

      expect(output, contains('matchesGoldenFile'));
    });

    test('generates test file with mock cubit class', () {
      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = generator.generateTestFile(screen, states);

      expect(output, contains('MockFakeCubit'));
    });

    test('generates test file with MaterialApp wrapper', () {
      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = generator.generateTestFile(screen, states);

      expect(output, contains('MaterialApp'));
      expect(output, contains('appTheme'));
    });

    test('generates test file with size and locale combos', () {
      final gen = GoldenTestGenerator(
        sizes: [('phoneSE', 375, 812), ('tablet', 768, 1024)],
        locales: ['en', 'de'],
        themeImport: 'package:my_app/theme.dart',
        themeVariable: 'appTheme',
        l10nDelegatesImport: 'package:my_app/l10n.dart',
        l10nDelegatesVariable: 'AppLocalizations.localizationsDelegates',
        l10nSupportedLocalesVariable: 'AppLocalizations.supportedLocales',
      );

      final screen = _fakeScreen();
      final states = {'FakeState': _fakeState()};
      final output = gen.generateTestFile(screen, states);

      expect(output, contains('phoneSE_en'));
      expect(output, contains('tablet_de'));
    });
  });
}

DiscoveredState _fakeState() => DiscoveredState(
      className: 'FakeState',
      filePath: '/lib/features/fake/cubit/fake_state.dart',
      importUri: 'package:my_app/features/fake/cubit/fake_state.dart',
      fields: [
        DiscoveredField(name: 'status', typeName: 'UiFlowStatus'),
        DiscoveredField(name: 'error', typeName: 'Object', isNullable: true),
        DiscoveredField(name: 'title', typeName: 'String', isNullable: true),
        DiscoveredField(name: 'count', typeName: 'int'),
        DiscoveredField(
          name: 'items',
          typeName: 'List<String>',
          isList: true,
          listElementType: 'String',
        ),
      ],
    );

DiscoveredScreen _fakeScreen() => DiscoveredScreen(
      className: 'FakeScreen',
      filePath: '/lib/features/fake/widgets/fake_screen.dart',
      importUri: 'package:my_app/features/fake/widgets/fake_screen.dart',
      cubitBindings: [
        CubitBinding(
            cubitClassName: 'FakeCubit', stateClassName: 'FakeState'),
      ],
    );
