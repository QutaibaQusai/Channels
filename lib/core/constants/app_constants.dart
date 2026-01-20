/// Application-wide constants
class AppConstants {
  AppConstants._();

  // ==================== APP INFO ====================

  static const String appName = 'Channels';
  static const String appPackage = 'com.channels.app';
  static const String appVersion = '1.0.0';

  // ==================== API ====================

  static const String apiBaseUrl = 'https://api.channels.com/v1';
  static const int apiTimeout = 30000; // 30 seconds
  static const int apiMaxRetries = 3;

  // ==================== PAGINATION ====================

  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  static const int adsPerPage = 20;
  static const int categoriesPerPage = 30;

  // ==================== VALIDATION ====================

  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;

  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 1000;

  static const int maxImageCount = 5;
  static const int maxImageSizeMB = 5;

  static const int otpLength = 6;
  static const int otpExpiryMinutes = 5;

  // ==================== DESIGN BASE (for ScreenUtil) ====================

  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  // ==================== CACHE DURATION ====================

  static const Duration categoriesCacheDuration = Duration(hours: 24);
  static const Duration filtersCacheDuration = Duration(hours: 12);
  static const Duration adsCacheDuration = Duration(minutes: 5);

  // ==================== NOTIFICATION ====================

  static const String fcmTopic = 'all_users';
  static const int maxNotificationHistory = 100;

  // ==================== SEARCH ====================

  static const int minSearchQueryLength = 2;
  static const int maxSearchHistoryItems = 10;

  // ==================== AD POSTING ====================

  static const int maxAdPostsPerDay = 10;
  static const int minAdRepostHours = 24;
}
