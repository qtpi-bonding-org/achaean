// GENERATED CODE - DO NOT MODIFY BY HAND
// Generator: l10n_key_resolver
// Generated at: 2026-03-09T10:57:13.756145

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
      'account.creation.error' => _l10n.accountCreationError,
      'account.creation.submit' => _l10n.accountCreationSubmit,
      'account.creation.success' => _l10n.accountCreationSuccess,
      'account.creation.title' => _l10n.accountCreationTitle,
      'app.title' => _l10n.appTitle,
      'error.auth.failed' => _l10n.errorAuthFailed,
      'error.auth.unauthorized' => _l10n.errorAuthUnauthorized,
      'error.generic' => _l10n.errorGeneric,
      'error.network' => _l10n.errorNetwork,
      'error.timeout' => _l10n.errorTimeout,
      'label.email' => _l10n.labelEmail,
      'label.password' => _l10n.labelPassword,
      'label.username' => _l10n.labelUsername,
      'own.posts.empty' => _l10n.ownPostsEmpty,
      'own.posts.title' => _l10n.ownPostsTitle,
      'post.creation.error' => _l10n.postCreationError,
      'post.creation.submit' => _l10n.postCreationSubmit,
      'post.creation.success' => _l10n.postCreationSuccess,
      'post.creation.text.hint' => _l10n.postCreationTextHint,
      'post.creation.title' => _l10n.postCreationTitle,
      'post.creation.title.hint' => _l10n.postCreationTitleHint,
      'validation.required' => _l10n.validationRequired,

      _ => null,
    };
  }

  /// Set of all known keys (for validation/debugging).
  static const knownKeys = <String>{
    'account.creation.error',
    'account.creation.submit',
    'account.creation.success',
    'account.creation.title',
    'app.title',
    'error.auth.failed',
    'error.auth.unauthorized',
    'error.generic',
    'error.network',
    'error.timeout',
    'label.email',
    'label.password',
    'label.username',
    'own.posts.empty',
    'own.posts.title',
    'post.creation.error',
    'post.creation.submit',
    'post.creation.success',
    'post.creation.text.hint',
    'post.creation.title',
    'post.creation.title.hint',
    'validation.required',
  };

  /// Checks if a key is known to this resolver.
  static bool hasKey(String key) => knownKeys.contains(key);

  /// Maps ARB camelCase keys to dot-notation keys.
  static const arbToDotKey = <String, String>{
    'accountCreationError': 'account.creation.error',
    'accountCreationSubmit': 'account.creation.submit',
    'accountCreationSuccess': 'account.creation.success',
    'accountCreationTitle': 'account.creation.title',
    'appTitle': 'app.title',
    'errorAuthFailed': 'error.auth.failed',
    'errorAuthUnauthorized': 'error.auth.unauthorized',
    'errorGeneric': 'error.generic',
    'errorNetwork': 'error.network',
    'errorTimeout': 'error.timeout',
    'labelEmail': 'label.email',
    'labelPassword': 'label.password',
    'labelUsername': 'label.username',
    'ownPostsEmpty': 'own.posts.empty',
    'ownPostsTitle': 'own.posts.title',
    'postCreationError': 'post.creation.error',
    'postCreationSubmit': 'post.creation.submit',
    'postCreationSuccess': 'post.creation.success',
    'postCreationTextHint': 'post.creation.text.hint',
    'postCreationTitle': 'post.creation.title',
    'postCreationTitleHint': 'post.creation.title.hint',
    'validationRequired': 'validation.required',
  };

  /// Maps dot-notation keys to ARB camelCase keys.
  static const dotToArbKey = <String, String>{
    'account.creation.error': 'accountCreationError',
    'account.creation.submit': 'accountCreationSubmit',
    'account.creation.success': 'accountCreationSuccess',
    'account.creation.title': 'accountCreationTitle',
    'app.title': 'appTitle',
    'error.auth.failed': 'errorAuthFailed',
    'error.auth.unauthorized': 'errorAuthUnauthorized',
    'error.generic': 'errorGeneric',
    'error.network': 'errorNetwork',
    'error.timeout': 'errorTimeout',
    'label.email': 'labelEmail',
    'label.password': 'labelPassword',
    'label.username': 'labelUsername',
    'own.posts.empty': 'ownPostsEmpty',
    'own.posts.title': 'ownPostsTitle',
    'post.creation.error': 'postCreationError',
    'post.creation.submit': 'postCreationSubmit',
    'post.creation.success': 'postCreationSuccess',
    'post.creation.text.hint': 'postCreationTextHint',
    'post.creation.title': 'postCreationTitle',
    'post.creation.title.hint': 'postCreationTitleHint',
    'validation.required': 'validationRequired',
  };
}

/// Type-safe constants for all l10n keys.
///
/// Usage:
/// ```dart
/// l10n.translate(L10nKeys.errorTimeout);
/// ```
abstract class L10nKeys {
  static const accountCreationError = 'account.creation.error';
  static const accountCreationSubmit = 'account.creation.submit';
  static const accountCreationSuccess = 'account.creation.success';
  static const accountCreationTitle = 'account.creation.title';
  static const appTitle = 'app.title';
  static const errorAuthFailed = 'error.auth.failed';
  static const errorAuthUnauthorized = 'error.auth.unauthorized';
  static const errorGeneric = 'error.generic';
  static const errorNetwork = 'error.network';
  static const errorTimeout = 'error.timeout';
  static const labelEmail = 'label.email';
  static const labelPassword = 'label.password';
  static const labelUsername = 'label.username';
  static const ownPostsEmpty = 'own.posts.empty';
  static const ownPostsTitle = 'own.posts.title';
  static const postCreationError = 'post.creation.error';
  static const postCreationSubmit = 'post.creation.submit';
  static const postCreationSuccess = 'post.creation.success';
  static const postCreationTextHint = 'post.creation.text.hint';
  static const postCreationTitle = 'post.creation.title';
  static const postCreationTitleHint = 'post.creation.title.hint';
  static const validationRequired = 'validation.required';
}
