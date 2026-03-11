import 'dart:io';

import 'package:flutter_goldgen/src/config/config_reader.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('ConfigReader', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('goldgen_config_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('reads sizes from yaml', () {
      _writeConfig(tempDir, '''
sizes:
  - name: phoneSE
    width: 375
    height: 812
locales: [en]
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
l10n_delegates_import: "package:my_app/l10n.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
      final config = ConfigReader().read(p.join(tempDir.path, 'goldgen.yaml'));
      expect(config.sizes, hasLength(1));
      expect(config.sizes.first.name, 'phoneSE');
      expect(config.sizes.first.width, 375);
      expect(config.sizes.first.height, 812);
    });

    test('reads multiple sizes', () {
      _writeConfig(tempDir, '''
sizes:
  - name: phoneSE
    width: 375
    height: 812
  - name: phoneMax
    width: 430
    height: 932
locales: [en]
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
l10n_delegates_import: "package:my_app/l10n.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
      final config = ConfigReader().read(p.join(tempDir.path, 'goldgen.yaml'));
      expect(config.sizes, hasLength(2));
      expect(config.sizes[1].name, 'phoneMax');
      expect(config.sizes[1].width, 430);
      expect(config.sizes[1].height, 932);
    });

    test('reads locales', () {
      _writeConfig(tempDir, '''
sizes:
  - name: phone
    width: 375
    height: 812
locales: [en, de, ja]
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
l10n_delegates_import: "package:my_app/l10n.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
      final config = ConfigReader().read(p.join(tempDir.path, 'goldgen.yaml'));
      expect(config.locales, ['en', 'de', 'ja']);
    });

    test('reads theme config', () {
      _writeConfig(tempDir, '''
sizes:
  - name: phone
    width: 375
    height: 812
locales: [en]
theme_import: "package:my_app/design_system/theme.dart"
theme_variable: myAppTheme
l10n_delegates_import: "package:my_app/l10n.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
      final config = ConfigReader().read(p.join(tempDir.path, 'goldgen.yaml'));
      expect(config.themeImport, 'package:my_app/design_system/theme.dart');
      expect(config.themeVariable, 'myAppTheme');
    });

    test('reads l10n config', () {
      _writeConfig(tempDir, '''
sizes:
  - name: phone
    width: 375
    height: 812
locales: [en]
theme_import: "package:my_app/theme.dart"
theme_variable: appTheme
l10n_delegates_import: "package:my_app/l10n/app_localizations.dart"
l10n_delegates_variable: "AppLocalizations.localizationsDelegates"
l10n_supported_locales_variable: "AppLocalizations.supportedLocales"
''');
      final config = ConfigReader().read(p.join(tempDir.path, 'goldgen.yaml'));
      expect(config.l10nDelegatesImport,
          'package:my_app/l10n/app_localizations.dart');
      expect(config.l10nDelegatesVariable,
          'AppLocalizations.localizationsDelegates');
      expect(config.l10nSupportedLocalesVariable,
          'AppLocalizations.supportedLocales');
    });

    test('throws on missing file', () {
      expect(
        () => ConfigReader().read(p.join(tempDir.path, 'nonexistent.yaml')),
        throwsA(isA<FileSystemException>()),
      );
    });
  });
}

void _writeConfig(Directory dir, String content) {
  File(p.join(dir.path, 'goldgen.yaml')).writeAsStringSync(content);
}
