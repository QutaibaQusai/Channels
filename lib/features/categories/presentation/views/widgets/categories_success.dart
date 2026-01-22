import 'package:carousel_slider/carousel_slider.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/shared/widgets/search_bar_widget.dart';
import 'package:channels/features/categories/domain/entities/categories_response.dart';
import 'package:flutter/material.dart';
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

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.s24, bottom: AppSizes.s16),
            child: SearchBarWidget(hintText: l10n.categoriesSearchHint),
          ),
        ),

        if (data.heroImages.isNotEmpty)
          SliverToBoxAdapter(
            child: _HeroCarousel(
              images: data.heroImages,
              colorScheme: colorScheme,
              textExtension: textExtension,
            ),
          ),

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
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
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
    );
  }
}

class _HeroCarousel extends StatelessWidget {
  final List<String> images;
  final ColorScheme colorScheme;
  final AppColorsExtension textExtension;

  const _HeroCarousel({
    required this.images,
    required this.colorScheme,
    required this.textExtension,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.r8),
      child: CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          enableInfiniteScroll: images.length > 1,
          autoPlay: images.length > 1,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayCurve: Curves.easeInOut,
        ),
        itemBuilder: (context, index, realIndex) {
          final imageUrl = images[index];
          return Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: colorScheme.surface,
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: textExtension.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
