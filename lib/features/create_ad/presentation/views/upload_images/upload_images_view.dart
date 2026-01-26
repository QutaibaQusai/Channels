import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/shared/widgets/gradient_overlay.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/router/route_names.dart';

/// Upload Images View - Allow users to select images for their ad
/// Min: 3 images, Max: 30 images
class UploadImagesView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String categoryId; // Subcategory ID
  final String parentCategoryId; // Parent category ID
  final String rootCategoryId; // Root category (for API submission)

  const UploadImagesView({
    super.key,
    required this.formData,
    required this.categoryId,
    required this.parentCategoryId,
    required this.rootCategoryId,
  });

  @override
  State<UploadImagesView> createState() => _UploadImagesViewState();
}

class _UploadImagesViewState extends State<UploadImagesView> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  static const int _minImages = 3;
  static const int _maxImages = 30;

  Future<void> _pickMultipleImages() async {
    debugPrint('📸 _pickMultipleImages called');
    debugPrint('📸 Current images count: ${_images.length}');

    if (_images.length >= _maxImages) {
      debugPrint('📸 Maximum images reached: $_maxImages');
      if (!mounted) return;
      AppToast.error(context, title: 'Maximum $_maxImages images allowed');
      return;
    }

    try {
      debugPrint('📸 Opening image picker...');
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      debugPrint('📸 Picked ${pickedFiles.length} files');

      if (pickedFiles.isNotEmpty) {
        final remainingSlots = _maxImages - _images.length;
        final imagesToAdd = pickedFiles.take(remainingSlots).toList();

        debugPrint('📸 Adding ${imagesToAdd.length} images to the list');

        setState(() {
          _images.addAll(imagesToAdd.map((file) => File(file.path)));
        });

        debugPrint('📸 Total images now: ${_images.length}');

        if (pickedFiles.length > remainingSlots) {
          if (!mounted) return;
          AppToast.info(
            context,
            title: 'Only $remainingSlots images added (max $_maxImages total)',
          );
        }
      } else {
        debugPrint('📸 No images selected by user');
      }
    } catch (e, stackTrace) {
      debugPrint('📸 Error picking images: $e');
      debugPrint('📸 Stack trace: $stackTrace');
      if (!mounted) return;
      AppToast.error(context, title: 'Failed to pick images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _handleNext() {
    if (_images.length < _minImages) {
      AppToast.error(
        context,
        title: 'Please select at least $_minImages images',
      );
      return;
    }

    debugPrint('📸 Images selected: ${_images.length}');
    debugPrint('📸 Form data: ${widget.formData}');
    debugPrint('📸 Navigating to ad details form...');

    // Navigate to ad details form
    context.push(
      RouteNames.createAdDetails,
      extra: {
        'formData': widget.formData,
        'categoryId': widget.categoryId,
        'parentCategoryId': widget.parentCategoryId,
        'rootCategoryId': widget.rootCategoryId,
        'images': _images,
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
          child: _buildImageGrid(colorScheme),
        ),
      ),
    );
  }

  Widget _buildImageGrid(ColorScheme colorScheme) {
    // Show at least 12 placeholder boxes if empty, otherwise show images + add button
    final int itemCount = _images.isEmpty
        ? 12 // Show 12 placeholder boxes when empty (4 rows x 3 columns)
        : _images.length + (_images.length < _maxImages ? 1 : 0);

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
        // If no images, show placeholders
        if (_images.isEmpty) {
          return _buildPlaceholderBox(colorScheme);
        }

        // Show images + add button
        if (index == _images.length) {
          return _buildAddButton(colorScheme);
        }

        return _buildImageItem(index, colorScheme);
      },
    );
  }

  Widget _buildPlaceholderBox(ColorScheme colorScheme) {
    return InkWell(
      onTap: _pickMultipleImages,
      borderRadius: BorderRadius.circular(AppSizes.r16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              size: 32.sp,
              color: colorScheme.outline.withValues(alpha: 0.4),
            ),
            SizedBox(height: AppSizes.s4),
            Text(
              'Tap to add',
              style: TextStyle(
                fontSize: 10.sp,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(ColorScheme colorScheme) {
    return InkWell(
      onTap: _pickMultipleImages,
      borderRadius: BorderRadius.circular(AppSizes.r16),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppSizes.r16),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 40.sp,
              color: colorScheme.primary,
            ),
            SizedBox(height: AppSizes.s4),
            Text(
              'Add',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(int index, ColorScheme colorScheme) {
    final isFirst = index == 0;

    return Stack(
      children: [
        // Image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.r16),
            border: Border.all(
              color: isFirst
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.2),
              width: isFirst ? 3 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r16 - 2),
            child: Image.file(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),

        // Primary badge
        if (isFirst)
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(AppSizes.r8),
              ),
              child: Text(
                'الرئيسية',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),

        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: () => _removeImage(index),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: colorScheme.error,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 16.sp, color: colorScheme.onError),
            ),
          ),
        ),
      ],
    );
  }
}
