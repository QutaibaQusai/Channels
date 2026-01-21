import 'package:flutter/material.dart';

/// Official Flutter localization class following clean architecture
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Helper method to access AppLocalizations from context
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Localization delegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  /// Get translations map based on current locale
  Map<String, dynamic> get _translations {
    switch (locale.languageCode) {
      case 'ar':
        return _arabicTranslations;
      case 'en':
      default:
        return _englishTranslations;
    }
  }

  /// Translate a key (supports nested keys like 'common.next')
  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _translations;

    for (final k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Return key if translation not found
      }
    }

    return value?.toString() ?? key;
  }

  // ==================== ENGLISH TRANSLATIONS ====================

  static const Map<String, dynamic> _englishTranslations = {
    'common': {
      'next': 'Next',
      'skip': 'Skip',
      'getStarted': 'Get Started',
      'cancel': 'Cancel',
      'done': 'Done',
    },
    'countryPicker': {
      'title': 'Select Country',
      'searchHint': 'Search country...',
      'noResults': 'No countries found',
      'error': 'Failed to load countries',
      'loading': 'Loading countries...',
    },
    'phoneAuth': {
      'title': 'Enter your phone number',
      'subtitle': 'We\'ll send you a verification code to confirm your number',
      'sendButton': 'Send OTP',
      'errorEmpty': 'Please enter your phone number',
      'errorInvalid': 'Please enter a valid phone number',
      'otpSent': 'OTP sent successfully!',
    },
    'otpVerification': {
      'title': 'Verify your number',
      'subtitle': 'Enter the code sent to',
      'verifyButton': 'Verify',
      'resendCode': 'Resend Code',
      'resendTimer': 'Resend code in {seconds}s',
      'errorIncomplete': 'Please enter the complete code',
      'verified': 'Phone number verified successfully!',
      'otpResent': 'Code resent successfully!',
    },
    'register': {
      'title': 'Complete Your Profile',
      'subtitle': 'Tell us a bit about yourself',
      'nameLabel': 'Name',
      'namePlaceholder': 'Enter your name',
      'nameRequired': 'Name is required',
      'dateOfBirthLabel': 'Date of Birth',
      'dateOfBirthPlaceholder': 'Select your date of birth',
      'dateOfBirthRequired': 'Date of birth is required',
      'registerButton': 'Complete Registration',
    },
    'onboarding': {
      'page1': {
        'title': 'Your Personal Ad Channel',
        'subtitle':
            'Subscribe to categories that matter to you and get instant notifications for new ads',
      },
      'page2': {
        'title': 'Create Channels, Stay Updated',
        'subtitle':
            'Pick your favorite categories and set filters to receive only the ads you care about',
      },
      'page3': {
        'title': 'Post Ads in Seconds',
        'subtitle':
            'Snap a few photos, add details, and reach thousands of potential buyers instantly',
      },
    },
  };

  // ==================== ARABIC TRANSLATIONS ====================

  static const Map<String, dynamic> _arabicTranslations = {
    'common': {
      'next': 'التالي',
      'skip': 'تخطي',
      'getStarted': 'ابدأ الآن',
      'cancel': 'إلغاء',
      'done': 'تم',
    },
    'countryPicker': {
      'title': 'اختر الدولة',
      'searchHint': 'ابحث عن دولة...',
      'noResults': 'لم يتم العثور على دول',
      'error': 'فشل تحميل الدول',
      'loading': 'جاري تحميل الدول...',
    },
    'phoneAuth': {
      'title': 'أدخل رقم هاتفك',
      'subtitle': 'سنرسل لك رمز تحقق لتأكيد رقمك',
      'sendButton': 'إرسال رمز التحقق',
      'errorEmpty': 'الرجاء إدخال رقم هاتفك',
      'errorInvalid': 'الرجاء إدخال رقم هاتف صحيح',
      'otpSent': 'تم إرسال رمز التحقق بنجاح!',
    },
    'otpVerification': {
      'title': 'تحقق من رقمك',
      'subtitle': 'أدخل الرمز المرسل إلى',
      'verifyButton': 'تحقق',
      'resendCode': 'إعادة إرسال الرمز',
      'resendTimer': 'إعادة الإرسال بعد {seconds} ثانية',
      'errorIncomplete': 'الرجاء إدخال الرمز كاملاً',
      'verified': 'تم التحقق من رقم الهاتف بنجاح!',
      'otpResent': 'تم إعادة إرسال الرمز بنجاح!',
    },
    'register': {
      'title': 'أكمل ملفك الشخصي',
      'subtitle': 'أخبرنا قليلاً عن نفسك',
      'nameLabel': 'الاسم',
      'namePlaceholder': 'أدخل اسمك',
      'nameRequired': 'الاسم مطلوب',
      'dateOfBirthLabel': 'تاريخ الميلاد',
      'dateOfBirthPlaceholder': 'اختر تاريخ ميلادك',
      'dateOfBirthRequired': 'تاريخ الميلاد مطلوب',
      'registerButton': 'إكمال التسجيل',
    },
    'onboarding': {
      'page1': {
        'title': 'قناتك الشخصية للإعلانات',
        'subtitle':
            'اشترك في الفئات التي تهمك واحصل على إشعارات فورية للإعلانات الجديدة',
      },
      'page2': {
        'title': 'أنشئ قنوات، ابقَ على اطلاع',
        'subtitle':
            'اختر فئاتك المفضلة وحدد الفلاتر لتستقبل فقط الإعلانات التي تهمك',
      },
      'page3': {
        'title': 'انشر إعلانات في ثوانٍ',
        'subtitle':
            'التقط بعض الصور، أضف التفاصيل، وتواصل مع آلاف المشترين المحتملين فوراً',
      },
    },
  };
}

// ==================== LOCALIZATION DELEGATE ====================

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Return immediately - no async loading needed for hardcoded translations
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// ==================== EXTENSION FOR EASY ACCESS ====================

/// Extension to make translations easier: 'common.next'.tr(context)
extension LocalizationExtension on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
