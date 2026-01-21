import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_typography.dart';

/// Custom app bar widget with consistent styling
/// Features: optional back button, centered title, optional actions
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leadingWidth: AppSizes.icon40 + (AppSizes.screenPaddingH * 2),
      leading: showBackButton
          ? Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.screenPaddingH,
              ),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                child: Container(
                  width: AppSizes.icon40,
                  height: AppSizes.icon40,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.back,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            )
          : null,
      title: title != null
          ? Text(title!, style: AppTypography.appBarTitle)
          : null,
      actions: actions != null
          ? [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPaddingH,
                ),
                child: Row(children: actions!),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
