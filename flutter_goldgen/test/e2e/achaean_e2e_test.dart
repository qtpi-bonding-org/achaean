@Timeout(Duration(minutes: 3))
library;

import 'dart:io';

import 'package:flutter_goldgen/src/cli/cli_runner.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  const achaeanLibPath =
      '/Users/aicoder/Documents/achaean/achaean_flutter/lib';

  group('E2E: achaean_flutter', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('goldgen_e2e_');
      // Write goldgen.yaml to temp dir
      File(p.join(tempDir.path, 'goldgen.yaml')).writeAsStringSync('''
sizes:
  - name: phoneSE
    width: 375
    height: 812

locales:
  - en

theme_import: "package:achaean_flutter/design_system/theme/app_theme.dart"
theme_variable: AppTheme.lightTheme

l10n_delegates_import: "package:achaean_flutter/l10n/app_localizations.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('generates fixture and test files', () async {
      final runner = CliRunner();
      final outputPath = p.join(tempDir.path, 'output');

      await runner.run([
        '--project-path',
        achaeanLibPath,
        '--config',
        p.join(tempDir.path, 'goldgen.yaml'),
        '--output',
        outputPath,
      ]);

      // Verify fixture files exist
      final fixturesDir = Directory(p.join(outputPath, 'fixtures'));
      expect(fixturesDir.existsSync(), isTrue,
          reason: 'fixtures/ directory should exist');
      final fixtureFiles =
          fixturesDir.listSync().whereType<File>().toList();
      expect(fixtureFiles.length, greaterThanOrEqualTo(5),
          reason: 'Should find at least 5 state classes '
              '(AgoraState, TrustState, FlagState, PolisState, etc.)');

      // Verify test files exist
      final testsDir = Directory(p.join(outputPath, 'tests'));
      expect(testsDir.existsSync(), isTrue,
          reason: 'tests/ directory should exist');
      final testFiles =
          testsDir.listSync().whereType<File>().toList();
      expect(testFiles.length, greaterThanOrEqualTo(1),
          reason: 'Should find at least 1 screen');

      // Verify content of all generated files
      for (final file in [...fixtureFiles, ...testFiles]) {
        final content = (file as File).readAsStringSync();
        expect(content, contains('GENERATED CODE'),
            reason: '${p.basename(file.path)} should contain GENERATED CODE header');
        expect(content.length, greaterThan(100),
            reason: '${p.basename(file.path)} should have substantial content');
      }
    });

    test('fixture files contain expected class names', () async {
      final runner = CliRunner();
      final outputPath = p.join(tempDir.path, 'output');

      await runner.run([
        '--project-path',
        achaeanLibPath,
        '--config',
        p.join(tempDir.path, 'goldgen.yaml'),
        '--output',
        outputPath,
      ]);

      final fixturesDir = Directory(p.join(outputPath, 'fixtures'));
      final fixtureContents = fixturesDir
          .listSync()
          .whereType<File>()
          .map((f) => f.readAsStringSync())
          .join('\n');

      // These states are known to exist in achaean_flutter
      expect(fixtureContents, contains('AgoraStateFixtures'),
          reason: 'Should generate fixtures for AgoraState');
      expect(fixtureContents, contains('TrustStateFixtures'),
          reason: 'Should generate fixtures for TrustState');
      expect(fixtureContents, contains('FlagStateFixtures'),
          reason: 'Should generate fixtures for FlagState');
    });

    test('test files contain testWidgets and matchesGoldenFile', () async {
      final runner = CliRunner();
      final outputPath = p.join(tempDir.path, 'output');

      await runner.run([
        '--project-path',
        achaeanLibPath,
        '--config',
        p.join(tempDir.path, 'goldgen.yaml'),
        '--output',
        outputPath,
      ]);

      final testsDir = Directory(p.join(outputPath, 'tests'));
      final testContents = testsDir
          .listSync()
          .whereType<File>()
          .map((f) => f.readAsStringSync())
          .join('\n');

      expect(testContents, contains('testWidgets'),
          reason: 'Generated test files should contain testWidgets calls');
      expect(testContents, contains('matchesGoldenFile'),
          reason: 'Generated test files should contain matchesGoldenFile');
    });

    test('fixture files list file names follow snake_case convention',
        () async {
      final runner = CliRunner();
      final outputPath = p.join(tempDir.path, 'output');

      await runner.run([
        '--project-path',
        achaeanLibPath,
        '--config',
        p.join(tempDir.path, 'goldgen.yaml'),
        '--output',
        outputPath,
      ]);

      final fixturesDir = Directory(p.join(outputPath, 'fixtures'));
      final fixtureFiles =
          fixturesDir.listSync().whereType<File>().toList();

      for (final file in fixtureFiles) {
        final name = p.basename(file.path);
        expect(name, endsWith('_fixtures.dart'),
            reason: 'Fixture file "$name" should end with _fixtures.dart');
        expect(name, matches(RegExp(r'^[a-z_]+_fixtures\.dart$')),
            reason: 'Fixture file "$name" should be snake_case');
      }
    });

    test('test files list file names follow snake_case convention', () async {
      final runner = CliRunner();
      final outputPath = p.join(tempDir.path, 'output');

      await runner.run([
        '--project-path',
        achaeanLibPath,
        '--config',
        p.join(tempDir.path, 'goldgen.yaml'),
        '--output',
        outputPath,
      ]);

      final testsDir = Directory(p.join(outputPath, 'tests'));
      final testFiles =
          testsDir.listSync().whereType<File>().toList();

      for (final file in testFiles) {
        final name = p.basename(file.path);
        expect(name, endsWith('_golden_test.dart'),
            reason: 'Test file "$name" should end with _golden_test.dart');
        expect(name, matches(RegExp(r'^[a-z_]+_golden_test\.dart$')),
            reason: 'Test file "$name" should be snake_case');
      }
    });
  });
}
