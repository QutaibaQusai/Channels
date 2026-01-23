import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';

/// Reusable search bar widget
class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const SearchBarWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTypography.bodyMedium.copyWith(color: colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: textExtension.textHint,
        ),
        prefixIcon:
            prefixIcon ??
            Container(
              width: AppSizes.icon40,
              height: AppSizes.icon40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.secondaryContainer,
              ),
              child: Icon(
                LucideIcons.search,
                color: textExtension.textSecondary,
                size: AppSizes.icon20,
              ),
            ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.rFull),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.rFull),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.rFull),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s12,
        ),
      ),
    );
  }
}
