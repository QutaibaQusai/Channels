import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Floating navigation bar with segmented left pill and floating right button
class FloatingNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FloatingNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.s20),
      child: Row(
        children: [
          // Left segmented pill with Broadcasts and Explore
          Container(
            height: 54.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(36.r),
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Broadcasts tab (index 0)
                _SegmentedNavItem(
                  icon: LucideIcons.radio,
                  isSelected: currentIndex == 0,
                  onTap: () => onTap(0),
                ),
                SizedBox(width: 2.w),
                // Explore tab (index 1)
                _SegmentedNavItem(
                  icon: LucideIcons.compass,
                  isSelected: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Right floating AI button (index 2)
          GestureDetector(
            onTap: () => onTap(2),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 54.w,
              height: 54.h,
              decoration: BoxDecoration(
                color: currentIndex == 2
                    ? colorScheme.primary
                    : colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outline, width: 1),
              ),
              child: Icon(
                LucideIcons.sparkles,
                color: currentIndex == 2
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// iOS-style segmented nav item with icon only
class _SegmentedNavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentedNavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Icon(
          icon,
          color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          size: 22.sp,
        ),
      ),
    );
  }
}
