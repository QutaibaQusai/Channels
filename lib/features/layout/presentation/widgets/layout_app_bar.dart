import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Custom app bar for main layout navigation
/// Shows title based on current tab and profile button
class LayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const LayoutAppBar({super.key, required this.currentIndex});

  String _getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (currentIndex) {
      case 0:
        return l10n.layoutBroadcastsTitle;
      case 1:
        return l10n.layoutCategoriesTitle;
      case 2:
        return l10n.layoutAiTitle;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leadingWidth: AppSizes.icon40 + (AppSizes.screenPaddingH * 2),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.push(RouteNames.profile);
          },
          child: Container(
            width: AppSizes.icon40,
            height: AppSizes.icon40,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.user,
              color: colorScheme.onSurface,
              size: AppSizes.icon20,
            ),
          ),
        ),
      ),
      title: Text(_getTitle(context), style: AppTypography.appBarTitle),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // TODO: Navigate to notifications
            },
            child: Container(
              width: AppSizes.icon40,
              height: AppSizes.icon40,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.bell,
                color: colorScheme.onSurface,
                size: AppSizes.icon20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
