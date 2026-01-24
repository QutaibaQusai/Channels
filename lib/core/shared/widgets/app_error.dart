import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';

/// Shared error widget with retry functionality
/// Use this for all error states across the app
class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: colorScheme.error,
            ),
            verticalSpace(16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            AppButton(
              text: 'Retry',
              onPressed: onRetry,
              backgroundColor: colorScheme.primary,
              textColor: colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
