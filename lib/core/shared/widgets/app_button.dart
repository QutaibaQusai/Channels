import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Reusable app button with consistent styling
/// Can be used across all features
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool disabled;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSizes.buttonHeightLarge,
      child: isOutlined
          ? _buildOutlinedButton(context)
          : _buildFilledButton(context),
    );
  }

  Widget _buildFilledButton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return ElevatedButton(
      onPressed: (disabled || isLoading) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colorScheme.primary,
        foregroundColor: textColor ?? colorScheme.onPrimary,
        disabledBackgroundColor: textExtension.border,
        disabledForegroundColor: textExtension.textTertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.rFull),
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.s24),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: (disabled || isLoading) ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: backgroundColor ?? colorScheme.primary,
        side: BorderSide(
          color: backgroundColor ?? colorScheme.primary,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.rFull),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.s24),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textStyle =
        theme.textTheme.labelLarge ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    final resolvedTextColor = isOutlined
        ? (backgroundColor ?? colorScheme.primary)
        : (textColor ?? colorScheme.onPrimary);

    if (isLoading) {
      return SizedBox(
        height: AppSizes.icon20,
        width: AppSizes.icon20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            textColor ?? colorScheme.onPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppSizes.icon20),
          SizedBox(width: AppSizes.s8),
          Text(text, style: textStyle.copyWith(color: resolvedTextColor)),
        ],
      );
    }

    return Text(text, style: textStyle.copyWith(color: resolvedTextColor));
  }
}
