import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/utils/formatters.dart';
import 'package:channels/features/ad_details/domain/entities/ad_details.dart';
import 'package:channels/features/ad_details/presentation/views/my_ad/widgets/my_ad_status_badge.dart';
import 'package:channels/features/ad_details/presentation/views/my_ad/widgets/ad_details_images.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Shared content widget for ad details
/// Used by both My Ad Details and Preview views
class AdDetailsContent extends StatelessWidget {
  final AdDetails adDetails;
  final bool showStatusBadge;
  final Widget? headerWidget;

  const AdDetailsContent({
    super.key,
    required this.adDetails,
    this.showStatusBadge = true,
    this.headerWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Prepare data lists
    final basicInfo = {
      l10n.labelTitle: adDetails.title,
      l10n.labelPrice: adDetails.formattedPrice,
      l10n.labelCategory: adDetails.categoryName,
      l10n.labelSubCategory: adDetails.subcategoryName,
      l10n.labelLocation: adDetails.countryCode,
      l10n.labelLanguage: adDetails.languageCode,
    };

    final metaInfo = {
      l10n.labelStatus: adDetails.status,
      l10n.labelCreated: Formatters.relativeTime(adDetails.createdAt),
      l10n.labelPhone: adDetails.phoneE164,
      l10n.labelUser: adDetails.userName,
    };

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.screenPaddingH,
        vertical: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 0. Optional Header Widget (e.g., announcement banner)
          if (headerWidget != null) ...[
            headerWidget!,
            verticalSpace(16.h),
          ],

          // 1. Status Section
          if (showStatusBadge)
            Row(
              children: [
                MyAdStatusBadge(isApproved: adDetails.isApproved),
                const Spacer(),
                if (adDetails.reportCount > 0)
                  _buildMetricBadge(
                    context,
                    LucideIcons.flag,
                    l10n.myAdDetailsReports(adDetails.reportCount),
                    theme.colorScheme.error,
                  ),
              ],
            ),
          if (showStatusBadge) verticalSpace(16.h),

          // 2. Images
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: AdDetailsImages(images: adDetails.images),
            ),
          ),
          verticalSpace(24.h),

          // 3. Description Box
          Text(
            l10n.myAdDetailsSectionDescription,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8.h),
          Text(
            adDetails.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          verticalSpace(24.h),

          // 4. Basic Info Table
          _buildStripedTable(
            context,
            l10n.myAdDetailsSectionBasicInfo,
            basicInfo,
          ),
          verticalSpace(24.h),

          // 5. Attributes Table
          if (adDetails.attributes.isNotEmpty)
            _buildStripedTable(
              context,
              l10n.myAdDetailsSectionAttributes,
              adDetails.attributes,
            ),

          if (adDetails.attributes.isNotEmpty) verticalSpace(24.h),

          // 6. Meta Table
          _buildStripedTable(
            context,
            l10n.myAdDetailsSectionSystemData,
            metaInfo,
          ),

          verticalSpace(40.h),
        ],
      ),
    );
  }

  Widget _buildStripedTable(
    BuildContext context,
    String title,
    Map<dynamic, dynamic> data,
  ) {
    if (data.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final entries = data.entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpace(12.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: List.generate(entries.length, (index) {
              final entry = entries[index];
              final isEven = index % 2 == 0;
              final isLast = index == entries.length - 1;

              return Container(
                decoration: BoxDecoration(
                  color: isEven
                      ? colorScheme.surface
                      : colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.vertical(
                    top: index == 0 ? Radius.circular(11.r) : Radius.zero,
                    bottom: isLast ? Radius.circular(11.r) : Radius.zero,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        entry.key.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        entry.value.toString(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricBadge(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14.sp, color: color),
          horizontalSpace(4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
