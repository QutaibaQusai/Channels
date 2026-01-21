class EndPoint {
  static String baseUrl = "https://thedate.to/channels/api/";
  static String countries = "countries";
  static String requestOtp = "auth/request-otp";
  static String verifyOtp = "auth/verify-otp";
  static String updatePreferences = "user/preferences";
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
}
