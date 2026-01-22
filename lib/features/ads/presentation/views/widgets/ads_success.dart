import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/empty_state_widget.dart';
import 'package:channels/core/shared/widgets/refresh_wrapper.dart';
import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/presentation/cubit/ads_cubit.dart';
import 'package:channels/features/ads/presentation/views/widgets/ad_card.dart';

/// Ads success content widget
class AdsSuccessContent extends StatelessWidget {
  final List<Ad> ads;

  const AdsSuccessContent({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.inbox_outlined,
        message: 'No ads found',
        subtitle: 'There are no ads in this category yet',
      );
    }

    return RefreshWrapper(
      onRefresh: () => context.read<AdsCubit>().refreshAds(),
      child: ListView.separated(
        padding: EdgeInsets.all(AppSizes.screenPaddingH),
        itemCount: ads.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final ad = ads[index];
          return AdCard(
            ad: ad,
            onTap: () {
              // TODO: Navigate to ad details
            },
          );
        },
      ),
    );
  }
}
