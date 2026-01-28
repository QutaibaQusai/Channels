import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/shared/widgets/app_empty_state.dart';
import 'package:channels/core/shared/widgets/app_refresh_wrapper.dart';
import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/presentation/cubit/ads/ads_cubit.dart';
import 'package:channels/features/ads/presentation/views/category_ads/widgets/ad_card.dart';
import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';

/// Ads success content widget
class AdsSuccessContent extends StatelessWidget {
  final List<Ad> ads;

  const AdsSuccessContent({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) {
      return const AppEmptyState(
        icon: Icons.inbox_outlined,
        message: 'No ads found',
        subtitle: 'There are no ads in this category yet',
      );
    }

    return AppRefreshWrapper(
      onRefresh: () => context.read<AdsCubit>().refreshAds(),
      child: ListView.separated(
        padding: EdgeInsets.all(AppSizes.screenPaddingH),
        itemCount: ads.length,
        separatorBuilder: (_, __) => verticalSpace(AppSizes.s40),
        itemBuilder: (context, index) {
          final ad = ads[index];
          return AdCard(
            ad: ad,
            onTap: () {
              context.pushNamed(
                RouteNames.adDetails,
                extra: {'adId': ad.id, 'mode': AdViewMode.public},
              );
            },
          );
        },
      ),
    );
  }
}
