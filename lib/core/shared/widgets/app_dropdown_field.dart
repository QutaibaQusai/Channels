import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Reusable dropdown field widget
class AppDropdownField<T> extends StatelessWidget {
  final T? initialValue;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String? Function(T?)? validator;

  const AppDropdownField({
    super.key,
    this.initialValue,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return DropdownButtonFormField<T>(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: textExtension.textSecondary.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s16,
        ),
      ),
      items: items,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(
        fontSize: 16.sp,
        color: colorScheme.onSurface,
      ),
      dropdownColor: colorScheme.surface,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: textExtension.textSecondary,
      ),
    );
  }
}