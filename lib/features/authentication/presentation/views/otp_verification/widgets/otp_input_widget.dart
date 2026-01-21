import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:channels/core/theme/app_colors.dart';

/// OTP input field widget
class OtpInputWidget extends StatelessWidget {
  final Function(String) onCodeChanged;
  final Function(String) onSubmit;

  const OtpInputWidget({
    super.key,
    required this.onCodeChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OtpTextField(
        numberOfFields: 4,
        borderColor: AppColors.borderLight,
        focusedBorderColor: AppColors.primary,
        enabledBorderColor: AppColors.borderLight,
        borderWidth: 1.5,
        showFieldAsBox: true,
        fieldWidth: 60.w,
        fieldHeight: 60.h,
        borderRadius: BorderRadius.circular(12.r),
        fillColor: AppColors.surfaceLight,
        filled: true,
        textStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryLight,
        ),
        onCodeChanged: onCodeChanged,
        onSubmit: onSubmit,
      ),
    );
  }
}
