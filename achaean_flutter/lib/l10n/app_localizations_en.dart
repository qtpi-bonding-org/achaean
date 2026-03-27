// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Template';

  @override
  String get errorNetwork => 'Network error occurred';

  @override
  String get errorTimeout => 'Operation timed out';

  @override
  String get errorAuthUnauthorized => 'Unauthorized access';

  @override
  String get errorAuthFailed => 'Authentication failed';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get flagError => 'Failed to flag post';

  @override
  String get flagPostSuccess => 'Post flagged';

  @override
  String get flagRetractSuccess => 'Flag retracted';

  @override
  String get validationRequired => 'Required';

  @override
  String get labelUsername => 'Username';

  @override
  String get labelEmail => 'Email';

  @override
  String get labelPassword => 'Password';

  @override
  String get accountCreationTitle => 'Create Account';

  @override
  String get accountCreationSubmit => 'Create Account';

  @override
  String get accountCreationSuccess => 'Account created successfully';

  @override
  String get accountCreationError => 'Failed to create account';

  @override
  String get postCreationTitle => 'Create Post';

  @override
  String get postCreationSuccess => 'Post published successfully';

  @override
  String get postCreationError => 'Failed to create post';

  @override
  String get postCreationTextHint => 'What\'s on your mind?';

  @override
  String get postCreationTitleHint => 'Title (optional)';

  @override
  String get postCreationSubmit => 'Publish';

  @override
  String get ownPostsTitle => 'My Posts';

  @override
  String get ownPostsEmpty => 'No posts yet';

  @override
  String get trustDeclarationSuccess => 'Trust declared successfully';

  @override
  String get trustDeclarationError => 'Failed to declare trust';

  @override
  String get trustRevocationSuccess => 'Trust revoked';

  @override
  String get observeDeclarationSuccess => 'Now observing';

  @override
  String get observeDeclarationError => 'Failed to observe';

  @override
  String get observeRevocationSuccess => 'Stopped observing';

  @override
  String get polisCreationSuccess => 'Polis created successfully';

  @override
  String get polisCreationError => 'Failed to create polis';

  @override
  String get polisOperationSuccess => 'Polis operation completed';

  @override
  String get polisOperationError => 'Failed to complete polis operation';

  @override
  String get inspectionComplete => 'Repo inspection complete';

  @override
  String get inspectionError => 'Failed to inspect repo';

  @override
  String get queryError =>
      'Unable to load data. Check your connection and try again.';

  @override
  String get accountCreationConnectTitle => 'Connect to Git Server';

  @override
  String get labelGitServerUrl => 'Git server URL';

  @override
  String get accountCreationConnect => 'Connect Account';

  @override
  String get accountCreationSignup => 'Create Account';

  @override
  String get accountCreationConnecting => 'Connecting...';

  @override
  String get accountCreationUrlHint => 'https://git.example.com';

  @override
  String get labelIndexServerUrl => 'Index server URL';

  @override
  String get indexServerUrlHint => 'https://index.example.com';

  @override
  String get accountCreationGuest => 'Browse as Guest';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get displayNameLabel => 'Display Name';

  @override
  String get displayNameHint => 'How you want to be known';

  @override
  String get bioLabel => 'Bio';

  @override
  String get bioHint => 'A few words about yourself';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get saveProfile => 'Save';

  @override
  String get profileUpdateSuccess => 'Profile updated';

  @override
  String get profileUpdateError => 'Failed to update profile';

  @override
  String get peopleTitle => 'People';

  @override
  String get trustSegment => 'Trust';

  @override
  String get observeSegment => 'Observe';

  @override
  String get outgoingToggle => 'Outgoing';

  @override
  String get incomingToggle => 'Incoming';

  @override
  String get noTrustRelationships => 'No trust relationships yet';

  @override
  String get noObserveRelationships => 'Not observing anyone yet';

  @override
  String get noIncomingTrust => 'Nobody trusts you yet';

  @override
  String get noIncomingObserve => 'Nobody observes you yet';

  @override
  String get trustButton => 'Trust';

  @override
  String get observeButton => 'Observe';

  @override
  String get trustedLabel => 'Trusted';

  @override
  String get observingLabel => 'Observing';

  @override
  String get trustConfirmTitle => 'Vouch for this person?';

  @override
  String get trustConfirmBody =>
      'Trusting someone affects community membership. This is a structural vouch, not just a follow.';

  @override
  String get trustConfirmCancel => 'Cancel';

  @override
  String get trustConfirmAction => 'Confirm';

  @override
  String get nowObserving => 'Now observing';

  @override
  String get stoppedObserving => 'Stopped observing';

  @override
  String get trustDeclared => 'Trust declared';

  @override
  String get trustRevoked => 'Trust revoked';

  @override
  String get copyPubkey => 'Copy pubkey';

  @override
  String get pubkeyCopied => 'Pubkey copied';
}
