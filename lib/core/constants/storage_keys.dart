/// SharedPreferences keys for local storage
class StorageKeys {
  StorageKeys._();

  // ==================== AUTH ====================

  static const String authToken = 'auth_token';
  static const String userId = 'user_id';
  static const String userPhone = 'user_phone';
  static const String isLoggedIn = 'is_logged_in';

  // ==================== USER PREFERENCES ====================

  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String countryCode = 'country_code';

  // ==================== APP STATE ====================

  static const String onboardingCompleted = 'onboarding_completed';
  static const String firstLaunch = 'first_launch';
  static const String lastAppVersion = 'last_app_version';

  // ==================== DEVICE ====================

  static const String fcmToken = 'fcm_token';
  static const String deviceId = 'device_id';

  // ==================== CACHE ====================

  static const String cachedCategories = 'cached_categories';
  static const String cachedFilters = 'cached_filters';
  static const String lastCategoriesUpdate = 'last_categories_update';
  static const String lastFiltersUpdate = 'last_filters_update';

  // ==================== SEARCH & HISTORY ====================

  static const String searchHistory = 'search_history';
  static const String recentlyViewedAds = 'recently_viewed_ads';

  // ==================== NOTIFICATIONS ====================

  static const String notificationsEnabled = 'notifications_enabled';
  static const String lastNotificationCheck = 'last_notification_check';
}
