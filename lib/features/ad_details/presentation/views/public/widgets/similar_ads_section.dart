import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/ad_card.dart';
import 'package:channels/features/ad_details/domain/entities/similar_ad.dart';

/// Similar ads section widget - horizontal scrollable list
class SimilarAdsSection extends StatelessWidget {
  final List<SimilarAd> similarAds;

  const SimilarAdsSection({super.key, required this.similarAds});

  @override
  Widget build(BuildContext context) {
    if (similarAds.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: Text(
            'Similar Ads',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        verticalSpace(12.h),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
            itemCount: similarAds.length,
            separatorBuilder: (context, index) => horizontalSpace(12.w),
            itemBuilder: (context, index) {
              final ad = similarAds[index];
              return AdCard(
                adId: ad.id,
                images: ad.images,
                title: ad.title,
                description: ad.description,
                formattedPrice: ad.formattedPrice,
                width: 160.w,
              );
            },
          ),
        ),
      ],
    );
  }
}
