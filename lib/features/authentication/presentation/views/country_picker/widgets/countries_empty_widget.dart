import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/localization/app_localizations.dart';

/// Empty state widget when no countries found
class CountriesEmptyWidget extends StatelessWidget {
  const CountriesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'countryPicker.noResults'.tr(context),
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}
