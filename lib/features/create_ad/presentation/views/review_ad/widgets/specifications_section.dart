import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';

/// Specifications Section
class SpecificationsSection extends StatelessWidget {
  final Map<String, String> displayData;
  final ColorScheme colorScheme;
  final AppColorsExtension textExtension;

  const SpecificationsSection({
    super.key,
    required this.displayData,
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
                LucideIcons.clipboardList,
                size: 20.sp,
                color: colorScheme.primary,
              ),
              horizontalSpace(8.w),
              Text(
                'Specifications',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          verticalSpace(AppSizes.s16),
          ...displayData.entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: textExtension.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
