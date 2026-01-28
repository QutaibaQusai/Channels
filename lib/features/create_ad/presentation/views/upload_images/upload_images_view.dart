import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/create_ad/presentation/views/upload_images/widgets/images_grid.dart';

/// Upload Images View - Allow users to select images for their ad
/// Min: 3 images, Max: 30 images
class UploadImagesView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Map<String, String> displayData;
  final String categoryId; // Subcategory ID
  final String parentCategoryId; // Parent category ID
  final String rootCategoryId; // Root category (for API submission)

  const UploadImagesView({
    super.key,
    required this.formData,
    required this.displayData,
    required this.categoryId,
    required this.parentCategoryId,
    required this.rootCategoryId,
  });

  @override
  State<UploadImagesView> createState() => _UploadImagesViewState();
}

class _UploadImagesViewState extends State<UploadImagesView> {
  final List<File?> _images = List<File?>.filled(30, null, growable: false);
  final ImagePicker _picker = ImagePicker();
  static const int _minImages = 3;
  static const int _maxImages = 30;

  int get _imageCount => _images.where((img) => img != null).length;

  List<File> get _nonNullImages =>
      _images.where((img) => img != null).cast<File>().toList();

  Future<void> _pickMultipleImages() async {
    if (_imageCount >= _maxImages) {
      if (!mounted) return;
      AppToast.error(context, title: 'Maximum $_maxImages images allowed');
      return;
    }

    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFiles.isNotEmpty) {
        final remainingSlots = _maxImages - _imageCount;
        final imagesToAdd = pickedFiles.take(remainingSlots).toList();

        setState(() {
          int addedCount = 0;
          for (
            int i = 0;
            i < _images.length && addedCount < imagesToAdd.length;
            i++
          ) {
            if (_images[i] == null) {
              _images[i] = File(imagesToAdd[addedCount].path);
              addedCount++;
            }
          }
        });

        if (pickedFiles.length > remainingSlots) {
          if (!mounted) return;
          AppToast.info(
            context,
            title: 'Only $remainingSlots images added (max $_maxImages total)',
          );
        }
      }
    } catch (e) {
      if (!mounted) return;
      AppToast.error(context, title: 'Failed to pick images');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images[index] = null;
    });
  }

  void _handleNext() {
    if (_imageCount < _minImages) {
      AppToast.error(
        context,
        title: 'Please select at least $_minImages images',
      );
      return;
    }

    context.push(
      RouteNames.createAdDetails,
      extra: {
        'formData': widget.formData,
        'displayData': widget.displayData,
        'categoryId': widget.categoryId,
        'parentCategoryId': widget.parentCategoryId,
        'rootCategoryId': widget.rootCategoryId,
        'images': _nonNullImages,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const AppAppBar(title: 'Upload Images', showBackButton: true),
      body: SafeArea(
        bottom: false,
        child: GradientOverlay(
          bottomWidget: Padding(
            padding: EdgeInsets.all(AppSizes.s16),
            child: AppButton(text: 'Next', onPressed: _handleNext),
          ),
          child: ImagesGrid(
            images: _images,
            maxImages: _maxImages,
            colorScheme: colorScheme,
            onAddTap: _pickMultipleImages,
            onRemoveImage: _removeImage,
          ),
        ),
      ),
    );
  }
}
