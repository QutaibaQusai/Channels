import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized sizing system using flutter_screenutil
/// Design base: 375w × 812h (iPhone standard)
class AppSizes {
  AppSizes._();

  // ==================== SPACING ====================

  static double get s2 => 2.w;
  static double get s4 => 4.w;
  static double get s6 => 6.w;
  static double get s8 => 8.w;
  static double get s10 => 10.w;
  static double get s12 => 12.w;
  static double get s14 => 14.w;
  static double get s16 => 16.w;
  static double get s20 => 20.w;
  static double get s24 => 24.w;
  static double get s28 => 28.w;
  static double get s32 => 32.w;
  static double get s40 => 40.w;
  static double get s48 => 48.w;
  static double get s56 => 56.w;
  static double get s64 => 64.w;

  // ==================== BORDER RADIUS ====================

  static double get r4 => 4.r;
  static double get r6 => 6.r;
  static double get r8 => 8.r;
  static double get r10 => 10.r;
  static double get r12 => 12.r;
  static double get r16 => 16.r;
  static double get r20 => 20.r;
  static double get r24 => 24.r;
  static double get rFull => 9999.r;

  // ==================== ICON SIZES ====================

  static double get icon12 => 12.w;
  static double get icon16 => 16.w;
  static double get icon20 => 20.w;
  static double get icon24 => 24.w;
  static double get icon28 => 28.w;
  static double get icon32 => 32.w;
  static double get icon40 => 40.w;
  static double get icon48 => 48.w;

  // ==================== COMPONENT HEIGHTS ====================

  static double get buttonHeightSmall => 36.h;
  static double get buttonHeightMedium => 44.h;
  static double get buttonHeightLarge => 52.h;

  static double get inputHeight => 48.h;
  static double get inputHeightSmall => 40.h;
  static double get inputHeightLarge => 56.h;

  static double get appBarHeight => 56.h;
  static double get bottomNavHeight => 60.h;
  static double get tabBarHeight => 48.h;

  // ==================== CARD SIZES ====================

  static double get adCardHeight => 120.h;
  static double get categoryCardHeight => 100.h;
  static double get channelCardHeight => 90.h;

  // ==================== IMAGE SIZES ====================

  static double get adImageSmall => 80.w;
  static double get adImageMedium => 120.w;
  static double get adImageLarge => 200.w;

  static double get avatarSmall => 32.w;
  static double get avatarMedium => 48.w;
  static double get avatarLarge => 80.w;

  // ==================== ELEVATION ====================

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationMax = 12.0;

  // ==================== MAX WIDTHS ====================

  static double get maxContentWidth => 600.w;
  static double get maxFormWidth => 480.w;
  static double get maxDialogWidth => 360.w;

  // ==================== RESPONSIVE HELPERS ====================

  /// Check if screen is small (< 375w)
  static bool get isSmallScreen => 1.sw < 375;

  /// Check if screen is large (> 600w)
  static bool get isLargeScreen => 1.sw > 600;

  /// Get responsive padding based on screen size
  static double get screenPadding => isLargeScreen ? s24 : s16;
}
