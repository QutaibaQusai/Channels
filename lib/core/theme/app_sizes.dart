import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized sizing system using flutter_screenutil
/// Design base: 375w × 812h (iPhone standard)
class AppSizes {
  AppSizes._();

  // ==================== SPACING ====================
  // Used for gaps between elements (vertical/horizontal)
  // Use with spacing helpers: verticalSpace(AppSizes.s16)

  static double get s4 => 4.h;
  static double get s8 => 8.h;
  static double get s12 => 12.h;
  static double get s16 => 16.h;
  static double get s20 => 20.h;
  static double get s24 => 24.h;
  static double get s32 => 32.h;
  static double get s40 => 40.h;
  static double get s48 => 48.h;

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

  // ==================== SCREEN PADDING ====================

  /// Main screen horizontal padding (left & right edges of screens)
  /// Use with SafeArea for best results
  static double get screenPaddingH => 24.w;

  // ==================== COMPONENT HEIGHTS ====================

  static double get buttonHeightSmall => 36.h;
  static double get buttonHeightMedium => 44.h;
  static double get buttonHeightLarge => 52.h;

  static double get inputHeight => 48.h;
  static double get inputHeightSmall => 40.h;
  static double get inputHeightLarge => 56.h;

  // ==================== ELEVATION ====================

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationMax = 12.0;
}
