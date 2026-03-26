// GENERATED CODE - DO NOT MODIFY BY HAND
// Generator: l10n_key_resolver
// Generated at: 2026-03-26T05:56:42.860951

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
      'account.creation.connect' => _l10n.accountCreationConnect,
      'account.creation.connect.title' => _l10n.accountCreationConnectTitle,
      'account.creation.connecting' => _l10n.accountCreationConnecting,
      'account.creation.error' => _l10n.accountCreationError,
      'account.creation.guest' => _l10n.accountCreationGuest,
      'account.creation.signup' => _l10n.accountCreationSignup,
      'account.creation.submit' => _l10n.accountCreationSubmit,
      'account.creation.success' => _l10n.accountCreationSuccess,
      'account.creation.title' => _l10n.accountCreationTitle,
      'account.creation.url.hint' => _l10n.accountCreationUrlHint,
      'app.title' => _l10n.appTitle,
      'error.auth.failed' => _l10n.errorAuthFailed,
      'error.auth.unauthorized' => _l10n.errorAuthUnauthorized,
      'error.generic' => _l10n.errorGeneric,
      'error.network' => _l10n.errorNetwork,
      'error.timeout' => _l10n.errorTimeout,
      'flag.error' => _l10n.flagError,
      'flag.post.success' => _l10n.flagPostSuccess,
      'flag.retract.success' => _l10n.flagRetractSuccess,
      'index.server.url.hint' => _l10n.indexServerUrlHint,
      'inspection.complete' => _l10n.inspectionComplete,
      'inspection.error' => _l10n.inspectionError,
      'label.email' => _l10n.labelEmail,
      'label.git.server.url' => _l10n.labelGitServerUrl,
      'label.index.server.url' => _l10n.labelIndexServerUrl,
      'label.password' => _l10n.labelPassword,
      'label.username' => _l10n.labelUsername,
      'own.posts.empty' => _l10n.ownPostsEmpty,
      'own.posts.title' => _l10n.ownPostsTitle,
      'polis.creation.error' => _l10n.polisCreationError,
      'polis.creation.success' => _l10n.polisCreationSuccess,
      'polis.operation.error' => _l10n.polisOperationError,
      'polis.operation.success' => _l10n.polisOperationSuccess,
      'post.creation.error' => _l10n.postCreationError,
      'post.creation.submit' => _l10n.postCreationSubmit,
      'post.creation.success' => _l10n.postCreationSuccess,
      'post.creation.text.hint' => _l10n.postCreationTextHint,
      'post.creation.title' => _l10n.postCreationTitle,
      'post.creation.title.hint' => _l10n.postCreationTitleHint,
      'query.error' => _l10n.queryError,
      'trust.declaration.error' => _l10n.trustDeclarationError,
      'trust.declaration.success' => _l10n.trustDeclarationSuccess,
      'trust.revocation.success' => _l10n.trustRevocationSuccess,
      'validation.required' => _l10n.validationRequired,

      _ => null,
    };
  }

  /// Set of all known keys (for validation/debugging).
  static const knownKeys = <String>{
    'account.creation.connect',
    'account.creation.connect.title',
    'account.creation.connecting',
    'account.creation.error',
    'account.creation.guest',
    'account.creation.signup',
    'account.creation.submit',
    'account.creation.success',
    'account.creation.title',
    'account.creation.url.hint',
    'app.title',
    'error.auth.failed',
    'error.auth.unauthorized',
    'error.generic',
    'error.network',
    'error.timeout',
    'flag.error',
    'flag.post.success',
    'flag.retract.success',
    'index.server.url.hint',
    'inspection.complete',
    'inspection.error',
    'label.email',
    'label.git.server.url',
    'label.index.server.url',
    'label.password',
    'label.username',
    'own.posts.empty',
    'own.posts.title',
    'polis.creation.error',
    'polis.creation.success',
    'polis.operation.error',
    'polis.operation.success',
    'post.creation.error',
    'post.creation.submit',
    'post.creation.success',
    'post.creation.text.hint',
    'post.creation.title',
    'post.creation.title.hint',
    'query.error',
    'trust.declaration.error',
    'trust.declaration.success',
    'trust.revocation.success',
    'validation.required',
  };

  /// Checks if a key is known to this resolver.
  static bool hasKey(String key) => knownKeys.contains(key);

  /// Maps ARB camelCase keys to dot-notation keys.
  static const arbToDotKey = <String, String>{
    'accountCreationConnect': 'account.creation.connect',
    'accountCreationConnectTitle': 'account.creation.connect.title',
    'accountCreationConnecting': 'account.creation.connecting',
    'accountCreationError': 'account.creation.error',
    'accountCreationGuest': 'account.creation.guest',
    'accountCreationSignup': 'account.creation.signup',
    'accountCreationSubmit': 'account.creation.submit',
    'accountCreationSuccess': 'account.creation.success',
    'accountCreationTitle': 'account.creation.title',
    'accountCreationUrlHint': 'account.creation.url.hint',
    'appTitle': 'app.title',
    'errorAuthFailed': 'error.auth.failed',
    'errorAuthUnauthorized': 'error.auth.unauthorized',
    'errorGeneric': 'error.generic',
    'errorNetwork': 'error.network',
    'errorTimeout': 'error.timeout',
    'flagError': 'flag.error',
    'flagPostSuccess': 'flag.post.success',
    'flagRetractSuccess': 'flag.retract.success',
    'indexServerUrlHint': 'index.server.url.hint',
    'inspectionComplete': 'inspection.complete',
    'inspectionError': 'inspection.error',
    'labelEmail': 'label.email',
    'labelGitServerUrl': 'label.git.server.url',
    'labelIndexServerUrl': 'label.index.server.url',
    'labelPassword': 'label.password',
    'labelUsername': 'label.username',
    'ownPostsEmpty': 'own.posts.empty',
    'ownPostsTitle': 'own.posts.title',
    'polisCreationError': 'polis.creation.error',
    'polisCreationSuccess': 'polis.creation.success',
    'polisOperationError': 'polis.operation.error',
    'polisOperationSuccess': 'polis.operation.success',
    'postCreationError': 'post.creation.error',
    'postCreationSubmit': 'post.creation.submit',
    'postCreationSuccess': 'post.creation.success',
    'postCreationTextHint': 'post.creation.text.hint',
    'postCreationTitle': 'post.creation.title',
    'postCreationTitleHint': 'post.creation.title.hint',
    'queryError': 'query.error',
    'trustDeclarationError': 'trust.declaration.error',
    'trustDeclarationSuccess': 'trust.declaration.success',
    'trustRevocationSuccess': 'trust.revocation.success',
    'validationRequired': 'validation.required',
  };

  /// Maps dot-notation keys to ARB camelCase keys.
  static const dotToArbKey = <String, String>{
    'account.creation.connect': 'accountCreationConnect',
    'account.creation.connect.title': 'accountCreationConnectTitle',
    'account.creation.connecting': 'accountCreationConnecting',
    'account.creation.error': 'accountCreationError',
    'account.creation.guest': 'accountCreationGuest',
    'account.creation.signup': 'accountCreationSignup',
    'account.creation.submit': 'accountCreationSubmit',
    'account.creation.success': 'accountCreationSuccess',
    'account.creation.title': 'accountCreationTitle',
    'account.creation.url.hint': 'accountCreationUrlHint',
    'app.title': 'appTitle',
    'error.auth.failed': 'errorAuthFailed',
    'error.auth.unauthorized': 'errorAuthUnauthorized',
    'error.generic': 'errorGeneric',
    'error.network': 'errorNetwork',
    'error.timeout': 'errorTimeout',
    'flag.error': 'flagError',
    'flag.post.success': 'flagPostSuccess',
    'flag.retract.success': 'flagRetractSuccess',
    'index.server.url.hint': 'indexServerUrlHint',
    'inspection.complete': 'inspectionComplete',
    'inspection.error': 'inspectionError',
    'label.email': 'labelEmail',
    'label.git.server.url': 'labelGitServerUrl',
    'label.index.server.url': 'labelIndexServerUrl',
    'label.password': 'labelPassword',
    'label.username': 'labelUsername',
    'own.posts.empty': 'ownPostsEmpty',
    'own.posts.title': 'ownPostsTitle',
    'polis.creation.error': 'polisCreationError',
    'polis.creation.success': 'polisCreationSuccess',
    'polis.operation.error': 'polisOperationError',
    'polis.operation.success': 'polisOperationSuccess',
    'post.creation.error': 'postCreationError',
    'post.creation.submit': 'postCreationSubmit',
    'post.creation.success': 'postCreationSuccess',
    'post.creation.text.hint': 'postCreationTextHint',
    'post.creation.title': 'postCreationTitle',
    'post.creation.title.hint': 'postCreationTitleHint',
    'query.error': 'queryError',
    'trust.declaration.error': 'trustDeclarationError',
    'trust.declaration.success': 'trustDeclarationSuccess',
    'trust.revocation.success': 'trustRevocationSuccess',
    'validation.required': 'validationRequired',
  };
}

/// Type-safe constants for all l10n keys.
///
/// Usage:
/// ```dart
/// l10n.translate(L10nKeys.errorTimeout);
/// l10n.translate(...L10nKeys.fieldsCount(5));
/// ```
abstract class L10nKeys {
  static const accountCreationConnect = 'account.creation.connect';
  static const accountCreationConnectTitle = 'account.creation.connect.title';
  static const accountCreationConnecting = 'account.creation.connecting';
  static const accountCreationError = 'account.creation.error';
  static const accountCreationGuest = 'account.creation.guest';
  static const accountCreationSignup = 'account.creation.signup';
  static const accountCreationSubmit = 'account.creation.submit';
  static const accountCreationSuccess = 'account.creation.success';
  static const accountCreationTitle = 'account.creation.title';
  static const accountCreationUrlHint = 'account.creation.url.hint';
  static const appTitle = 'app.title';
  static const errorAuthFailed = 'error.auth.failed';
  static const errorAuthUnauthorized = 'error.auth.unauthorized';
  static const errorGeneric = 'error.generic';
  static const errorNetwork = 'error.network';
  static const errorTimeout = 'error.timeout';
  static const flagError = 'flag.error';
  static const flagPostSuccess = 'flag.post.success';
  static const flagRetractSuccess = 'flag.retract.success';
  static const indexServerUrlHint = 'index.server.url.hint';
  static const inspectionComplete = 'inspection.complete';
  static const inspectionError = 'inspection.error';
  static const labelEmail = 'label.email';
  static const labelGitServerUrl = 'label.git.server.url';
  static const labelIndexServerUrl = 'label.index.server.url';
  static const labelPassword = 'label.password';
  static const labelUsername = 'label.username';
  static const ownPostsEmpty = 'own.posts.empty';
  static const ownPostsTitle = 'own.posts.title';
  static const polisCreationError = 'polis.creation.error';
  static const polisCreationSuccess = 'polis.creation.success';
  static const polisOperationError = 'polis.operation.error';
  static const polisOperationSuccess = 'polis.operation.success';
  static const postCreationError = 'post.creation.error';
  static const postCreationSubmit = 'post.creation.submit';
  static const postCreationSuccess = 'post.creation.success';
  static const postCreationTextHint = 'post.creation.text.hint';
  static const postCreationTitle = 'post.creation.title';
  static const postCreationTitleHint = 'post.creation.title.hint';
  static const queryError = 'query.error';
  static const trustDeclarationError = 'trust.declaration.error';
  static const trustDeclarationSuccess = 'trust.declaration.success';
  static const trustRevocationSuccess = 'trust.revocation.success';
  static const validationRequired = 'validation.required';
}
