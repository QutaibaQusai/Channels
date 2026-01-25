import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/services/theme_service.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';

class ThemeSheet extends ConsumerWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.s16,
        vertical: AppSizes.s16,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: AppSizes.s40,
              height: AppSizes.s4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSizes.r4 / 2),
              ),
            ),
          ),
          verticalSpace(AppSizes.s24),

          // Title
          Text(
            l10n.settingsTheme,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          verticalSpace(AppSizes.s24),

          // System
          _buildThemeOption(
            context,
            ref,
            title: l10n.settingsThemeSystem,
            mode: ThemeMode.system,
            isSelected: themeMode == ThemeMode.system,
            colorScheme: colorScheme,
          ),
          verticalSpace(AppSizes.s12),

          // Light
          _buildThemeOption(
            context,
            ref,
            title: l10n.settingsThemeLight,
            mode: ThemeMode.light,
            isSelected: themeMode == ThemeMode.light,
            colorScheme: colorScheme,
          ),
          verticalSpace(AppSizes.s12),

          // Dark
          _buildThemeOption(
            context,
            ref,
            title: l10n.settingsThemeDark,
            mode: ThemeMode.dark,
            isSelected: themeMode == ThemeMode.dark,
            colorScheme: colorScheme,
          ),

          verticalSpace(AppSizes.s32),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required ThemeMode mode,
    required bool isSelected,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.s20,
          vertical: AppSizes.s16,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.onSurface
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSizes.r32),
          border: isSelected
              ? null
              : Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Radio/Check Icon
            isSelected
                ? Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.check,
                      size: 14.sp,
                      color: colorScheme.onSurface,
                    ),
                  )
                : Container(
                    width: 24.sp,
                    height: 24.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.onSurface,
                        width: 2,
                      ),
                    ),
                  ),

            // Theme Name
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? colorScheme.surface : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
