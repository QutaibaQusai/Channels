import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_colors.dart';

/// Error message widget for OTP
class OtpErrorWidget extends StatelessWidget {
  final String errorMessage;

  const OtpErrorWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
