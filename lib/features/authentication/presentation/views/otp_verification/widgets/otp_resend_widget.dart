import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/localization/app_localizations.dart';

/// Resend OTP widget with timer
class OtpResendWidget extends StatelessWidget {
  final bool canResend;
  final int resendTimer;
  final bool isResending;
  final VoidCallback onResend;

  const OtpResendWidget({
    super.key,
    required this.canResend,
    required this.resendTimer,
    required this.isResending,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: canResend
          ? GestureDetector(
              onTap: onResend,
              child: isResending
                  ? SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    )
                  : Text(
                      'otpVerification.resendCode'.tr(context),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
            )
          : Text(
              'otpVerification.resendTimer'
                  .tr(context)
                  .replaceAll('{seconds}', resendTimer.toString()),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondaryLight,
              ),
            ),
    );
  }
}
