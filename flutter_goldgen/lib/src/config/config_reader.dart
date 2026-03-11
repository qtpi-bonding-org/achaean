import 'dart:io';

import 'package:yaml/yaml.dart';

import 'goldgen_config.dart';

/// Reads and parses a `goldgen.yaml` configuration file into a
/// [GoldgenConfig] instance.
class ConfigReader {
  /// Reads the YAML config file at [path] and returns a [GoldgenConfig].
  ///
  /// Throws [FileSystemException] if the file does not exist.
  GoldgenConfig read(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      throw FileSystemException('Config file not found', path);
    }
    final content = file.readAsStringSync();
    final yaml = loadYaml(content) as YamlMap;

    final sizes = (yaml['sizes'] as YamlList).map((entry) {
      final map = entry as YamlMap;
      return SizeConfig(
        name: map['name'] as String,
        width: map['width'] as int,
        height: map['height'] as int,
      );
    }).toList();

    final locales = (yaml['locales'] as YamlList)
        .map((e) => e.toString())
        .toList();

    return GoldgenConfig(
      sizes: sizes,
      locales: locales,
      themeImport: yaml['theme_import'] as String,
      themeVariable: yaml['theme_variable'] as String,
      l10nDelegatesImport: yaml['l10n_delegates_import'] as String,
      l10nDelegatesVariable: yaml['l10n_delegates_variable'] as String,
      l10nSupportedLocalesVariable:
          yaml['l10n_supported_locales_variable'] as String,
    );
  }
}
