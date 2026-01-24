import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Settings tile with icon, title, optional value and subtitle
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? value;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final color = isDestructive ? colorScheme.error : colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 22.sp, color: color),
            horizontalSpace(AppSizes.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  if (subtitle != null) ...[
                    verticalSpace(AppSizes.s4 / 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: textExtension.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: textExtension.textSecondary,
                ),
              ),
              horizontalSpace(AppSizes.s8),
            ],
            if (!isDestructive)
              Transform.scale(
                scaleX: Directionality.of(context) == TextDirection.rtl
                    ? -1
                    : 1,
                child: Icon(
                  LucideIcons.chevronRight,
                  size: 18.sp,
                  color: textExtension.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
