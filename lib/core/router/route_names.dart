/// Centralized route names for type-safe navigation
class RouteNames {
  RouteNames._();

  // ==================== SPLASH & ONBOARDING ====================
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';

  // ==================== AUTH ====================
  static const String login = '/login';
  static const String signup = '/signup';
  static const String phoneAuth = '/phone-auth';
  static const String countryPicker = '/country-picker';
  static const String otpVerification = '/otp-verification';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // ==================== MAIN APP ====================
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // ==================== FEATURE EXAMPLE ====================
  static const String featureList = '/features';
  static const String featureDetail = '/features/:id';
}
