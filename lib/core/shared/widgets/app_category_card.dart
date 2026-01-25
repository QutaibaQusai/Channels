import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Reusable category card widget
/// Can be customized for different use cases (selection, browsing, etc.)
class AppCategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;
  final bool showArrow;
  final double? imageSize;

  const AppCategoryCard({
    super.key,
    required this.category,
    required this.onTap,
    this.showArrow = true,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final imgSize = imageSize ?? 48.w;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.r12),
      child: Container(
        padding: EdgeInsets.all(AppSizes.s16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSizes.r12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Category image
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.r8),
              child: category.imageUrl != null
                  ? Image.network(
                      category.imageUrl!,
                      width: imgSize,
                      height: imgSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(colorScheme, imgSize);
                      },
                    )
                  : _buildPlaceholder(colorScheme, imgSize),
            ),

            SizedBox(width: AppSizes.s16),

            // Category name
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),

            // Arrow icon (optional)
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ColorScheme colorScheme, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: Icon(
        Icons.category_outlined,
        color: colorScheme.primary,
        size: 24.sp,
      ),
    );
  }
}
