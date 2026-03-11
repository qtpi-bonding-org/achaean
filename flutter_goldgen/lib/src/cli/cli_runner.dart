import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;

import '../analyzer/screen_inspector.dart';
import '../analyzer/state_inspector.dart';
import '../config/config_reader.dart';
import '../generator/golden_test_generator.dart';
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
      )
      ..addOption(
        'config',
        abbr: 'c',
        help: 'Path to goldgen.yaml config file.',
      );

    final results = parser.parse(args);

    final projectPath = results['project-path'] as String;
    final configPath = results['config'] as String? ??
        p.join(projectPath, 'goldgen.yaml');

    return CliConfig(
      projectPath: projectPath,
      outputPath: results['output'] as String,
      configPath: configPath,
    );
  }

  Future<void> run(List<String> args) async {
    final cliConfig = parseArgs(args);

    stdout.writeln('flutter_goldgen');
    stdout.writeln('  Project: ${cliConfig.projectPath}');
    stdout.writeln('  Config:  ${cliConfig.configPath}');
    stdout.writeln('  Output:  ${cliConfig.outputPath}');
    stdout.writeln('');

    // 1. Read config
    final configReader = ConfigReader();
    final config = configReader.read(cliConfig.configPath);
    stdout.writeln(
        'Config loaded: ${config.sizes.length} sizes, ${config.locales.length} locales');

    // 2. Scan states
    stdout.writeln('Scanning for IUiFlowState classes...');
    final stateInspector = StateInspector();
    final states = await stateInspector.findStates(cliConfig.projectPath);
    stdout.writeln('  Found ${states.length} states');

    // 3. Scan screens
    stdout.writeln('Scanning for screens...');
    final screenInspector = ScreenInspector();
    final screens = await screenInspector.findScreens(cliConfig.projectPath);
    stdout.writeln('  Found ${screens.length} screens');

    // 4. Generate
    stdout.writeln('Generating...');
    final stateMap = {for (final s in states) s.className: s};
    final generator = GoldenTestGenerator(
      sizes: config.sizes.map((s) => (s.name, s.width, s.height)).toList(),
      locales: config.locales,
      themeImport: config.themeImport,
      themeVariable: config.themeVariable,
      l10nDelegatesImport: config.l10nDelegatesImport,
      l10nDelegatesVariable: config.l10nDelegatesVariable,
      l10nSupportedLocalesVariable: config.l10nSupportedLocalesVariable,
    );

    // Create output dirs
    final fixturesDir = Directory(p.join(cliConfig.outputPath, 'fixtures'));
    final testsDir = Directory(p.join(cliConfig.outputPath, 'tests'));
    fixturesDir.createSync(recursive: true);
    testsDir.createSync(recursive: true);

    // Generate fixture files
    for (final state in states) {
      final content = generator.generateFixtureFile(state);
      final fileName = '${_toSnakeCase(state.className)}_fixtures.dart';
      File(p.join(fixturesDir.path, fileName)).writeAsStringSync(content);
    }

    // Generate test files
    for (final screen in screens) {
      final content = generator.generateTestFile(screen, stateMap);
      final fileName = '${_toSnakeCase(screen.className)}_golden_test.dart';
      File(p.join(testsDir.path, fileName)).writeAsStringSync(content);
    }

    stdout.writeln('');
    stdout.writeln(
        'Generated ${states.length} fixture files in ${fixturesDir.path}');
    stdout.writeln(
        'Generated ${screens.length} test files in ${testsDir.path}');
    stdout.writeln('');
    stdout.writeln(
        'Next: flutter test --update-goldens ${cliConfig.outputPath}/tests/');
  }

  String _toSnakeCase(String input) {
    final buf = StringBuffer();
    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      if (char == char.toUpperCase() && char != char.toLowerCase()) {
        if (i > 0) buf.write('_');
        buf.write(char.toLowerCase());
      } else {
        buf.write(char);
      }
    }
    return buf.toString();
  }
}
