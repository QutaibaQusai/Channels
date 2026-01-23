import 'package:flutter/material.dart';

/// Private design tokens - DO NOT import in UI widgets
/// Only used by AppTheme to build ColorScheme and extensions
///
/// These are the raw color values extracted from your existing design.
/// They preserve your exact light mode colors that look perfect in OTP screen.
class AppColorTokens {
  AppColorTokens._(); // Private constructor

  // ==================== BRAND COLORS ====================

  /// Primary brand color - Pure Black
  static const Color brandPrimary = Color(0xFF000000);
  static const Color brandPrimaryLight = Color(0xFF333333);

  /// Secondary brand color - Pure White
  static const Color brandSecondary = Color(0xFFFFFFFF);
  static const Color brandSecondaryLight = Color(0xFFFAFAFA);

  // ==================== NEUTRALS (Light Mode) ====================

  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralBlack = Color(0xFF000000);

  /// Light mode backgrounds
  static const Color neutral50 = Color(0xFFF5F5F5); // Main background
  static const Color neutral100 = Color(0xFFF0F0F0); // Secondary surfaces
  static const Color neutral200 = Color(0xFFF0F0F0); // Subtle dividers
  static const Color neutral300 = Color(0xFFE5E5E5); // Borders

  /// Light mode text colors
  static const Color neutral900 = Color(0xFF1A1A1A); // Primary text
  static const Color neutral600 = Color(0xFF666666); // Secondary text
  static const Color neutral500 = Color(0xFF999999); // Tertiary text
  static const Color neutral400 = Color(0xFFB8B8B8); // Hint text
  static const Color neutral350 = Color(0xFFCCCCCC); // Disabled text

  // ==================== NEUTRALS (Dark Mode) ====================

  /// Dark mode backgrounds
  static const Color dark950 = Color(0xFF0D0D0D); // Main background
  static const Color dark900 = Color(0xFF1A1A1A); // Surface
  static const Color dark800 = Color(0xFF2C2C2C); // Secondary surface
  static const Color dark700 = Color(0xFF333333); // Borders

  /// Dark mode text colors
  static const Color dark50 = Color(0xFFF5F5F5); // Primary text
  static const Color dark200 = Color(0xFFB8B8B8); // Secondary text
  static const Color dark300 = Color(0xFF8E8E8E); // Tertiary text
  static const Color dark400 = Color(0xFF666666); // Hint text
  static const Color dark500 = Color(0xFF5C5C5C); // Disabled text

  // ==================== STATUS COLORS ====================

  /// Error states
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFEF5350);

  /// Success states (for future use)
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF66BB6A);

  /// Warning states (for future use)
  static const Color warning = Color(0xFFFF9800);
  static const Color warningDark = Color(0xFFFFB74D);

  /// Info states (for future use)
  static const Color info = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF42A5F5);
}
