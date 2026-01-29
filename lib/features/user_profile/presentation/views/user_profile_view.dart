import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/features/user_profile/presentation/cubit/user_profile_cubit.dart';
import 'package:channels/features/user_profile/presentation/cubit/user_profile_state.dart';
import 'package:channels/features/user_profile/presentation/views/widgets/user_profile_header.dart';
import 'package:channels/features/user_profile/presentation/views/widgets/user_stats_card.dart';
import 'package:channels/features/user_profile/presentation/views/widgets/user_ads_grid.dart';

/// User Profile View - displays user information and their ads
class UserProfileView extends StatelessWidget {
  final String userId;

  const UserProfileView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'User Profile', showBackButton: true),
      body: BlocBuilder<UserProfileCubit, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserProfileFailure) {
            return _buildErrorState(context, state.errorMessage);
          }

          if (state is UserProfileSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<UserProfileCubit>().refresh(
                  userId: userId,
                  languageCode: 'en', // TODO: Get from app language
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    verticalSpace(16.h),

                    // User Profile Header
                    UserProfileHeader(userInfo: state.userProfile.user),

                    verticalSpace(24.h),

                    // User Stats Card
                    UserStatsCard(userProfile: state.userProfile),

                    verticalSpace(24.h),

                    // User Ads Grid
                    UserAdsGrid(ads: state.userProfile.ads),

                    verticalSpace(24.h),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: colorScheme.error),
            verticalSpace(16.h),
            Text(
              'Error Loading Profile',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            verticalSpace(8.h),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(24.h),
            FilledButton.icon(
              onPressed: () {
                context.read<UserProfileCubit>().fetchUserProfile(
                  userId: userId,
                  languageCode: 'en', // TODO: Get from app language
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
