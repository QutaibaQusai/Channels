import 'package:flutter/material.dart';

/// Centralized color palette for Channels app
/// Modern, clean design with soft pastel accents
/// Inspired by contemporary iOS design patterns
class AppColors {
  AppColors._();

  // ==================== PRIMARY BRAND COLORS ====================

  /// Primary Brand Color - Pure Black
  /// Used for main CTAs, primary buttons, text, and key UI elements
  static const Color primary = Color(0xFF000000);
  static const Color primaryLight = Color(0xFF333333);
  static const Color primaryDark = Color(0xFF000000);

  /// Secondary Brand Color - Pure White
  /// Used for backgrounds, surfaces, and contrast elements
  static const Color secondary = Color(0xFFFFFFFF);
  static const Color secondaryLight = Color(0xFFFAFAFA);
  static const Color secondaryDark = Color(0xFFF5F5F5);

  // ==================== PASTEL ACCENT COLORS ====================

  /// Soft pastel colors for categories, tags, and decorative elements
  /// These create a gentle, approachable visual hierarchy

  static const Color pastelBlue = Color(0xFFD4E7F7);
  static const Color pastelPurple = Color(0xFFE8DAEF);
  static const Color pastelPink = Color(0xFFF5E5F0);
  static const Color pastelGreen = Color(0xFFD5F0E8);
  static const Color pastelYellow = Color(0xFFFFF8DC);
  static const Color pastelOrange = Color(0xFFFFE8D6);
  static const Color pastelMint = Color(0xFFD8F3F0);
  static const Color pastelLavender = Color(0xFFE9E4F7);

  // ==================== NEUTRAL COLORS - LIGHT MODE ====================

  /// Backgrounds - Clean white base with subtle variations
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceElevatedLight = Color(0xFFFDFDFD);
  static const Color surfaceCardLight = Color(0xFFFFFFFF);

  /// Text colors - High contrast for readability
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textSecondaryLight = Color(0xFF666666);
  static const Color textTertiaryLight = Color(0xFF999999);
  static const Color textDisabledLight = Color(0xFFCCCCCC);
  static const Color textHintLight = Color(0xFFB8B8B8);

  /// Borders and dividers - Subtle separation
  static const Color dividerLight = Color(0xFFF0F0F0);
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color borderFocusedLight = Color(0xFFCCCCCC);

  // ==================== NEUTRAL COLORS - DARK MODE ====================

  /// Backgrounds - Deep blacks with subtle elevation
  static const Color backgroundDark = Color(0xFF0D0D0D);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceElevatedDark = Color(0xFF262626);
  static const Color surfaceCardDark = Color(0xFF1F1F1F);

  /// Text colors - Soft whites for reduced eye strain
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFB8B8B8);
  static const Color textTertiaryDark = Color(0xFF8E8E8E);
  static const Color textDisabledDark = Color(0xFF5C5C5C);
  static const Color textHintDark = Color(0xFF666666);

  /// Borders and dividers - Subtle in dark mode
  static const Color dividerDark = Color(0xFF2C2C2C);
  static const Color borderDark = Color(0xFF333333);
  static const Color borderFocusedDark = Color(0xFF4D4D4D);

  // ==================== STATE COLORS ====================

  /// Success - Green
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  /// Warning - Orange
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  /// Error - Red
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  /// Info - Blue
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // ==================== FEATURE-SPECIFIC COLORS ====================

  /// Notification badge - Vibrant red for attention
  static const Color notificationBadge = Color(0xFFFF3B30);
  static const Color notificationDot = Color(0xFFFF4444);

  /// Channel states
  static const Color channelActive = primary;
  static const Color channelMuted = Color(0xFFCCCCCC);
  static const Color channelNew = Color(0xFF4CAF50);

  /// Ad status colors
  static const Color adFeatured = Color(0xFFFFB74D);
  static const Color adPromoted = primary;
  static const Color adExpiring = warning;
  static const Color adPending = Color(0xFFFFC107);

  /// Category colors - Assign to different ad categories
  /// These match the pastel tiles in the design reference
  static const Color categoryVehicles = pastelBlue;
  static const Color categoryRealEstate = pastelGreen;
  static const Color categoryElectronics = pastelPurple;
  static const Color categoryFurniture = pastelOrange;
  static const Color categoryJobs = pastelPink;
  static const Color categoryServices = pastelMint;
  static const Color categoryFashion = pastelLavender;
  static const Color categorySports = pastelYellow;

  /// Accent color for interactive elements (buttons, links, highlights)
  /// Can use one of the pastels or black for clean look
  static const Color accent = primary; // Black for clean, minimal design

  // ==================== OVERLAY & SHADOW ====================

  /// Overlays for modals, dialogs, and bottom sheets
  static const Color overlayLight = Color(0x33000000);
  static const Color overlayDark = Color(0x66000000);
  static const Color scrimLight = Color(0x1A000000);
  static const Color scrimDark = Color(0x33000000);

  /// Shadows for elevation and depth
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x26000000);
  static const Color shadowDark = Color(0x33000000);

  // ==================== SHIMMER/SKELETON LOADING ====================

  /// Loading states - Subtle pulse animation colors
  static const Color shimmerBaseLight = Color(0xFFF0F0F0);
  static const Color shimmerHighlightLight = Color(0xFFFAFAFA);

  static const Color shimmerBaseDark = Color(0xFF2C2C2C);
  static const Color shimmerHighlightDark = Color(0xFF3D3D3D);

  // ==================== INTERACTIVE STATES ====================

  /// Button and tap states
  static const Color rippleLight = Color(0x1A000000);
  static const Color rippleDark = Color(0x1AFFFFFF);

  static const Color hoverLight = Color(0x0A000000);
  static const Color hoverDark = Color(0x0AFFFFFF);

  static const Color pressedLight = Color(0x14000000);
  static const Color pressedDark = Color(0x14FFFFFF);

  static const Color focusLight = primary;
  static const Color focusDark = primaryLight;

  // ==================== GRADIENT COLORS ====================

  /// Optional gradients for special UI elements
  /// Black to gray gradient for premium feel
  static const List<Color> gradientPrimary = [
    Color(0xFF000000),
    Color(0xFF333333),
  ];

  /// Soft pastel gradients for category cards and illustrations
  static const List<Color> gradientPastelBlue = [
    pastelBlue,
    Color(0xFFBDD7EE),
  ];

  static const List<Color> gradientPastelPurple = [
    pastelPurple,
    pastelPink,
  ];

  static const List<Color> gradientPastelGreen = [
    pastelGreen,
    pastelMint,
  ];

  static const List<Color> gradientSuccess = [
    Color(0xFF66BB6A),
    Color(0xFF4CAF50),
  ];
}
