import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/di/service_locator.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_empty_state.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/my_ads/domain/usecases/get_my_ads.dart';
import 'package:channels/features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'package:channels/features/my_ads/presentation/cubit/my_ads_state.dart';
import 'package:channels/features/my_ads/presentation/views/my_ads/widgets/my_ads_loaded_content.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';

class MyAdsView extends StatelessWidget {
  const MyAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyAdsCubit(getMyAdsUseCase: sl<GetMyAds>())..fetchMyAds(),
      child: const _MyAdsBody(),
    );
  }
}

class _MyAdsBody extends StatelessWidget {
  const _MyAdsBody();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocConsumer<MyAdsCubit, MyAdsState>(
      listener: (context, state) {
        // Navigate to onboarding if auth error
        if (state is MyAdsFailure && state.isAuthError) {
          context.goNamed(RouteNames.onboarding);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppAppBar(title: l10n.myAdsTitle, showBackButton: true),
          body: SafeArea(
            bottom: false,
            child: switch (state) {
              MyAdsInitial() => const SizedBox.shrink(),
              MyAdsLoading() => const Center(child: AppLoading()),
              MyAdsSuccess() =>
                state.ads.isEmpty
                    ? AppEmptyState(
                        icon: Icons.inbox_outlined,
                        message: l10n.myAdsEmptyTitle,
                        subtitle: l10n.myAdsEmptySubtitle,
                      )
                    : MyAdsLoadedContent(state: state),
              MyAdsFailure() => ErrorStateWidget(
                message: state.message,
                isAuthError: state.isAuthError,
                onRetry: () {
                  if (state.isAuthError) {
                    context.goNamed(RouteNames.onboarding);
                  } else {
                    context.read<MyAdsCubit>().fetchMyAds();
                  }
                },
              ),
            },
          ),
        );
      },
    );
  }
}
