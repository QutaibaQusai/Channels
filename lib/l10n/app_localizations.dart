import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// Skip button text
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// Get started button text
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get commonGetStarted;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Done button text
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// Country picker dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get countryPickerTitle;

  /// Country picker search field hint
  ///
  /// In en, this message translates to:
  /// **'Search country...'**
  String get countryPickerSearchHint;

  /// Country picker no results message
  ///
  /// In en, this message translates to:
  /// **'No countries found'**
  String get countryPickerNoResults;

  /// Country picker error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load countries'**
  String get countryPickerError;

  /// Country picker loading message
  ///
  /// In en, this message translates to:
  /// **'Loading countries...'**
  String get countryPickerLoading;

  /// Phone authentication screen title
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneAuthTitle;

  /// Phone authentication screen subtitle
  ///
  /// In en, this message translates to:
  /// **'We\'ll send you a verification code to confirm your number'**
  String get phoneAuthSubtitle;

  /// Send OTP button text
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get phoneAuthSendButton;

  /// Empty phone number error
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get phoneAuthErrorEmpty;

  /// Invalid phone number error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get phoneAuthErrorInvalid;

  /// OTP sent success message
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully!'**
  String get phoneAuthOtpSent;

  /// OTP verification screen title
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otpVerificationTitle;

  /// OTP verification screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to'**
  String get otpVerificationSubtitle;

  /// Verify button text
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpVerificationVerifyButton;

  /// Resend code button text
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get otpVerificationResendCode;

  /// Resend timer text with countdown
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}s'**
  String otpVerificationResendTimer(int seconds);

  /// Incomplete OTP error
  ///
  /// In en, this message translates to:
  /// **'Please enter the complete code'**
  String get otpVerificationErrorIncomplete;

  /// Search hint text for categories screen
  ///
  /// In en, this message translates to:
  /// **'Search categories'**
  String get categoriesSearchHint;

  /// Section title for categories grid
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesSectionTitle;

  /// See more link on categories section
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get categoriesSeeMore;

  /// Phone verification success message
  ///
  /// In en, this message translates to:
  /// **'Phone number verified successfully!'**
  String get otpVerificationVerified;

  /// OTP resent success message
  ///
  /// In en, this message translates to:
  /// **'Code resent successfully!'**
  String get otpVerificationOtpResent;

  /// Registration screen title
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get registerTitle;

  /// Registration screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit about yourself'**
  String get registerSubtitle;

  /// Name field label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get registerNameLabel;

  /// Name field placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get registerNamePlaceholder;

  /// Name required error
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get registerNameRequired;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get registerDateOfBirthLabel;

  /// Date of birth field placeholder
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get registerDateOfBirthPlaceholder;

  /// Date of birth required error
  ///
  /// In en, this message translates to:
  /// **'Date of birth is required'**
  String get registerDateOfBirthRequired;

  /// Complete registration button text
  ///
  /// In en, this message translates to:
  /// **'Complete Registration'**
  String get registerButton;

  /// Onboarding page 1 title
  ///
  /// In en, this message translates to:
  /// **'Your Personal Ad Channel'**
  String get onboardingPage1Title;

  /// Onboarding page 1 subtitle
  ///
  /// In en, this message translates to:
  /// **'Subscribe to categories that matter to you and get instant notifications for new ads'**
  String get onboardingPage1Subtitle;

  /// Onboarding page 2 title
  ///
  /// In en, this message translates to:
  /// **'Create Channels, Stay Updated'**
  String get onboardingPage2Title;

  /// Onboarding page 2 subtitle
  ///
  /// In en, this message translates to:
  /// **'Pick your favorite categories and set filters to receive only the ads you care about'**
  String get onboardingPage2Subtitle;

  /// Onboarding page 3 title
  ///
  /// In en, this message translates to:
  /// **'Post Ads in Seconds'**
  String get onboardingPage3Title;

  /// Onboarding page 3 subtitle
  ///
  /// In en, this message translates to:
  /// **'Snap a few photos, add details, and reach thousands of potential buyers instantly'**
  String get onboardingPage3Subtitle;

  /// Broadcasts tab title in main layout
  ///
  /// In en, this message translates to:
  /// **'Broadcasts'**
  String get layoutBroadcastsTitle;

  /// Categories tab title in main layout
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get layoutCategoriesTitle;

  /// AI tab title in main layout
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get layoutAiTitle;

  /// Ad details screen title
  ///
  /// In en, this message translates to:
  /// **'Ad Details'**
  String get adDetailsTitle;

  /// Attributes/specifications section title
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get adDetailsAttributes;

  /// Call button text
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get adDetailsCall;

  /// WhatsApp button text
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get adDetailsWhatsApp;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileTitle;

  /// No description provided for @profileStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get profileStatusActive;

  /// No description provided for @profileStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get profileStatusInactive;

  /// No description provided for @profileCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get profileCountry;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get profileDateOfBirth;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get profileMemberSince;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsThemeDark;

  /// No description provided for @settingsDoNotDisturb.
  ///
  /// In en, this message translates to:
  /// **'Do Not Disturb'**
  String get settingsDoNotDisturb;

  /// No description provided for @settingsDoNotDisturbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pause notifications temporarily'**
  String get settingsDoNotDisturbSubtitle;

  /// No description provided for @settingsHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsHelpCenter;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTermsOfService;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get settingsSignOut;

  /// No description provided for @profileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Data'**
  String get profileEditTitle;

  /// No description provided for @profileEditName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileEditName;

  /// No description provided for @profileEditPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profileEditPhone;

  /// No description provided for @profileEditContactSupportPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact support to change phone number'**
  String get profileEditContactSupportPhone;

  /// No description provided for @profileEditSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get profileEditSave;

  /// No description provided for @profileEditDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileEditDeleteAccount;

  /// No description provided for @profileEditUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileEditUpdateSuccess;

  /// No description provided for @profileEditUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileEditUpdateError;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout from this device?'**
  String get logoutConfirmation;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @logoutCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get logoutCancel;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone.'**
  String get deleteAccountConfirmation;

  /// No description provided for @deleteAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAccountButton;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
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
