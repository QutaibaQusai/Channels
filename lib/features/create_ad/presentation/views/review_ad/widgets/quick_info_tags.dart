import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/utils/spacing.dart';

/// Quick Info Tags
class QuickInfoTags extends StatelessWidget {
  final String countryCode;
  final ColorScheme colorScheme;

  const QuickInfoTags({
    super.key,
    required this.countryCode,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        _InfoTag(
          icon: LucideIcons.mapPin,
          label: countryCode.toUpperCase(),
          colorScheme: colorScheme,
        ),
        _InfoTag(
          icon: LucideIcons.tag,
          label: 'For Sale',
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  final ColorScheme colorScheme;

  const _InfoTag({
    required this.icon,
    required this.label,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: colorScheme.onSurfaceVariant),
          horizontalSpace(6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
