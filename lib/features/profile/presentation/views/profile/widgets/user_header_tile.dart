import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';
import 'package:channels/l10n/app_localizations.dart';

/// User header tile - displays avatar, name, status
class UserHeaderTile extends StatelessWidget {
  final Profile profile;
  final VoidCallback onTap;

  const UserHeaderTile({super.key, required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenPaddingH,
          vertical: AppSizes.s8,
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: AppSizes.s56,
              height: AppSizes.s56,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  profile.initials,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            ),

            horizontalSpace(AppSizes.s16),

            // Name and status
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.displayName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  verticalSpace(AppSizes.s4),
                  Text(
                    profile.status == 'active'
                        ? l10n.profileStatusActive
                        : l10n.profileStatusInactive,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: textExtension.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            Transform.scale(
              scaleX: Directionality.of(context) == TextDirection.rtl ? -1 : 1,
              child: Icon(
                LucideIcons.chevronRight,
                size: AppSizes.icon20,
                color: textExtension.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
