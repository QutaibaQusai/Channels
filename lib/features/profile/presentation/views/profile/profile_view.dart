import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/services/secure_storage_service.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:channels/features/profile/presentation/cubit/profile_state.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/profile/presentation/views/profile/widgets/profile_content.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';

/// Profile/Settings view - displays user header and settings
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      _hasFetched = true;
      _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    final userId = await SecureStorageService.getUserId();
    if (userId != null && mounted) {
      final locale = Localizations.localeOf(context);
      context.read<ProfileCubit>().fetchProfile(
        userId: userId,
        languageCode: locale.languageCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppAppBar(title: l10n.profileTitle, showBackButton: true),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            context.goNamed(RouteNames.onboarding);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const AppLoading();
          }

          if (state is ProfileFailure) {
            return ErrorStateWidget(
              message: state.errorMessage,
              isAuthError: state.isAuthError,
              onRetry: () {
                if (state.isAuthError) {
                  // If auth error, logout locally and go to onboarding/login
                  context.read<ProfileCubit>().logout();
                } else {
                  _fetchProfile();
                }
              },
            );
          }

          if (state is ProfileSuccess || state is ProfileUpdateSuccess) {
            final profile = state is ProfileSuccess
                ? state.profile
                : (state as ProfileUpdateSuccess).profile;

            // Handle doNotDisturb from success state
            final doNotDisturb = state is ProfileSuccess
                ? state.doNotDisturb
                : false;

            return ProfileContent(profile: profile, doNotDisturb: doNotDisturb);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
