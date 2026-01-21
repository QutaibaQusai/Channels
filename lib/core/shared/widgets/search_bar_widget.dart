import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_colors.dart';
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
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textHintLight,
        ),
        prefixIcon:
            prefixIcon ??
            Icon(
              LucideIcons.search,
              color: AppColors.textSecondaryLight,
              size: AppSizes.icon16,
            ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s12,
        ),
      ),
    );
  }
}
