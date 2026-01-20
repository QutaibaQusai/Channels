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
