import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:channels/core/theme/app_color_tokens.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Centralized theme configuration for Channels app
/// Modern, clean design with proper light/dark mode support
/// Uses Material 3 ColorScheme + custom extensions
class AppTheme {
  AppTheme._();

  // ==================== LIGHT THEME ====================

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      // Primary (Black brand color)
      primary: AppColorTokens.brandPrimary,
      onPrimary: AppColorTokens.neutralWhite,
      primaryContainer: AppColorTokens.brandPrimaryLight,
      onPrimaryContainer: AppColorTokens.neutralWhite,

      // Secondary (White)
      secondary: AppColorTokens.neutralWhite,
      onSecondary: AppColorTokens.brandPrimary,
      secondaryContainer: AppColorTokens.neutral100,
      onSecondaryContainer: AppColorTokens.neutral900,

      // Error
      error: AppColorTokens.error,
      onError: AppColorTokens.neutralWhite,
      errorContainer: AppColorTokens.errorLight,
      onErrorContainer: AppColorTokens.neutral900,

      // Surfaces
      surface: AppColorTokens.neutralWhite,
      onSurface: AppColorTokens.neutral900,

      // Outline (borders)
      outline: AppColorTokens.neutral300,
      outlineVariant: AppColorTokens.neutral200,

      // Background
      background: AppColorTokens.neutral50,
      onBackground: AppColorTokens.neutral900,

      // Brightness
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Add custom extensions
      extensions: const [AppColorsExtension.light],

      // Font Family
      fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,

      // Scaffold
      scaffoldBackgroundColor: AppColorTokens.neutral50,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorTokens.neutralWhite,
        foregroundColor: AppColorTokens.neutral900,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColorTokens.neutral900,
          fontSize: 20,
          fontWeight: AppTypography.semiBold,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColorTokens.neutralWhite,
        elevation: AppSizes.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColorTokens.neutral200,
        thickness: 1,
        space: 1,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorTokens.neutralWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.neutral300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.neutral300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.brandPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.error),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s12,
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorTokens.brandPrimary,
          foregroundColor: AppColorTokens.neutralWhite,
          minimumSize: Size(double.infinity, AppSizes.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: AppSizes.elevationLow,
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColorTokens.brandPrimary,
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorTokens.brandPrimary,
          side: const BorderSide(color: AppColorTokens.brandPrimary),
          minimumSize: Size(double.infinity, AppSizes.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorTokens.neutralWhite,
        selectedItemColor: AppColorTokens.brandPrimary,
        unselectedItemColor: AppColorTokens.neutral600,
        type: BottomNavigationBarType.fixed,
        elevation: AppSizes.elevationMedium,
      ),

      // Text Theme
      textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(
        TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headlineLarge,
          headlineMedium: AppTypography.headlineMedium,
          headlineSmall: AppTypography.headlineSmall,
          titleLarge: AppTypography.titleLarge,
          titleMedium: AppTypography.titleMedium,
          titleSmall: AppTypography.titleSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
      ).apply(
        bodyColor: AppColorTokens.neutral900,
        displayColor: AppColorTokens.neutral900,
      ),
    );
  }

  // ==================== DARK THEME ====================

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      // Primary (Keep black brand, adjust for dark mode)
      primary: AppColorTokens.neutralWhite,
      onPrimary: AppColorTokens.brandPrimary,
      primaryContainer: AppColorTokens.dark800,
      onPrimaryContainer: AppColorTokens.dark50,

      // Secondary
      secondary: AppColorTokens.dark50,
      onSecondary: AppColorTokens.dark900,
      secondaryContainer: AppColorTokens.dark800,
      onSecondaryContainer: AppColorTokens.dark50,

      // Error
      error: AppColorTokens.errorDark,
      onError: AppColorTokens.dark900,
      errorContainer: AppColorTokens.error,
      onErrorContainer: AppColorTokens.dark50,

      // Surfaces
      surface: AppColorTokens.dark900,
      onSurface: AppColorTokens.dark50,

      // Outline (borders)
      outline: AppColorTokens.dark700,
      outlineVariant: AppColorTokens.dark800,

      // Background
      background: AppColorTokens.dark950,
      onBackground: AppColorTokens.dark50,

      // Brightness
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // Add custom extensions
      extensions: const [AppColorsExtension.dark],

      // Font Family
      fontFamily: GoogleFonts.ibmPlexSansArabic().fontFamily,

      // Scaffold
      scaffoldBackgroundColor: AppColorTokens.dark950,

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorTokens.dark900,
        foregroundColor: AppColorTokens.dark50,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColorTokens.dark50,
          fontSize: 20,
          fontWeight: AppTypography.semiBold,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColorTokens.dark900,
        elevation: AppSizes.elevationLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColorTokens.dark800,
        thickness: 1,
        space: 1,
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorTokens.dark800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.dark700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.dark700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.neutralWhite, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: const BorderSide(color: AppColorTokens.errorDark),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s12,
        ),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorTokens.neutralWhite,
          foregroundColor: AppColorTokens.brandPrimary,
          minimumSize: Size(double.infinity, AppSizes.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          elevation: AppSizes.elevationLow,
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColorTokens.neutralWhite,
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColorTokens.neutralWhite,
          side: const BorderSide(color: AppColorTokens.neutralWhite),
          minimumSize: Size(double.infinity, AppSizes.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          textStyle: AppTypography.buttonMedium,
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColorTokens.dark900,
        selectedItemColor: AppColorTokens.neutralWhite,
        unselectedItemColor: AppColorTokens.dark200,
        type: BottomNavigationBarType.fixed,
        elevation: AppSizes.elevationMedium,
      ),

      // Text Theme
      textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(
        TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headlineLarge,
          headlineMedium: AppTypography.headlineMedium,
          headlineSmall: AppTypography.headlineSmall,
          titleLarge: AppTypography.titleLarge,
          titleMedium: AppTypography.titleMedium,
          titleSmall: AppTypography.titleSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodyMedium: AppTypography.bodyMedium,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
      ).apply(
        bodyColor: AppColorTokens.dark50,
        displayColor: AppColorTokens.dark50,
      ),
    );
  }
}
