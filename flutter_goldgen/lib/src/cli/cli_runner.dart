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
