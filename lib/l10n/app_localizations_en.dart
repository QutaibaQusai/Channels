// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonNext => 'Next';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonGetStarted => 'Get Started';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDone => 'Done';

  @override
  String get countryPickerTitle => 'Select Country';

  @override
  String get countryPickerSearchHint => 'Search country...';

  @override
  String get countryPickerNoResults => 'No countries found';

  @override
  String get countryPickerError => 'Failed to load countries';

  @override
  String get countryPickerLoading => 'Loading countries...';

  @override
  String get phoneAuthTitle => 'Enter your phone number';

  @override
  String get phoneAuthSubtitle =>
      'We\'ll send you a verification code to confirm your number';

  @override
  String get phoneAuthSendButton => 'Send OTP';

  @override
  String get phoneAuthErrorEmpty => 'Please enter your phone number';

  @override
  String get phoneAuthErrorInvalid => 'Please enter a valid phone number';

  @override
  String get phoneAuthOtpSent => 'OTP sent successfully!';

  @override
  String get otpVerificationTitle => 'Verify your number';

  @override
  String get otpVerificationSubtitle => 'Enter the code sent to';

  @override
  String get otpVerificationVerifyButton => 'Verify';

  @override
  String get otpVerificationResendCode => 'Resend Code';

  @override
  String otpVerificationResendTimer(int seconds) {
    return 'Resend code in ${seconds}s';
  }

  @override
  String get otpVerificationErrorIncomplete => 'Please enter the complete code';

  @override
  String get otpVerificationVerified => 'Phone number verified successfully!';

  @override
  String get otpVerificationOtpResent => 'Code resent successfully!';

  @override
  String get registerTitle => 'Complete Your Profile';

  @override
  String get registerSubtitle => 'Tell us a bit about yourself';

  @override
  String get registerNameLabel => 'Name';

  @override
  String get registerNamePlaceholder => 'Enter your name';

  @override
  String get registerNameRequired => 'Name is required';

  @override
  String get registerDateOfBirthLabel => 'Date of Birth';

  @override
  String get registerDateOfBirthPlaceholder => 'Select your date of birth';

  @override
  String get registerDateOfBirthRequired => 'Date of birth is required';

  @override
  String get registerButton => 'Complete Registration';

  @override
  String get onboardingPage1Title => 'Your Personal Ad Channel';

  @override
  String get onboardingPage1Subtitle =>
      'Subscribe to categories that matter to you and get instant notifications for new ads';

  @override
  String get onboardingPage2Title => 'Create Channels, Stay Updated';

  @override
  String get onboardingPage2Subtitle =>
      'Pick your favorite categories and set filters to receive only the ads you care about';

  @override
  String get onboardingPage3Title => 'Post Ads in Seconds';

  @override
  String get onboardingPage3Subtitle =>
      'Snap a few photos, add details, and reach thousands of potential buyers instantly';

  @override
  String get layoutBroadcastsTitle => 'Broadcasts';

  @override
  String get layoutExploreTitle => 'Explore';

  @override
  String get layoutAiTitle => 'AI Assistant';
}
