import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/features/ads/domain/entities/ad.dart';
import 'package:channels/features/ads/presentation/views/category_ads/widgets/ad_image_indicator.dart';
import 'package:channels/core/utils/formatters.dart';

import '../../../../../../core/theme/app_sizes.dart';

/// Ad card widget - displays a single ad in a list
class AdCard extends StatefulWidget {
  final Ad ad;
  final VoidCallback? onTap;

  const AdCard({super.key, required this.ad, this.onTap});

  @override
  State<AdCard> createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final createdAtText = Formatters.date(widget.ad.createdAt);

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with count badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: widget.ad.images.isNotEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 180.h,
                        child: PageView.builder(
                          itemCount: widget.ad.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.ad.images[index],
                              width: double.infinity,
                              height: 180.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _buildPlaceholder(context),
                            );
                          },
                        ),
                      )
                    : _buildPlaceholder(context),
              ),
              // Image count badge - only show on first image
              if (widget.ad.images.length > 1 && _currentImageIndex == 0)
                Positioned(
                  left: 8.w,
                  bottom: 8.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.image,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '${widget.ad.images.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (widget.ad.images.length > 1)
                Positioned(
                  bottom: 8.h,
                  left: 0,
                  right: 0,
                  child: AdImageIndicator(
                    itemCount: widget.ad.images.length,
                    currentIndex: _currentImageIndex,
                  ),
                ),
            ],
          ),
          verticalSpace(AppSizes.s8),
          // Price
          Text(
            '${widget.ad.amount} ${widget.ad.priceCurrency}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          verticalSpace(AppSizes.s4),
          // Title
          Text(
            widget.ad.title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(AppSizes.s4),
          // Description
          Text(
            widget.ad.description,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: textExtension.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(AppSizes.s8),
          // Created at
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 12.sp,
                    color: textExtension.textSecondary,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    createdAtText,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: textExtension.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 180.h,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        LucideIcons.image,
        size: 48.sp,
        color: colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }
}
