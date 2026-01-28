import 'dart:io';
import 'package:flutter/material.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/features/create_ad/presentation/views/upload_images/widgets/placeholder_box.dart';
import 'package:channels/features/create_ad/presentation/views/upload_images/widgets/image_item.dart';

class ImagesGrid extends StatelessWidget {
  final List<File?> images;
  final int maxImages;
  final ColorScheme colorScheme;
  final VoidCallback onAddTap;
  final void Function(int) onRemoveImage;

  const ImagesGrid({
    super.key,
    required this.images,
    required this.maxImages,
    required this.colorScheme,
    required this.onAddTap,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final hasAnyImage = images.any((img) => img != null);

    // Always show 30 items
    final int itemCount = maxImages;

    return GridView.builder(
      padding: EdgeInsets.only(
        left: AppSizes.screenPaddingH,
        right: AppSizes.screenPaddingH,
        bottom: AppSizes.s96,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // If we have images, check if this slot has an image
        if (hasAnyImage && index < images.length) {
          final image = images[index];

          if (image != null) {
            return ImageItem(
              image: image,
              index: index,
              colorScheme: colorScheme,
              onRemove: () => onRemoveImage(index),
            );
          }
        }

        // Show placeholder for empty slots
        return PlaceholderBox(
          colorScheme: colorScheme,
          onTap: onAddTap,
        );
      },
    );
  }
}
