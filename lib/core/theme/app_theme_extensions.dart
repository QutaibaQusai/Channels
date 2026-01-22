import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_color_tokens.dart';

/// Custom semantic color extensions
/// Access via: Theme.of(context).extension<AppColorsExtension>()!.textSecondary
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color textSecondary;
  final Color textTertiary;
  final Color textHint;
  final Color divider;
  final Color border;
  final Color borderSubtle;

  const AppColorsExtension({
    required this.textSecondary,
    required this.textTertiary,
    required this.textHint,
    required this.divider,
    required this.border,
    required this.borderSubtle,
  });

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? textSecondary,
    Color? textTertiary,
    Color? textHint,
    Color? divider,
    Color? border,
    Color? borderSubtle,
  }) {
    return AppColorsExtension(
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textHint: textHint ?? this.textHint,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      borderSubtle: borderSubtle ?? this.borderSubtle,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    );
  }

  /// Light mode theme extension
  static const AppColorsExtension light = AppColorsExtension(
    textSecondary: AppColorTokens.neutral600,
    textTertiary: AppColorTokens.neutral500,
    textHint: AppColorTokens.neutral400,
    divider: AppColorTokens.neutral200,
    border: AppColorTokens.neutral300,
    borderSubtle: AppColorTokens.neutral200,
  );

  /// Dark mode theme extension
  static const AppColorsExtension dark = AppColorsExtension(
    textSecondary: AppColorTokens.dark200,
    textTertiary: AppColorTokens.dark300,
    textHint: AppColorTokens.dark400,
    divider: AppColorTokens.dark800,
    border: AppColorTokens.dark700,
    borderSubtle: AppColorTokens.dark800,
  );
}
