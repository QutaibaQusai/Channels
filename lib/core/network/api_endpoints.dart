/// API endpoint paths for Channels backend
class ApiEndpoints {
  ApiEndpoints._();

  // ==================== AUTH ====================

  static const String requestOtp = '/auth/request-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // ==================== USER & DEVICE ====================

  static const String registerDevice = '/device/register';
  static const String updateDevice = '/device/update';
  static const String userPreferences = '/user/preferences';
  static const String userProfile = '/user/profile';

  // ==================== CATEGORIES & FILTERS ====================

  static const String categories = '/categories';
  static String categoryById(String id) => '/categories/$id';
  static String categoryFilters(String id) => '/categories/$id/filters';
  static String subcategories(String parentId) => '/categories/$parentId/subcategories';

  // ==================== ADS ====================

  static const String ads = '/ads';
  static String adById(String id) => '/ads/$id';
  static const String createAd = '/ads';
  static String updateAd(String id) => '/ads/$id';
  static String deleteAd(String id) => '/ads/$id';
  static String similarAds(String id) => '/ads/$id/similar';
  static String userAds(String userId) => '/users/$userId/ads';
  static const String myAds = '/ads/mine';
  static const String searchAds = '/ads/search';

  // ==================== CHANNELS (SUBSCRIPTIONS) ====================

  static const String channels = '/channels';
  static String channelById(String id) => '/channels/$id';
  static const String createChannel = '/channels';
  static String updateChannel(String id) => '/channels/$id';
  static String deleteChannel(String id) => '/channels/$id';
  static String subscribeToSimilar(String adId) => '/ads/$adId/subscribe-similar';
  static String channelFeed(String id) => '/channels/$id/feed';

  // ==================== NOTIFICATIONS ====================

  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  static const String markAllRead = '/notifications/mark-all-read';
  static String deleteNotification(String id) => '/notifications/$id';

  // ==================== REPORTS & FEEDBACK ====================

  static const String reportAd = '/reports';
  static String reportById(String id) => '/reports/$id';
  static const String feedback = '/feedback';

  // ==================== AI ASSISTANT ====================

  static const String aiChat = '/ai/chat';
  static String aiConversation(String conversationId) => '/ai/conversations/$conversationId';
  static const String aiSuggestions = '/ai/suggestions';

  // ==================== MEDIA UPLOAD ====================

  static const String uploadImage = '/media/upload';
  static String deleteImage(String imageId) => '/media/$imageId';
  static const String getUploadUrl = '/media/upload-url';

  // ==================== COUNTRIES & LANGUAGES ====================

  static const String countries = '/countries';
  static const String languages = '/languages';
  static String countryConfig(String countryCode) => '/countries/$countryCode/config';

  // ==================== SEARCH & AUTOCOMPLETE ====================

  static const String autocomplete = '/search/autocomplete';
  static const String searchHistory = '/search/history';
  static const String popularSearches = '/search/popular';

  // ==================== MERCHANT ====================

  static String merchantProfile(String userId) => '/merchants/$userId';
  static String merchantAds(String userId) => '/merchants/$userId/ads';
  static String merchantReviews(String userId) => '/merchants/$userId/reviews';

  // ==================== ANALYTICS (optional) ====================

  static const String trackView = '/analytics/view';
  static const String trackClick = '/analytics/click';
  static const String trackEvent = '/analytics/event';
}
