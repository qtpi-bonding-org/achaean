/// Configuration for a single screen size used in golden test generation.
class SizeConfig {
  final String name;
  final int width;
  final int height;

  const SizeConfig({
    required this.name,
    required this.width,
    required this.height,
  });
}

/// Top-level configuration for flutter_goldgen, read from `goldgen.yaml`.
class GoldgenConfig {
  final List<SizeConfig> sizes;
  final List<String> locales;
  final String themeImport;
  final String themeVariable;
  final String l10nDelegatesImport;
  final String l10nDelegatesVariable;
  final String l10nSupportedLocalesVariable;

  const GoldgenConfig({
    required this.sizes,
    required this.locales,
    required this.themeImport,
    required this.themeVariable,
    required this.l10nDelegatesImport,
    required this.l10nDelegatesVariable,
    required this.l10nSupportedLocalesVariable,
  });
}
