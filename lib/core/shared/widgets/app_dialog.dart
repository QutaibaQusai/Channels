import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Simple, clean dialog following Material 3 design
/// Uses app theme colors and typography for consistency
class AppDialog extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? child;
  final String? primaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;
  final bool isDestructive;

  const AppDialog({
    super.key,
    required this.title,
    this.content,
    this.child,
    this.primaryButtonText,
    this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
    this.isDestructive = false,
  }) : assert(
         content != null || child != null,
         'Either content or child must be provided',
       );

  static Future<T?> show<T>(BuildContext context, {required AppDialog dialog}) {
    return showDialog<T>(context: context, builder: (context) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.r16),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            verticalSpace(16.h),

            // Content
            if (content != null)
              Text(
                content!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            if (child != null) child!,

            verticalSpace(24.h),

            // Actions - aligned to the end following Material 3 guidelines
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (secondaryButtonText != null) ...[
                  TextButton(
                    onPressed: onSecondaryButtonTap ?? () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    ),
                    child: Text(secondaryButtonText!),
                  ),
                  horizontalSpace(8.w),
                ],
                if (primaryButtonText != null)
                  FilledButton(
                    onPressed: onPrimaryButtonTap ?? () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: isDestructive
                          ? colorScheme.error
                          : colorScheme.primary,
                      foregroundColor: isDestructive
                          ? colorScheme.onError
                          : colorScheme.onPrimary,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    ),
                    child: Text(primaryButtonText!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
