import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/utils/spacing.dart';

class AppPopupItem<T> {
  final T value;
  final String label;
  final IconData icon;
  final Color? color;

  const AppPopupItem({
    required this.value,
    required this.label,
    required this.icon,
    this.color,
  });
}

class AppPopupMenu<T> extends StatelessWidget {
  final List<AppPopupItem<T>> items;
  final ValueChanged<T> onSelected;
  final Widget? icon;

  const AppPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PopupMenuButton<T>(
      icon:
          icon ?? Icon(LucideIcons.moreVertical, color: colorScheme.onSurface),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((item) {
          final itemColor = item.color ?? colorScheme.onSurface;

          return PopupMenuItem<T>(
            value: item.value,
            child: Row(
              children: [
                Icon(item.icon, size: 20.sp, color: itemColor),
                horizontalSpace(8.w),
                Text(
                  item.label,
                  style: TextStyle(
                    color: itemColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      offset: const Offset(0, 50),
      color: colorScheme.surfaceContainer,
      elevation: 4,
    );
  }
}
