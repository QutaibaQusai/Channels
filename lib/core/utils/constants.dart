/// Application constants
class AppConstants {
  AppConstants._();

  // ==================== API ====================

  static const String apiBaseUrl = 'https://api.example.com/v1';
  static const int apiTimeout = 30000; // 30 seconds

  // ==================== STORAGE KEYS ====================

  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String onboardingKey = 'onboarding_completed';

  // ==================== VALIDATION ====================

  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // ==================== PAGINATION ====================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
