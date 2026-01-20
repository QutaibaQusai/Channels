import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/services/theme_service.dart';
import 'package:channels/core/constants/storage_keys.dart';

/// Service for managing app language and persistence (Official Flutter approach)
class LanguageService {
  final StorageService _storageService;

  LanguageService(this._storageService);

  /// Get saved language code (ar, en), defaults to English
  Future<String> getSavedLanguageCode() async {
    return _storageService.getString(StorageKeys.languageCode) ?? 'en';
  }

  /// Save language code
  Future<void> saveLanguageCode(String languageCode) async {
    await _storageService.setString(StorageKeys.languageCode, languageCode);
  }

  /// Get locale from language code
  Locale getLocaleFromCode(String code) {
    switch (code) {
      case 'ar':
        return const Locale('ar');
      case 'en':
        return const Locale('en');
      default:
        return const Locale('en');
    }
  }

  /// Get saved locale
  Future<Locale> getSavedLocale() async {
    final code = await getSavedLanguageCode();
    return getLocaleFromCode(code);
  }
}

// ==================== RIVERPOD PROVIDERS ====================

/// Provider for LanguageService
final languageServiceProvider = Provider<LanguageService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  return LanguageService(storageService);
});

/// StateNotifier for managing current locale
class LocaleNotifier extends StateNotifier<Locale> {
  final LanguageService _languageService;

  LocaleNotifier(this._languageService) : super(const Locale('en'));

  /// Initialize and load saved locale
  Future<void> initialize() async {
    final locale = await _languageService.getSavedLocale();
    state = locale;
  }

  /// Change app language
  Future<void> changeLanguage(String languageCode) async {
    final locale = _languageService.getLocaleFromCode(languageCode);
    await _languageService.saveLanguageCode(languageCode);
    state = locale;
  }

  /// Toggle between Arabic and English
  Future<void> toggleLanguage() async {
    final newCode = state.languageCode == 'ar' ? 'en' : 'ar';
    await changeLanguage(newCode);
  }
}

/// Provider for current locale
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  final languageService = ref.watch(languageServiceProvider);
  return LocaleNotifier(languageService);
});
