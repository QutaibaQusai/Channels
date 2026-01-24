import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/presentation/cubit/profile_state.dart';
import 'package:channels/features/profile/presentation/views/profile_edit/widgets/profile_edit_form.dart';

class ProfileEditView extends StatelessWidget {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppAppBar(
        title: l10n.profileEditTitle,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Implement delete account flow
            },
            child: Text(
              l10n.profileEditDeleteAccount,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.error,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            AppToast.success(context, title: l10n.profileEditUpdateSuccess);
            context.pop();
          } else if (state is ProfileUpdateFailure) {
            AppToast.error(context, title: l10n.profileEditUpdateError);
          }
        },
        builder: (context, state) {
          Profile? profile;
          bool isUpdating = false;

          if (state is ProfileSuccess) {
            profile = state.profile;
          } else if (state is ProfileUpdating) {
            profile = state.profile;
            isUpdating = true;
          } else if (state is ProfileUpdateSuccess) {
            profile = state.profile;
          } else if (state is ProfileUpdateFailure) {
            profile = state.profile;
          } else {
            // If fetching initially or failed fetch, just show loading or error
            // But we assume we navigated here from a loaded profile usually.
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
          }

          if (profile == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            bottom: false,
            child: ProfileEditForm(profile: profile, isUpdating: isUpdating),
          );
        },
      ),
    );
  }
}
