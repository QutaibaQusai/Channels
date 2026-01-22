import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Center(
      child: OtpTextField(
        numberOfFields: 4,
        borderColor: textExtension.border,
        focusedBorderColor: colorScheme.primary,
        enabledBorderColor: textExtension.border,
        borderWidth: 1.5,
        showFieldAsBox: true,
        fieldWidth: 60.w,
        fieldHeight: 60.h,
        borderRadius: BorderRadius.circular(12.r),
        fillColor: colorScheme.surface,
        filled: true,
        textStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        onCodeChanged: onCodeChanged,
        onSubmit: onSubmit,
      ),
    );
  }
}
