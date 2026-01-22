import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Empty state widget when no countries found
class CountriesEmptyWidget extends StatelessWidget {
  const CountriesEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textExtension = Theme.of(context).extension<AppColorsExtension>()!;

    return Center(
      child: Text(
        l10n.countryPickerNoResults,
        style: AppTypography.bodyMedium.copyWith(
          color: textExtension.textSecondary,
        ),
      ),
    );
  }
}
