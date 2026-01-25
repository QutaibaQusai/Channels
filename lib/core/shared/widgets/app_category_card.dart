import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Reusable category card widget for selection
class AppCategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const AppCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r16),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.s16,
          vertical: AppSizes.s8,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Category image - Circular
            ClipOval(
              child: category.imageUrl != null
                  ? Image.network(
                      category.imageUrl!,
                      width: 44.w,
                      height: 44.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(colorScheme);
                      },
                    )
                  : _buildPlaceholder(colorScheme),
            ),

            SizedBox(width: AppSizes.s12),

            // Category name
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
            ),

            SizedBox(width: AppSizes.s8),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18.sp,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ColorScheme colorScheme) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.category_rounded,
        color: colorScheme.primary,
        size: 22.sp,
      ),
    );
  }
}
