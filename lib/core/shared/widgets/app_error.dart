import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared error widget with retry functionality
/// Use this for all error states across the app
class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool isAuthError;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.isAuthError = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie Animation
            SizedBox(
              height: 200.h,
              child: Lottie.asset('assets/animations/Error.json', repeat: true),
            ),

            verticalSpace(24),

            // Error Message
            Text(
              message,
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            verticalSpace(32),

            // Action Button
            AppButton(
              text: isAuthError ? 'Login' : 'Retry',
              onPressed: onRetry,
              backgroundColor: colorScheme.primary,
              textColor: colorScheme.onPrimary,
              width: 160.w,
            ),
          ],
        ),
      ),
    );
  }
}
