import 'package:flutter_goldgen/src/cli/cli_runner.dart';
import 'package:path/path.dart' as p;
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

    test('parses --config argument', () {
      final config =
          runner.parseArgs(['--config', '/custom/goldgen.yaml']);
      expect(config.configPath, '/custom/goldgen.yaml');
    });

    test('defaults config to goldgen.yaml in project root', () {
      final config = runner.parseArgs(['--project-path', '/my/project']);
      expect(config.configPath, p.join('/my/project', 'goldgen.yaml'));
    });

    test('defaults config to ./goldgen.yaml when no project-path', () {
      final config = runner.parseArgs([]);
      expect(config.configPath, p.join('.', 'goldgen.yaml'));
    });
  });
}
