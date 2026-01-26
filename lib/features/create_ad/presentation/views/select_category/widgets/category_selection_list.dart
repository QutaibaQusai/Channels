import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_category_card.dart';

/// Simple list of categories for selection when creating an ad
class CategorySelectionList extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) onCategorySelected;
  final String title;
  final String subTitle;

  const CategorySelectionList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    this.title = '',
    this.subTitle = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        if (subTitle.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.s16),
            child: Text(
              subTitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: categories.length,
          separatorBuilder: (context, index) => SizedBox(height: AppSizes.s12),
          itemBuilder: (context, index) {
            final category = categories[index];

            return AppCategoryCard(
              category: category,
              onTap: () => onCategorySelected(category),
            );
          },
        ),
      ],
    );
  }
}
