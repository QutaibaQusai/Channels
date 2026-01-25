import 'package:flutter/material.dart';
import 'package:channels/features/categories/domain/entities/category.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_category_card.dart';

/// Simple list of categories for selection when creating an ad
class CategorySelectionList extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) onCategorySelected;

  const CategorySelectionList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: AppSizes.s16),
      itemCount: categories.length,
      separatorBuilder: (context, index) => SizedBox(height: AppSizes.s12),
      itemBuilder: (context, index) {
        final category = categories[index];

        return AppCategoryCard(
          category: category,
          onTap: () => onCategorySelected(category),
          showArrow: true,
        );
      },
    );
  }
}
