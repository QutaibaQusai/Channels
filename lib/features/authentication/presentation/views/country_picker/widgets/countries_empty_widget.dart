import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Empty state widget when no countries found
class CountriesEmptyWidget extends StatelessWidget {
  const CountriesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(
        l10n.countryPickerNoResults,
        style: AppTypography.bodyMedium.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }
}
