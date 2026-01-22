import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';

/// Categories view - browse ad categories
class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(AppSizes.s24),

              // Title
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              verticalSpace(AppSizes.s16),

              // Subtitle
              Text(
                'Browse categories to find ads you care about',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: textExtension.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
