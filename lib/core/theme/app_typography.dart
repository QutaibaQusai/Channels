import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_colors.dart';

/// Centralized typography system using flutter_screenutil
class AppTypography {
  AppTypography._();

  // ==================== FONT WEIGHTS ====================

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // ==================== ONBOARDING STYLES ====================

  /// Onboarding page title style (centered, bold)
  static TextStyle onboardingTitle = TextStyle(
    fontSize: 20.sp,
    fontWeight: bold,
    height: 1.3,
    color: AppColors.textPrimaryLight,
  );

  /// Onboarding page subtitle/description style (centered, secondary color)
  static TextStyle onboardingSubtitle = TextStyle(
    fontSize: 14.sp,
    fontWeight: regular,
    height: 1.4,
    color: AppColors.textSecondaryLight,
  );

  // ==================== APP BAR STYLES ====================

  /// App bar title style (centered, semi-bold)
  static TextStyle appBarTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: semiBold,
    color: AppColors.textPrimaryLight,
  );

  // ==================== BUTTON STYLES ====================

  /// Button text style (used in AppButton widget)
  static TextStyle buttonText = TextStyle(
    fontSize: 16.sp,
    fontWeight: semiBold,
    letterSpacing: 0.5,
  );

  // ==================== DISPLAY STYLES ====================

  static TextStyle displayLarge = TextStyle(
    fontSize: 57.sp,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 45.sp,
    fontWeight: bold,
    height: 1.2,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 36.sp,
    fontWeight: semiBold,
    height: 1.2,
  );

  // ==================== HEADLINE STYLES ====================

  static TextStyle headlineLarge = TextStyle(
    fontSize: 32.sp,
    fontWeight: semiBold,
    height: 1.25,
  );

  static TextStyle headlineMedium = TextStyle(
    fontSize: 28.sp,
    fontWeight: semiBold,
    height: 1.3,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: 24.sp,
    fontWeight: semiBold,
    height: 1.3,
  );

  // ==================== TITLE STYLES ====================

  static TextStyle titleLarge = TextStyle(
    fontSize: 22.sp,
    fontWeight: medium,
    height: 1.4,
  );

  static TextStyle titleMedium = TextStyle(
    fontSize: 18.sp,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = TextStyle(
    fontSize: 16.sp,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // ==================== BODY STYLES ====================

  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: 0.4,
  );

  // ==================== LABEL STYLES ====================

  static TextStyle labelLarge = TextStyle(
    fontSize: 14.sp,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ==================== BUTTON STYLES ====================

  static TextStyle buttonLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: semiBold,
    letterSpacing: 0.5,
  );

  static TextStyle buttonMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: semiBold,
    letterSpacing: 0.4,
  );

  static TextStyle buttonSmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: semiBold,
    letterSpacing: 0.3,
  );
}
