import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';

/// Avatar widget for profile edit screen
class ProfileEditAvatar extends StatelessWidget {
  final Profile profile;

  const ProfileEditAvatar({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            profile.initials,
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
