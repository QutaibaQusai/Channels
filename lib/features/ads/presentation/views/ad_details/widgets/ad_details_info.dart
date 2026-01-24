import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/utils/formatters.dart';
import 'package:channels/features/ads/domain/entities/ad_details.dart';

/// Ad info widget showing title, price, category, and metadata
class AdDetailsInfo extends StatelessWidget {
  final AdDetails adDetails;

  const AdDetailsInfo({super.key, required this.adDetails});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
