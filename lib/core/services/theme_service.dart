import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:channels/core/services/storage_service.dart';
import 'package:channels/core/constants/storage_keys.dart';

/// Theme service for managing theme mode persistence
class ThemeService {
  final StorageService _storageService;

  ThemeService(this._storageService);

  /// Get saved theme mode
  ThemeMode getSavedThemeMode() {
    final savedTheme = _storageService.getString(StorageKeys.themeMode);

    if (savedTheme == null) {
      return ThemeMode.system;
    }

    switch (savedTheme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Save theme mode
  Future<void> saveThemeMode(ThemeMode mode) async {
    String themeString;

    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }

    await _storageService.setString(StorageKeys.themeMode, themeString);
  }
}

// ==================== RIVERPOD PROVIDERS ====================

final storageServiceProvider = Provider<StorageService>((ref) {
  throw UnimplementedError('StorageService must be overridden in main.dart');
});

final themeServiceProvider = Provider<ThemeService>((ref) {
  return ThemeService(ref.watch(storageServiceProvider));
});

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.watch(themeServiceProvider));
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final ThemeService _themeService;

  ThemeModeNotifier(this._themeService) : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    state = _themeService.getSavedThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _themeService.saveThemeMode(mode);
  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }
}
