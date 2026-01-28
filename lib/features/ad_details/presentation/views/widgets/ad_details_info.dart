import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/utils/formatters.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';

import 'package:channels/features/ad_details/presentation/ad_view_mode.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Ad info widget showing title, price, category, and metadata
class AdDetailsInfo extends StatelessWidget {
  final AdDetails adDetails;
  final AdViewMode mode;

  const AdDetailsInfo({
    super.key,
    required this.adDetails,
    this.mode = AdViewMode.public,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Badge (My Ads only)
        if (mode == AdViewMode.myAd) ...[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: adDetails.isApproved
                  ? colorScheme.primary.withValues(alpha: 0.1)
                  : colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: adDetails.isApproved
                    ? colorScheme.primary.withValues(alpha: 0.2)
                    : colorScheme.error.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  adDetails.isApproved
                      ? LucideIcons.checkCircle
                      : LucideIcons.clock,
                  size: 14.sp,
                  color: adDetails.isApproved
                      ? colorScheme.primary
                      : colorScheme.error,
                ),
                SizedBox(width: 6.w),
                Text(
                  adDetails.isApproved
                      ? l10n.myAdsStatusLive
                      : l10n.myAdsStatusPending,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: adDetails.isApproved
                        ? colorScheme.primary
                        : colorScheme.error,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(AppSizes.s12),
        ],

        // Price
        Text(
          adDetails.formattedPrice,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: colorScheme.primary,
          ),
        ),

        verticalSpace(AppSizes.s12),

        // Title
        Text(
          adDetails.title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),

        verticalSpace(AppSizes.s8),

        // Description
        Text(
          adDetails.description,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: textExtension.textSecondary,
            height: 1.5,
          ),
        ),

        verticalSpace(AppSizes.s16),

        // Category & Subcategory
        if (adDetails.categoryName != null) ...[
          _buildInfoRow(
            context,
            icon: LucideIcons.folder,
            label: adDetails.categoryName!,
            subtitle: adDetails.subcategoryName,
          ),
          verticalSpace(AppSizes.s8),
        ],

        // Seller name
        if (adDetails.userName != null) ...[
          _buildInfoRow(
            context,
            icon: LucideIcons.user,
            label: adDetails.userName!,
          ),
          verticalSpace(AppSizes.s8),
        ],

        // Posted date
        _buildInfoRow(
          context,
          icon: LucideIcons.clock,
          label: Formatters.relativeTime(adDetails.createdAt),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    String? subtitle,
  }) {
    final theme = Theme.of(context);
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Row(
      children: [
        Icon(icon, size: 18.sp, color: textExtension.textSecondary),
        SizedBox(width: 8.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                color: textExtension.textSecondary,
              ),
              children: [
                TextSpan(text: label),
                if (subtitle != null) ...[
                  const TextSpan(text: ' • '),
                  TextSpan(text: subtitle),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
