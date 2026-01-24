import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';

class DeleteAccountSheet extends StatelessWidget {
  const DeleteAccountSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s24,
        vertical: AppSizes.s24,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSizes.r24),
          topRight: Radius.circular(AppSizes.r24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: AppSizes.s40,
            height: AppSizes.s4,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSizes.r4 / 2),
            ),
          ),
          verticalSpace(AppSizes.s40),

          // Title
          Text(
            l10n.deleteAccountTitle,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.error,
            ),
          ),
          verticalSpace(AppSizes.s8),

          // Subtitle
          Text(
            l10n.deleteAccountConfirmation,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: textExtension.textSecondary,
            ),
          ),
          verticalSpace(AppSizes.s40),

          // Delete Button (Destructive)
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement actual delete logic when requested
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.rFull),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.deleteAccountButton,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          verticalSpace(AppSizes.s12),

          // Cancel Button
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: colorScheme.onSurface),
            child: Text(
              l10n.logoutCancel, // Reuse cancel string
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          verticalSpace(AppSizes.s16),
        ],
      ),
    );
  }
}
