import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/user_header_tile.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/settings_list.dart';

class ProfileContent extends StatelessWidget {
  final Profile profile;
  final bool doNotDisturb;

  const ProfileContent({
    super.key,
    required this.profile,
    required this.doNotDisturb,
  });

  void _showProfileDetails(BuildContext context, Profile profile) {
    context.pushNamed(
      RouteNames.profileEdit,
      extra: context.read<ProfileCubit>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(8.h),

          // User header tile (tappable)
          UserHeaderTile(
            profile: profile,
            onTap: () => _showProfileDetails(context, profile),
          ),

          verticalSpace(16.h),

          // Divider between header and settings
          Divider(height: 1, color: Theme.of(context).colorScheme.outline),

          verticalSpace(16.h),

          // Settings list
          SettingsList(
            doNotDisturb: doNotDisturb,
            onDoNotDisturbChanged: (value) {
              context.read<ProfileCubit>().toggleDoNotDisturb(value);
            },
          ),
        ],
      ),
    );
  }
}
