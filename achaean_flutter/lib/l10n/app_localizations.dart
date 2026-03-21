import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flutter Template'**
  String get appTitle;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error occurred'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'Operation timed out'**
  String get errorTimeout;

  /// No description provided for @errorAuthUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access'**
  String get errorAuthUnauthorized;

  /// No description provided for @errorAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get errorAuthFailed;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @flagError.
  ///
  /// In en, this message translates to:
  /// **'Failed to flag post'**
  String get flagError;

  /// No description provided for @flagPostSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post flagged'**
  String get flagPostSuccess;

  /// No description provided for @flagRetractSuccess.
  ///
  /// In en, this message translates to:
  /// **'Flag retracted'**
  String get flagRetractSuccess;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get validationRequired;

  /// No description provided for @labelUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get labelUsername;

  /// No description provided for @labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// No description provided for @labelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// No description provided for @accountCreationTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get accountCreationTitle;

  /// No description provided for @accountCreationSubmit.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get accountCreationSubmit;

  /// No description provided for @accountCreationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get accountCreationSuccess;

  /// No description provided for @accountCreationError.
  ///
  /// In en, this message translates to:
  /// **'Failed to create account'**
  String get accountCreationError;

  /// No description provided for @postCreationTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Post'**
  String get postCreationTitle;

  /// No description provided for @postCreationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post published successfully'**
  String get postCreationSuccess;

  /// No description provided for @postCreationError.
  ///
  /// In en, this message translates to:
  /// **'Failed to create post'**
  String get postCreationError;

  /// No description provided for @postCreationTextHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get postCreationTextHint;

  /// No description provided for @postCreationTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get postCreationTitleHint;

  /// No description provided for @postCreationSubmit.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get postCreationSubmit;

  /// No description provided for @ownPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Posts'**
  String get ownPostsTitle;

  /// No description provided for @ownPostsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get ownPostsEmpty;

  /// No description provided for @trustDeclarationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trust declared successfully'**
  String get trustDeclarationSuccess;

  /// No description provided for @trustDeclarationError.
  ///
  /// In en, this message translates to:
  /// **'Failed to declare trust'**
  String get trustDeclarationError;

  /// No description provided for @trustRevocationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Trust revoked'**
  String get trustRevocationSuccess;

  /// No description provided for @polisCreationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Polis created successfully'**
  String get polisCreationSuccess;

  /// No description provided for @polisCreationError.
  ///
  /// In en, this message translates to:
  /// **'Failed to create polis'**
  String get polisCreationError;

  /// No description provided for @polisOperationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Polis operation completed'**
  String get polisOperationSuccess;

  /// No description provided for @polisOperationError.
  ///
  /// In en, this message translates to:
  /// **'Failed to complete polis operation'**
  String get polisOperationError;

  /// No description provided for @inspectionComplete.
  ///
  /// In en, this message translates to:
  /// **'Repo inspection complete'**
  String get inspectionComplete;

  /// No description provided for @inspectionError.
  ///
  /// In en, this message translates to:
  /// **'Failed to inspect repo'**
  String get inspectionError;

  /// No description provided for @queryError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load data. Check your connection and try again.'**
  String get queryError;

  /// No description provided for @accountCreationConnectTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to Git Server'**
  String get accountCreationConnectTitle;

  /// No description provided for @labelGitServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Git server URL'**
  String get labelGitServerUrl;

  /// No description provided for @accountCreationConnect.
  ///
  /// In en, this message translates to:
  /// **'Connect Account'**
  String get accountCreationConnect;

  /// No description provided for @accountCreationSignup.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get accountCreationSignup;

  /// No description provided for @accountCreationConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get accountCreationConnecting;

  /// No description provided for @accountCreationUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://git.example.com'**
  String get accountCreationUrlHint;

  /// No description provided for @labelIndexServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Index server URL'**
  String get labelIndexServerUrl;

  /// No description provided for @indexServerUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://index.example.com'**
  String get indexServerUrlHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
