// GENERATED CODE - DO NOT MODIFY BY HAND
// Generator: l10n_key_resolver
// Generated at: 2026-03-09T04:38:23.205991

import 'app_localizations.dart';

/// Generated resolver for l10n keys.
///
/// Maps dot-notation keys to AppLocalizations getters.
///
/// Usage:
/// ```dart
/// final resolver = L10nKeyResolver(l10n);
/// final message = resolver.resolve('error.auth.failed');
/// ```
class L10nKeyResolver {
  final AppLocalizations _l10n;

  const L10nKeyResolver(this._l10n);

  /// Resolves a dot-notation key to its localized string.
  ///
  /// Returns null if the key is not found.
  ///
  /// For parameterized messages, pass the arguments map.
  String? resolve(String key, {Map<String, dynamic>? args}) {
    return switch (key) {
      // Simple keys (no parameters)
      'app.title' => _l10n.appTitle,
      'error.auth.failed' => _l10n.errorAuthFailed,
      'error.auth.unauthorized' => _l10n.errorAuthUnauthorized,
      'error.generic' => _l10n.errorGeneric,
      'error.network' => _l10n.errorNetwork,
      'error.timeout' => _l10n.errorTimeout,

      _ => null,
    };
  }

  /// Set of all known keys (for validation/debugging).
  static const knownKeys = <String>{
    'app.title',
    'error.auth.failed',
    'error.auth.unauthorized',
    'error.generic',
    'error.network',
    'error.timeout',
  };

  /// Checks if a key is known to this resolver.
  static bool hasKey(String key) => knownKeys.contains(key);

  /// Maps ARB camelCase keys to dot-notation keys.
  static const arbToDotKey = <String, String>{
    'appTitle': 'app.title',
    'errorAuthFailed': 'error.auth.failed',
    'errorAuthUnauthorized': 'error.auth.unauthorized',
    'errorGeneric': 'error.generic',
    'errorNetwork': 'error.network',
    'errorTimeout': 'error.timeout',
  };

  /// Maps dot-notation keys to ARB camelCase keys.
  static const dotToArbKey = <String, String>{
    'app.title': 'appTitle',
    'error.auth.failed': 'errorAuthFailed',
    'error.auth.unauthorized': 'errorAuthUnauthorized',
    'error.generic': 'errorGeneric',
    'error.network': 'errorNetwork',
    'error.timeout': 'errorTimeout',
  };
}
