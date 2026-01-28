import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';

/// Review Notice Card
class ReviewNoticeCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final AppColorsExtension textExtension;

  const ReviewNoticeCard({
    super.key,
    required this.colorScheme,
    required this.textExtension,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colorScheme.secondary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.info, color: colorScheme.primary, size: 22.sp),
          horizontalSpace(12.w),
          Expanded(
            child: Text(
              'Please review all information carefully before publishing your ad.',
              style: TextStyle(
                fontSize: 13.sp,
                color: textExtension.textSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
