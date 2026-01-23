import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';

/// Header widget for phone authentication view
class PhoneAuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const PhoneAuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(AppSizes.s20),

        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        verticalSpace(AppSizes.s12),

        // Subtitle
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16.sp,
            color: textExtension.textSecondary,
            height: 1.5,
          ),
        ),

        verticalSpace(AppSizes.s40),
      ],
    );
  }
}
