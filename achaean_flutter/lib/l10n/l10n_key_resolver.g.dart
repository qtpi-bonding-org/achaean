// GENERATED CODE - DO NOT MODIFY BY HAND
// Generator: l10n_key_resolver
// Generated at: 2026-03-27T05:55:29.422594

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
      'agora.empty' => _l10n.agoraEmpty,
      'agora.empty.action' => _l10n.agoraEmptyAction,
      'agora.tab' => _l10n.agoraTab,
      'anonymous' => _l10n.anonymous,
      'app.title' => _l10n.appTitle,
      'bio.hint' => _l10n.bioHint,
      'bio.label' => _l10n.bioLabel,
      'browse.poleis' => _l10n.browsePoleis,
      'connections.title' => _l10n.connectionsTitle,
      'copy.pubkey' => _l10n.copyPubkey,
      'create.polis.button' => _l10n.createPolisButton,
      'create.polis.title' => _l10n.createPolisTitle,
      'display.name.hint' => _l10n.displayNameHint,
      'display.name.label' => _l10n.displayNameLabel,
      'edit.profile' => _l10n.editProfile,
      'error.auth.failed' => _l10n.errorAuthFailed,
      'error.auth.unauthorized' => _l10n.errorAuthUnauthorized,
      'error.generic' => _l10n.errorGeneric,
      'error.network' => _l10n.errorNetwork,
      'error.timeout' => _l10n.errorTimeout,
      'feed.title' => _l10n.feedTitle,
      'flag.error' => _l10n.flagError,
      'flag.post.success' => _l10n.flagPostSuccess,
      'flag.retract.success' => _l10n.flagRetractSuccess,
      'incoming.toggle' => _l10n.incomingToggle,
      'index.server.url.hint' => _l10n.indexServerUrlHint,
      'inspection.complete' => _l10n.inspectionComplete,
      'inspection.error' => _l10n.inspectionError,
      'join.polis' => _l10n.joinPolis,
      'joined.polis' => _l10n.joinedPolis,
      'label.email' => _l10n.labelEmail,
      'label.git.server.url' => _l10n.labelGitServerUrl,
      'label.index.server.url' => _l10n.labelIndexServerUrl,
      'label.password' => _l10n.labelPassword,
      'label.username' => _l10n.labelUsername,
      'leave.polis' => _l10n.leavePolis,
      'no.browse.poleis' => _l10n.noBrowsePoleis,
      'no.incoming.observe' => _l10n.noIncomingObserve,
      'no.incoming.trust' => _l10n.noIncomingTrust,
      'no.joined.poleis' => _l10n.noJoinedPoleis,
      'no.observe.relationships' => _l10n.noObserveRelationships,
      'no.trust.relationships' => _l10n.noTrustRelationships,
      'now.observing' => _l10n.nowObserving,
      'observe.button' => _l10n.observeButton,
      'observe.declaration.error' => _l10n.observeDeclarationError,
      'observe.declaration.success' => _l10n.observeDeclarationSuccess,
      'observe.revocation.success' => _l10n.observeRevocationSuccess,
      'observe.segment' => _l10n.observeSegment,
      'observing.label' => _l10n.observingLabel,
      'outgoing.toggle' => _l10n.outgoingToggle,
      'own.posts.empty' => _l10n.ownPostsEmpty,
      'own.posts.title' => _l10n.ownPostsTitle,
      'people.tab' => _l10n.peopleTab,
      'people.title' => _l10n.peopleTitle,
      'personal.tab' => _l10n.personalTab,
      'polis.creation.error' => _l10n.polisCreationError,
      'polis.creation.success' => _l10n.polisCreationSuccess,
      'polis.description.hint' => _l10n.polisDescriptionHint,
      'polis.description.label' => _l10n.polisDescriptionLabel,
      'polis.join.success' => _l10n.polisJoinSuccess,
      'polis.leave.success' => _l10n.polisLeaveSuccess,
      'polis.name.hint' => _l10n.polisNameHint,
      'polis.name.label' => _l10n.polisNameLabel,
      'polis.norms.hint' => _l10n.polisNormsHint,
      'polis.norms.label' => _l10n.polisNormsLabel,
      'polis.operation.error' => _l10n.polisOperationError,
      'polis.operation.success' => _l10n.polisOperationSuccess,
      'polis.tab' => _l10n.polisTab,
      'post.creation.error' => _l10n.postCreationError,
      'post.creation.submit' => _l10n.postCreationSubmit,
      'post.creation.success' => _l10n.postCreationSuccess,
      'post.creation.text.hint' => _l10n.postCreationTextHint,
      'post.creation.title' => _l10n.postCreationTitle,
      'post.creation.title.hint' => _l10n.postCreationTitleHint,
      'profile.title' => _l10n.profileTitle,
      'profile.update.error' => _l10n.profileUpdateError,
      'profile.update.success' => _l10n.profileUpdateSuccess,
      'pubkey.copied' => _l10n.pubkeyCopied,
      'query.error' => _l10n.queryError,
      'save.profile' => _l10n.saveProfile,
      'select.polis' => _l10n.selectPolis,
      'stopped.observing' => _l10n.stoppedObserving,
      'trust.button' => _l10n.trustButton,
      'trust.confirm.action' => _l10n.trustConfirmAction,
      'trust.confirm.body' => _l10n.trustConfirmBody,
      'trust.confirm.cancel' => _l10n.trustConfirmCancel,
      'trust.confirm.title' => _l10n.trustConfirmTitle,
      'trust.declaration.error' => _l10n.trustDeclarationError,
      'trust.declaration.success' => _l10n.trustDeclarationSuccess,
      'trust.declared' => _l10n.trustDeclared,
      'trust.revocation.success' => _l10n.trustRevocationSuccess,
      'trust.revoked' => _l10n.trustRevoked,
      'trust.segment' => _l10n.trustSegment,
      'trusted.label' => _l10n.trustedLabel,
      'validation.required' => _l10n.validationRequired,
      'view.agora' => _l10n.viewAgora,
      'your.poleis' => _l10n.yourPoleis,

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
    'agora.empty',
    'agora.empty.action',
    'agora.tab',
    'anonymous',
    'app.title',
    'bio.hint',
    'bio.label',
    'browse.poleis',
    'connections.title',
    'copy.pubkey',
    'create.polis.button',
    'create.polis.title',
    'display.name.hint',
    'display.name.label',
    'edit.profile',
    'error.auth.failed',
    'error.auth.unauthorized',
    'error.generic',
    'error.network',
    'error.timeout',
    'feed.title',
    'flag.error',
    'flag.post.success',
    'flag.retract.success',
    'incoming.toggle',
    'index.server.url.hint',
    'inspection.complete',
    'inspection.error',
    'join.polis',
    'joined.polis',
    'label.email',
    'label.git.server.url',
    'label.index.server.url',
    'label.password',
    'label.username',
    'leave.polis',
    'no.browse.poleis',
    'no.incoming.observe',
    'no.incoming.trust',
    'no.joined.poleis',
    'no.observe.relationships',
    'no.trust.relationships',
    'now.observing',
    'observe.button',
    'observe.declaration.error',
    'observe.declaration.success',
    'observe.revocation.success',
    'observe.segment',
    'observing.label',
    'outgoing.toggle',
    'own.posts.empty',
    'own.posts.title',
    'people.tab',
    'people.title',
    'personal.tab',
    'polis.creation.error',
    'polis.creation.success',
    'polis.description.hint',
    'polis.description.label',
    'polis.join.success',
    'polis.leave.success',
    'polis.name.hint',
    'polis.name.label',
    'polis.norms.hint',
    'polis.norms.label',
    'polis.operation.error',
    'polis.operation.success',
    'polis.tab',
    'post.creation.error',
    'post.creation.submit',
    'post.creation.success',
    'post.creation.text.hint',
    'post.creation.title',
    'post.creation.title.hint',
    'profile.title',
    'profile.update.error',
    'profile.update.success',
    'pubkey.copied',
    'query.error',
    'save.profile',
    'select.polis',
    'stopped.observing',
    'trust.button',
    'trust.confirm.action',
    'trust.confirm.body',
    'trust.confirm.cancel',
    'trust.confirm.title',
    'trust.declaration.error',
    'trust.declaration.success',
    'trust.declared',
    'trust.revocation.success',
    'trust.revoked',
    'trust.segment',
    'trusted.label',
    'validation.required',
    'view.agora',
    'your.poleis',
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
    'agoraEmpty': 'agora.empty',
    'agoraEmptyAction': 'agora.empty.action',
    'agoraTab': 'agora.tab',
    'anonymous': 'anonymous',
    'appTitle': 'app.title',
    'bioHint': 'bio.hint',
    'bioLabel': 'bio.label',
    'browsePoleis': 'browse.poleis',
    'connectionsTitle': 'connections.title',
    'copyPubkey': 'copy.pubkey',
    'createPolisButton': 'create.polis.button',
    'createPolisTitle': 'create.polis.title',
    'displayNameHint': 'display.name.hint',
    'displayNameLabel': 'display.name.label',
    'editProfile': 'edit.profile',
    'errorAuthFailed': 'error.auth.failed',
    'errorAuthUnauthorized': 'error.auth.unauthorized',
    'errorGeneric': 'error.generic',
    'errorNetwork': 'error.network',
    'errorTimeout': 'error.timeout',
    'feedTitle': 'feed.title',
    'flagError': 'flag.error',
    'flagPostSuccess': 'flag.post.success',
    'flagRetractSuccess': 'flag.retract.success',
    'incomingToggle': 'incoming.toggle',
    'indexServerUrlHint': 'index.server.url.hint',
    'inspectionComplete': 'inspection.complete',
    'inspectionError': 'inspection.error',
    'joinPolis': 'join.polis',
    'joinedPolis': 'joined.polis',
    'labelEmail': 'label.email',
    'labelGitServerUrl': 'label.git.server.url',
    'labelIndexServerUrl': 'label.index.server.url',
    'labelPassword': 'label.password',
    'labelUsername': 'label.username',
    'leavePolis': 'leave.polis',
    'noBrowsePoleis': 'no.browse.poleis',
    'noIncomingObserve': 'no.incoming.observe',
    'noIncomingTrust': 'no.incoming.trust',
    'noJoinedPoleis': 'no.joined.poleis',
    'noObserveRelationships': 'no.observe.relationships',
    'noTrustRelationships': 'no.trust.relationships',
    'nowObserving': 'now.observing',
    'observeButton': 'observe.button',
    'observeDeclarationError': 'observe.declaration.error',
    'observeDeclarationSuccess': 'observe.declaration.success',
    'observeRevocationSuccess': 'observe.revocation.success',
    'observeSegment': 'observe.segment',
    'observingLabel': 'observing.label',
    'outgoingToggle': 'outgoing.toggle',
    'ownPostsEmpty': 'own.posts.empty',
    'ownPostsTitle': 'own.posts.title',
    'peopleTab': 'people.tab',
    'peopleTitle': 'people.title',
    'personalTab': 'personal.tab',
    'polisCreationError': 'polis.creation.error',
    'polisCreationSuccess': 'polis.creation.success',
    'polisDescriptionHint': 'polis.description.hint',
    'polisDescriptionLabel': 'polis.description.label',
    'polisJoinSuccess': 'polis.join.success',
    'polisLeaveSuccess': 'polis.leave.success',
    'polisNameHint': 'polis.name.hint',
    'polisNameLabel': 'polis.name.label',
    'polisNormsHint': 'polis.norms.hint',
    'polisNormsLabel': 'polis.norms.label',
    'polisOperationError': 'polis.operation.error',
    'polisOperationSuccess': 'polis.operation.success',
    'polisTab': 'polis.tab',
    'postCreationError': 'post.creation.error',
    'postCreationSubmit': 'post.creation.submit',
    'postCreationSuccess': 'post.creation.success',
    'postCreationTextHint': 'post.creation.text.hint',
    'postCreationTitle': 'post.creation.title',
    'postCreationTitleHint': 'post.creation.title.hint',
    'profileTitle': 'profile.title',
    'profileUpdateError': 'profile.update.error',
    'profileUpdateSuccess': 'profile.update.success',
    'pubkeyCopied': 'pubkey.copied',
    'queryError': 'query.error',
    'saveProfile': 'save.profile',
    'selectPolis': 'select.polis',
    'stoppedObserving': 'stopped.observing',
    'trustButton': 'trust.button',
    'trustConfirmAction': 'trust.confirm.action',
    'trustConfirmBody': 'trust.confirm.body',
    'trustConfirmCancel': 'trust.confirm.cancel',
    'trustConfirmTitle': 'trust.confirm.title',
    'trustDeclarationError': 'trust.declaration.error',
    'trustDeclarationSuccess': 'trust.declaration.success',
    'trustDeclared': 'trust.declared',
    'trustRevocationSuccess': 'trust.revocation.success',
    'trustRevoked': 'trust.revoked',
    'trustSegment': 'trust.segment',
    'trustedLabel': 'trusted.label',
    'validationRequired': 'validation.required',
    'viewAgora': 'view.agora',
    'yourPoleis': 'your.poleis',
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
    'agora.empty': 'agoraEmpty',
    'agora.empty.action': 'agoraEmptyAction',
    'agora.tab': 'agoraTab',
    'anonymous': 'anonymous',
    'app.title': 'appTitle',
    'bio.hint': 'bioHint',
    'bio.label': 'bioLabel',
    'browse.poleis': 'browsePoleis',
    'connections.title': 'connectionsTitle',
    'copy.pubkey': 'copyPubkey',
    'create.polis.button': 'createPolisButton',
    'create.polis.title': 'createPolisTitle',
    'display.name.hint': 'displayNameHint',
    'display.name.label': 'displayNameLabel',
    'edit.profile': 'editProfile',
    'error.auth.failed': 'errorAuthFailed',
    'error.auth.unauthorized': 'errorAuthUnauthorized',
    'error.generic': 'errorGeneric',
    'error.network': 'errorNetwork',
    'error.timeout': 'errorTimeout',
    'feed.title': 'feedTitle',
    'flag.error': 'flagError',
    'flag.post.success': 'flagPostSuccess',
    'flag.retract.success': 'flagRetractSuccess',
    'incoming.toggle': 'incomingToggle',
    'index.server.url.hint': 'indexServerUrlHint',
    'inspection.complete': 'inspectionComplete',
    'inspection.error': 'inspectionError',
    'join.polis': 'joinPolis',
    'joined.polis': 'joinedPolis',
    'label.email': 'labelEmail',
    'label.git.server.url': 'labelGitServerUrl',
    'label.index.server.url': 'labelIndexServerUrl',
    'label.password': 'labelPassword',
    'label.username': 'labelUsername',
    'leave.polis': 'leavePolis',
    'no.browse.poleis': 'noBrowsePoleis',
    'no.incoming.observe': 'noIncomingObserve',
    'no.incoming.trust': 'noIncomingTrust',
    'no.joined.poleis': 'noJoinedPoleis',
    'no.observe.relationships': 'noObserveRelationships',
    'no.trust.relationships': 'noTrustRelationships',
    'now.observing': 'nowObserving',
    'observe.button': 'observeButton',
    'observe.declaration.error': 'observeDeclarationError',
    'observe.declaration.success': 'observeDeclarationSuccess',
    'observe.revocation.success': 'observeRevocationSuccess',
    'observe.segment': 'observeSegment',
    'observing.label': 'observingLabel',
    'outgoing.toggle': 'outgoingToggle',
    'own.posts.empty': 'ownPostsEmpty',
    'own.posts.title': 'ownPostsTitle',
    'people.tab': 'peopleTab',
    'people.title': 'peopleTitle',
    'personal.tab': 'personalTab',
    'polis.creation.error': 'polisCreationError',
    'polis.creation.success': 'polisCreationSuccess',
    'polis.description.hint': 'polisDescriptionHint',
    'polis.description.label': 'polisDescriptionLabel',
    'polis.join.success': 'polisJoinSuccess',
    'polis.leave.success': 'polisLeaveSuccess',
    'polis.name.hint': 'polisNameHint',
    'polis.name.label': 'polisNameLabel',
    'polis.norms.hint': 'polisNormsHint',
    'polis.norms.label': 'polisNormsLabel',
    'polis.operation.error': 'polisOperationError',
    'polis.operation.success': 'polisOperationSuccess',
    'polis.tab': 'polisTab',
    'post.creation.error': 'postCreationError',
    'post.creation.submit': 'postCreationSubmit',
    'post.creation.success': 'postCreationSuccess',
    'post.creation.text.hint': 'postCreationTextHint',
    'post.creation.title': 'postCreationTitle',
    'post.creation.title.hint': 'postCreationTitleHint',
    'profile.title': 'profileTitle',
    'profile.update.error': 'profileUpdateError',
    'profile.update.success': 'profileUpdateSuccess',
    'pubkey.copied': 'pubkeyCopied',
    'query.error': 'queryError',
    'save.profile': 'saveProfile',
    'select.polis': 'selectPolis',
    'stopped.observing': 'stoppedObserving',
    'trust.button': 'trustButton',
    'trust.confirm.action': 'trustConfirmAction',
    'trust.confirm.body': 'trustConfirmBody',
    'trust.confirm.cancel': 'trustConfirmCancel',
    'trust.confirm.title': 'trustConfirmTitle',
    'trust.declaration.error': 'trustDeclarationError',
    'trust.declaration.success': 'trustDeclarationSuccess',
    'trust.declared': 'trustDeclared',
    'trust.revocation.success': 'trustRevocationSuccess',
    'trust.revoked': 'trustRevoked',
    'trust.segment': 'trustSegment',
    'trusted.label': 'trustedLabel',
    'validation.required': 'validationRequired',
    'view.agora': 'viewAgora',
    'your.poleis': 'yourPoleis',
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
  static const agoraEmpty = 'agora.empty';
  static const agoraEmptyAction = 'agora.empty.action';
  static const agoraTab = 'agora.tab';
  static const anonymous = 'anonymous';
  static const appTitle = 'app.title';
  static const bioHint = 'bio.hint';
  static const bioLabel = 'bio.label';
  static const browsePoleis = 'browse.poleis';
  static const connectionsTitle = 'connections.title';
  static const copyPubkey = 'copy.pubkey';
  static const createPolisButton = 'create.polis.button';
  static const createPolisTitle = 'create.polis.title';
  static const displayNameHint = 'display.name.hint';
  static const displayNameLabel = 'display.name.label';
  static const editProfile = 'edit.profile';
  static const errorAuthFailed = 'error.auth.failed';
  static const errorAuthUnauthorized = 'error.auth.unauthorized';
  static const errorGeneric = 'error.generic';
  static const errorNetwork = 'error.network';
  static const errorTimeout = 'error.timeout';
  static const feedTitle = 'feed.title';
  static const flagError = 'flag.error';
  static const flagPostSuccess = 'flag.post.success';
  static const flagRetractSuccess = 'flag.retract.success';
  static const incomingToggle = 'incoming.toggle';
  static const indexServerUrlHint = 'index.server.url.hint';
  static const inspectionComplete = 'inspection.complete';
  static const inspectionError = 'inspection.error';
  static const joinPolis = 'join.polis';
  static const joinedPolis = 'joined.polis';
  static const labelEmail = 'label.email';
  static const labelGitServerUrl = 'label.git.server.url';
  static const labelIndexServerUrl = 'label.index.server.url';
  static const labelPassword = 'label.password';
  static const labelUsername = 'label.username';
  static const leavePolis = 'leave.polis';
  static const noBrowsePoleis = 'no.browse.poleis';
  static const noIncomingObserve = 'no.incoming.observe';
  static const noIncomingTrust = 'no.incoming.trust';
  static const noJoinedPoleis = 'no.joined.poleis';
  static const noObserveRelationships = 'no.observe.relationships';
  static const noTrustRelationships = 'no.trust.relationships';
  static const nowObserving = 'now.observing';
  static const observeButton = 'observe.button';
  static const observeDeclarationError = 'observe.declaration.error';
  static const observeDeclarationSuccess = 'observe.declaration.success';
  static const observeRevocationSuccess = 'observe.revocation.success';
  static const observeSegment = 'observe.segment';
  static const observingLabel = 'observing.label';
  static const outgoingToggle = 'outgoing.toggle';
  static const ownPostsEmpty = 'own.posts.empty';
  static const ownPostsTitle = 'own.posts.title';
  static const peopleTab = 'people.tab';
  static const peopleTitle = 'people.title';
  static const personalTab = 'personal.tab';
  static const polisCreationError = 'polis.creation.error';
  static const polisCreationSuccess = 'polis.creation.success';
  static const polisDescriptionHint = 'polis.description.hint';
  static const polisDescriptionLabel = 'polis.description.label';
  static const polisJoinSuccess = 'polis.join.success';
  static const polisLeaveSuccess = 'polis.leave.success';
  static const polisNameHint = 'polis.name.hint';
  static const polisNameLabel = 'polis.name.label';
  static const polisNormsHint = 'polis.norms.hint';
  static const polisNormsLabel = 'polis.norms.label';
  static const polisOperationError = 'polis.operation.error';
  static const polisOperationSuccess = 'polis.operation.success';
  static const polisTab = 'polis.tab';
  static const postCreationError = 'post.creation.error';
  static const postCreationSubmit = 'post.creation.submit';
  static const postCreationSuccess = 'post.creation.success';
  static const postCreationTextHint = 'post.creation.text.hint';
  static const postCreationTitle = 'post.creation.title';
  static const postCreationTitleHint = 'post.creation.title.hint';
  static const profileTitle = 'profile.title';
  static const profileUpdateError = 'profile.update.error';
  static const profileUpdateSuccess = 'profile.update.success';
  static const pubkeyCopied = 'pubkey.copied';
  static const queryError = 'query.error';
  static const saveProfile = 'save.profile';
  static const selectPolis = 'select.polis';
  static const stoppedObserving = 'stopped.observing';
  static const trustButton = 'trust.button';
  static const trustConfirmAction = 'trust.confirm.action';
  static const trustConfirmBody = 'trust.confirm.body';
  static const trustConfirmCancel = 'trust.confirm.cancel';
  static const trustConfirmTitle = 'trust.confirm.title';
  static const trustDeclarationError = 'trust.declaration.error';
  static const trustDeclarationSuccess = 'trust.declaration.success';
  static const trustDeclared = 'trust.declared';
  static const trustRevocationSuccess = 'trust.revocation.success';
  static const trustRevoked = 'trust.revoked';
  static const trustSegment = 'trust.segment';
  static const trustedLabel = 'trusted.label';
  static const validationRequired = 'validation.required';
  static const viewAgora = 'view.agora';
  static const yourPoleis = 'your.poleis';
}
