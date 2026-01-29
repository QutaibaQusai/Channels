import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/ad_card.dart';
import 'package:channels/features/user_profile/domain/entities/user_ad.dart';

/// User ads grid widget - displays user's ads in a grid
class UserAdsGrid extends StatelessWidget {
  final List<UserAd> ads;

  const UserAdsGrid({super.key, required this.ads});

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) {
      return _buildEmptyState(context);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Ads',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          verticalSpace(12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.75,
            ),
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final ad = ads[index];
              return AdCard(
                adId: ad.id,
                images: [ad.firstImage],
                title: ad.title,
                description: ad.categoryName,
                formattedPrice: ad.formattedPrice,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 64.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            verticalSpace(16.h),
            Text(
              'No Ads Yet',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            verticalSpace(8.h),
            Text(
              'This user hasn\'t posted any ads yet',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
