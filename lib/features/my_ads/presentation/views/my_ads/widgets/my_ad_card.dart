import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/my_ads/domain/entities/my_ad.dart';
import 'package:channels/l10n/app_localizations.dart';

/// My Ad card widget - displays a single user's ad
class MyAdCard extends StatelessWidget {
  final MyAd ad;
  final VoidCallback? onTap;

  const MyAdCard({super.key, required this.ad, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>();
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSizes.s12),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        child: SizedBox(
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.r12),
                  bottomLeft: Radius.circular(AppSizes.r12),
                ),
                child: ad.images.isNotEmpty
                    ? Stack(
                        children: [
                          Image.network(
                            ad.images.first,
                            width: 100.w,
                            height: 100.h,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _buildPlaceholder(context),
                          ),
                          // Image count badge
                          if (ad.images.length > 1)
                            Positioned(
                              left: 6.w,
                              bottom: 6.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      LucideIcons.image,
                                      size: 9.sp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 2.w),
                                    Text(
                                      '${ad.images.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                    : _buildPlaceholder(context),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s12,
                    vertical: AppSizes.s8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: ad.isApproved
                              ? colorScheme.primary.withValues(alpha: 0.12)
                              : colorScheme.error.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppSizes.r4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.w,
                              decoration: BoxDecoration(
                                color: ad.isApproved
                                    ? colorScheme.primary
                                    : colorScheme.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              ad.isApproved
                                  ? l10n.myAdsStatusLive
                                  : l10n.myAdsStatusPending,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: ad.isApproved
                                    ? colorScheme.primary
                                    : colorScheme.error,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSizes.s8),

                      // Title
                      Text(
                        ad.title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),

                      // Category and Price Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Category from API
                          Expanded(
                            child: Text(
                              ad.categoryName,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color:
                                    textExtension?.textSecondary ??
                                    colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          // Price
                          Text(
                            '${ad.amount.toStringAsFixed(0)} ${ad.priceCurrency}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 100.w,
      height: 100.h,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        LucideIcons.image,
        size: 36.sp,
        color: colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }
}
