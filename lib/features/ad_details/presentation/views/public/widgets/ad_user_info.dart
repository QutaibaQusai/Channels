import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// User info widget - displays user avatar and name
class AdUserInfo extends StatelessWidget {
  final String? userName;
  final String userId;
  final VoidCallback? onTap;

  const AdUserInfo({
    super.key,
    required this.userName,
    required this.userId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 28.r,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              _getInitials(userName),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // User name
          Expanded(
            child: Text(
              userName ?? 'Unknown User',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Get user initials from name
  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';

    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
