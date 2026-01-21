import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';

/// Country list item widget
class CountryListItem extends StatelessWidget {
  final CountryModel country;
  final VoidCallback onTap;

  const CountryListItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
        child: Row(
          children: [
            // Country flag
            SvgPicture.network(
              country.flagUrl,
              width: AppSizes.icon32,
              height: AppSizes.icon32,
              placeholderBuilder: (context) => Container(
                width: AppSizes.icon32,
                height: AppSizes.icon32,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flag,
                  size: AppSizes.icon20,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ),

            SizedBox(width: AppSizes.s12),

            // Country name and placeholder
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.name,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                  verticalSpace(AppSizes.s4),
                  Text(
                    country.placeholder,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),

            // Dialing code
            Text(
              country.dialingCode,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
