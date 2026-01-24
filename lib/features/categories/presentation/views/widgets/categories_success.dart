import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/shared/widgets/app_search_bar.dart';
import 'package:channels/core/shared/widgets/app_empty_state.dart';
import 'package:channels/core/shared/widgets/app_refresh_wrapper.dart';
import 'package:channels/features/categories/domain/entities/categories_response.dart';
import 'package:channels/features/categories/presentation/cubit/categories_cubit.dart';
import 'package:channels/features/categories/presentation/views/widgets/hero_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/l10n/app_localizations.dart';

class CategoriesSuccessContent extends StatelessWidget {
  final CategoriesResponse data;
  final void Function(String categoryId)? onCategoryTap;

  const CategoriesSuccessContent({
    super.key,
    required this.data,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    // Check if categories are empty
    if (data.categories.isEmpty) {
      return const AppEmptyState(
        icon: Icons.category_outlined,
        message: 'No categories found',
        subtitle: 'Categories will appear here when available',
      );
    }

    return AppRefreshWrapper(
      onRefresh: () => context.read<CategoriesCubit>().refreshCategories(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: AppSizes.s24, bottom: AppSizes.s16),
              child: AppSearchBar(hintText: l10n.categoriesSearchHint),
            ),
          ),

          if (data.heroImages.isNotEmpty)
            SliverToBoxAdapter(child: HeroCarousel(images: data.heroImages)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.s12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.categoriesSectionTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      // TODO: handle see more
                    },
                    child: Row(
                      children: [
                        Text(
                          l10n.categoriesSeeMore,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.only(bottom: AppSizes.s96),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: AppSizes.s12,
                mainAxisSpacing: AppSizes.s12,
                childAspectRatio: 3 / 4,
              ),
              itemCount: data.categories.length,
              itemBuilder: (context, index) {
                final category = data.categories[index];
                final initial = category.name.isNotEmpty
                    ? category.name.characters.first
                    : '?';
                return InkWell(
                  onTap: () => onCategoryTap?.call(category.id),
                  borderRadius: BorderRadius.circular(AppSizes.r8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppSizes.r8),
                      border: Border.all(color: textExtension.borderSubtle),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSizes.r8),
                              topRight: Radius.circular(AppSizes.r8),
                            ),
                            child: category.imageUrl != null
                                ? Image.network(
                                    category.imageUrl!,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              color: colorScheme.primary
                                                  .withValues(alpha: 0.08),
                                              child: Center(
                                                child: Text(
                                                  initial,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: colorScheme.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                  )
                                : Container(
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.08,
                                    ),
                                    child: Center(
                                      child: Text(
                                        initial,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(AppSizes.s8),
                          child: Text(
                            category.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
