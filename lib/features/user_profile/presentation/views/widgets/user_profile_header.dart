import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/user_profile/domain/entities/user_info.dart';
import 'package:intl/intl.dart';

/// User profile header widget with avatar and user information
class UserProfileHeader extends StatelessWidget {
  final UserInfo userInfo;

  const UserProfileHeader({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(AppSizes.screenPaddingH),
      child: Column(
        children: [
          // Large Avatar
          CircleAvatar(
            radius: 48.r,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              userInfo.initials,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          verticalSpace(16.h),

          // User Name
          Text(
            userInfo.name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(8.h),

          // Country and Join Date with modern design
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.sp,
                  color: colorScheme.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  userInfo.countryName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 16.w),
                Container(
                  width: 1.w,
                  height: 16.h,
                  color: colorScheme.outlineVariant,
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16.sp,
                  color: colorScheme.primary,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatJoinDate(userInfo.createdAt),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatJoinDate(DateTime date) {
    return 'Joined ${DateFormat('MMM yyyy').format(date)}';
  }
}
