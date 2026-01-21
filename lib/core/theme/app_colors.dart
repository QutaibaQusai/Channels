import 'package:flutter/material.dart';

/// Centralized color palette for Channels app
/// Light and dark mode colors are opposite/inverted but matching in purpose
class AppColors {
  AppColors._();

  // ==================== PRIMARY BRAND COLORS ====================

  /// Primary Brand Color - Pure Black
  static const Color primary = Color(0xFF000000);
  static const Color primaryLight = Color(0xFF333333);
  static const Color primaryDark = Color(0xFF000000);

  /// Secondary Brand Color - Pure White
  static const Color secondary = Color(0xFFFFFFFF);
  static const Color secondaryLight = Color(0xFFFAFAFA);

  // ==================== LIGHT MODE COLORS ====================

  /// Backgrounds - Light theme
  static const Color backgroundLight = Color(0xFFFAFAFA); // Main screen background
  static const Color surfaceLight = Color(0xFFFFFFFF); // Cards, containers
  static const Color surfaceSecondaryLight = Color(0xFFF5F5F5); // Icon circles, elevated elements

  /// Text colors - Light theme (dark text on light background)
  static const Color textPrimaryLight = Color(0xFF1A1A1A); // Main headings, important text
  static const Color textSecondaryLight = Color(0xFF666666); // Body text, descriptions
  static const Color textTertiaryLight = Color(0xFF999999); // Less important text
  static const Color textDisabledLight = Color(0xFFCCCCCC); // Disabled buttons, inactive states
  static const Color textHintLight = Color(0xFFB8B8B8); // Placeholder text, hints

  /// Borders and dividers - Light theme
  static const Color dividerLight = Color(0xFFF0F0F0); // Subtle dividers
  static const Color borderLight = Color(0xFFE5E5E5); // Input borders, card borders

  // ==================== DARK MODE COLORS ====================

  /// Backgrounds - Dark theme (opposite of light)
  static const Color backgroundDark = Color(0xFF0D0D0D); // Main screen background
  static const Color surfaceDark = Color(0xFF1A1A1A); // Cards, containers
  static const Color surfaceSecondaryDark = Color(0xFF2C2C2C); // Icon circles, elevated elements

  /// Text colors - Dark theme (light text on dark background)
  static const Color textPrimaryDark = Color(0xFFF5F5F5); // Main headings, important text
  static const Color textSecondaryDark = Color(0xFFB8B8B8); // Body text, descriptions
  static const Color textTertiaryDark = Color(0xFF8E8E8E); // Less important text
  static const Color textDisabledDark = Color(0xFF5C5C5C); // Disabled buttons, inactive states
  static const Color textHintDark = Color(0xFF666666); // Placeholder text, hints

  /// Borders and dividers - Dark theme
  static const Color dividerDark = Color(0xFF2C2C2C); // Subtle dividers
  static const Color borderDark = Color(0xFF333333); // Input borders, card borders

  // ==================== STATE COLORS ====================
  // These work in both light and dark mode

  /// Error - Red
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
}
