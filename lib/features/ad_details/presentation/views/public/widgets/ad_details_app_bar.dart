import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';

/// Transparent app bar with floating buttons for ad details
class AdDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AdViewMode mode;
  final VoidCallback? onShare;
  final VoidCallback? onFavorite;

  const AdDetailsAppBar({
    super.key,
    this.mode = AdViewMode.public,
    this.onShare,
    this.onFavorite,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back button
            FloatingIconButton(
              icon: CupertinoIcons.back,
              onTap: () => context.pop(),
            ),

            if (mode == AdViewMode.preview)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Preview Mode', // TODO: Localize
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            // Action buttons
            Row(
              children: [
                if (mode != AdViewMode.preview) ...[
                  FloatingIconButton(
                    icon: LucideIcons.share,
                    onTap: onShare ?? () {},
                  ),
                  horizontalSpace(8.w),
                ],
                if (mode == AdViewMode.public)
                  FloatingIconButton(
                    icon: LucideIcons.heart,
                    onTap: onFavorite ?? () {},
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating icon button with semi-transparent background
class FloatingIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const FloatingIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20.sp, color: Colors.white),
      ),
    );
  }
}
