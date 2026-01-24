import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/features/profile/presentation/cubit/profile_cubit.dart';

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

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

          // Icon
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.onSurface, width: 2),
            ),
            child: Icon(
              LucideIcons.power,
              size: 40.sp,
              color: colorScheme.onSurface,
            ),
          ),
          verticalSpace(AppSizes.s24),

          // Title
          Text(
            l10n.logoutTitle,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          verticalSpace(AppSizes.s8),

          // Subtitle
          Text(
            l10n.logoutConfirmation,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: textExtension.textSecondary,
            ),
          ),
          verticalSpace(AppSizes.s40),

          // Logout Button (White/Inverse)
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeightLarge,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileCubit>().logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onSurface,
                foregroundColor: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.rFull),
                ),
                elevation: 0,
              ),
              child: Text(
                l10n.logoutButton,
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
              l10n.logoutCancel,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ),
          verticalSpace(AppSizes.s16),
        ],
      ),
    );
  }
}
