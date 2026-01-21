import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Error state widget for countries
class CountriesErrorWidget extends StatelessWidget {
  final String errorMessage;

  const CountriesErrorWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: AppSizes.icon48,
            color: AppColors.error,
          ),
          verticalSpace(AppSizes.s16),
          Text(
            l10n.countryPickerError,
            style: AppTypography.titleMedium,
          ),
          verticalSpace(AppSizes.s8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.s32),
            child: Text(
              errorMessage,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
