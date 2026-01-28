import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_refresh_wrapper.dart';
import 'package:channels/core/shared/widgets/app_empty_state.dart';
import 'package:channels/core/shared/widgets/app_loading.dart';
import 'package:channels/core/shared/widgets/app_error.dart';
import 'package:channels/core/shared/widgets/app_search_bar.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/my_ads/presentation/cubit/my_ads_cubit.dart';
import 'package:channels/features/my_ads/presentation/cubit/my_ads_state.dart';
import 'package:channels/features/my_ads/presentation/views/my_ads/widgets/my_ad_card.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';

/// View that displays all Under Review ads
class UnderReviewAdsView extends StatelessWidget {
  const UnderReviewAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

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
          appBar: AppAppBar(
            title: l10n.myAdsUnderReviewTitle,
            showBackButton: true,
          ),
          body: SafeArea(
            bottom: false,
            child: switch (state) {
              MyAdsInitial() => const SizedBox.shrink(),
              MyAdsLoading() => const Center(child: AppLoading()),
              MyAdsSuccess() => _buildContent(context, state),
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

  Widget _buildContent(BuildContext context, MyAdsSuccess state) {
    final l10n = AppLocalizations.of(context)!;
    final underReviewAds = state.ads.where((ad) => ad.isUnderReview).toList();

    if (underReviewAds.isEmpty) {
      return Center(
        child: AppEmptyState(
          icon: Icons.inbox_outlined,
          message: l10n.myAdsUnderReviewEmptyTitle,
          subtitle: l10n.myAdsUnderReviewEmptySubtitle,
        ),
      );
    }

    return AppRefreshWrapper(
      onRefresh: () => context.read<MyAdsCubit>().refreshMyAds(),
      child: ListView(
        padding: EdgeInsets.all(AppSizes.screenPaddingH),
        children: [
          // Search Bar (UI Only)
          AppSearchBar(
            hintText: l10n.myAdsUnderReviewSearchHint,
            onChanged: (value) {},
          ),
          verticalSpace(AppSizes.s24),

          ...underReviewAds.map(
            (ad) => MyAdCard(
              ad: ad,
              onTap: () => context.pushNamed(
                RouteNames.adDetails,
                extra: {'adId': ad.id, 'mode': AdViewMode.myAd},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
