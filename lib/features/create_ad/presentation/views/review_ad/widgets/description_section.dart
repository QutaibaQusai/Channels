import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';

/// Description Section
class DescriptionSection extends StatelessWidget {
  final String description;
  final ColorScheme colorScheme;
  final AppColorsExtension textExtension;

  const DescriptionSection({
    super.key,
    required this.description,
    required this.colorScheme,
    required this.textExtension,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.s16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.fileText,
                size: 20.sp,
                color: colorScheme.primary,
              ),
              horizontalSpace(8.w),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          verticalSpace(AppSizes.s12),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.sp,
              color: textExtension.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
