import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';

/// Hero carousel widget for displaying promotional images
class HeroCarousel extends StatelessWidget {
  final List<String> images;

  const HeroCarousel({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textExtension = Theme.of(context).extension<AppColorsExtension>()!;

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
            width: double.infinity,
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
