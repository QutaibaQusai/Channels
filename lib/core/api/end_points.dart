class EndPoint {
  static String baseUrl = "https://thedate.to/channels/api/";
  static String countries = "countries";
  static String categories = "categories";
  static String subcategories(String categoryId) => "categories/$categoryId";
  static String filters(String categoryId) => "categories/$categoryId/filters";
  static String requestOtp = "auth/request-otp";
  static String verifyOtp = "auth/verify-otp";
  static String updatePreferences = "user/preferences";
  static String categoryAds(String categoryId) => "ads/category/$categoryId";
  static String adDetails(String adId) => "ads/details/$adId";
  static String userProfile(String userId) => "user/$userId";
  static String createAd = "ads";
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";

  // Country keys
  static String code = "code";
  static String name = "name";
  static String dialingCode = "dialing_code";
  static String placeholder = "placeholder";
  static String flagUrl = "flag_url";
  static String parentId = "parent_id";
  static String lang = "lang";
  static String heroImg = "hero_img";
  static String imageUrl = "image_url";
  static String count = "count";
  static String categories = "categories";
  static String countries = "countries";
  static String country = "country";
  static String sortOrder = "sort_order";

  // OTP keys
  static String phone = "phone";
  static String countryCode = "country_code";
  static String message = "message";
  static String otp = "otp";

  // Auth keys
  static String token = "token";
  static String user = "user";
  static String id = "id";
  static String languageCode = "language_code";
  static String dateOfBirth = "day-of-dirth";

  // Ad keys
  static String userId = "user_id";
  static String categoryId = "category_id";
  static String subcategoryId = "subcategory_id";
  static String title = "title";
  static String description = "description";
  static String images = "images";
  static String attributes = "attributes";
  static String amount = "amount";
  static String price = "price";
  static String priceAmount = "price_amount";
  static String priceCurrency = "price_currency";
  static String adStatus = "status";
  static String reportCount = "report_count";
  static String createdAt = "created_at";
  static String phoneE164 = "phone_e164";

  // Ad Details extra keys
  static String userName = "user_name";
  static String categoryName = "category_name";
  static String subcategoryName = "subcategory_name";

  // Profile extra keys
  static String isMe = "is_me";

  // Filter keys
  static String filters = "filters";
  static String key = "key";
  static String type = "type";
  static String label = "label";
  static String options = "options";
  static String validation = "validation";
  static String value = "value";
}
