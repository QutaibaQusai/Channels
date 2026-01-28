import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_refresh_wrapper.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
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

/// Widget that displays the loaded state with ads
class MyAdsLoadedContent extends StatelessWidget {
  final MyAdsSuccess state;

  const MyAdsLoadedContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Separate ads by status
    final underReviewAds = state.ads.where((ad) => ad.isUnderReview).toList();
    final liveAds = state.ads.where((ad) => ad.isApproved).toList();

    return GradientOverlay(
      bottomWidget: _buildPostNewAdButton(context),
      child: AppRefreshWrapper(
        onRefresh: () => context.read<MyAdsCubit>().refreshMyAds(),
        child: ListView(
          padding: EdgeInsets.all(AppSizes.screenPaddingH),
          children: [
            // Search Bar (UI Only)
            AppSearchBar(hintText: l10n.myAdsSearchHint, onChanged: (value) {}),
            verticalSpace(AppSizes.s24),

            // Under Review Section
            if (underReviewAds.isNotEmpty) ...[
              _buildSectionHeader(
                context,
                title: l10n.myAdsSectionUnderReview,
                count: underReviewAds.length,
              ),
              verticalSpace(AppSizes.s20),
              ...underReviewAds
                  .take(1)
                  .map(
                    (ad) => MyAdCard(
                      ad: ad,
                      onTap: () async {
                        final result = await context.pushNamed(
                          RouteNames.adDetails,
                          extra: {'adId': ad.id, 'mode': AdViewMode.preview},
                        );
                        if (result == true && context.mounted) {
                          context.read<MyAdsCubit>().refreshMyAds();
                        }
                      },
                    ),
                  ),
              if (underReviewAds.length > 1) ...[
                _buildSeeMoreButton(context, underReviewAds.length - 1),
              ],
              verticalSpace(AppSizes.s24),
            ],

            // Live Now Section
            if (liveAds.isNotEmpty) ...[
              _buildSectionHeader(
                context,
                title: l10n.myAdsSectionLiveNow,
                count: liveAds.length,
                showBadge: true,
              ),
              verticalSpace(AppSizes.s20),
              ...liveAds.map(
                (ad) => MyAdCard(
                  ad: ad,
                  onTap: () async {
                    final result = await context.pushNamed(
                      RouteNames.adDetails,
                      extra: {'adId': ad.id, 'mode': AdViewMode.myAd},
                    );
                    if (result == true && context.mounted) {
                      context.read<MyAdsCubit>().refreshMyAds();
                    }
                  },
                ),
              ),
            ],

            // Add spacing for the floating button
            SizedBox(height: AppSizes.s96),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required int count,
    bool showBadge = false,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            letterSpacing: 1.2,
          ),
        ),
        // Divider line for both sections
        SizedBox(width: 8.w),
        Expanded(child: Divider(height: 1, color: colorScheme.outline)),
        SizedBox(width: 8.w),
        // Count badge - same style for both
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSeeMoreButton(BuildContext context, int remainingCount) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () async {
          final result = await context.push(RouteNames.underReviewAds);
          if (result == true && context.mounted) {
            context.read<MyAdsCubit>().refreshMyAds();
          }
        },
        child: Text(
          l10n.myAdsSeeMore(remainingCount),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildPostNewAdButton(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
      child: AppButton(
        text: l10n.myAdsPostNewAd,
        onPressed: () {
          context.pushNamed(RouteNames.createAd);
        },
      ),
    );
  }
}
