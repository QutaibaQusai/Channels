import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/router/route_names.dart';

/// Upload Images View - Allow users to select images for their ad
/// Min: 3 images, Max: 30 images
class UploadImagesView extends StatefulWidget {
  final Map<String, dynamic> formData;
  final String categoryId; // Subcategory ID
  final String parentCategoryId; // Parent category ID

  const UploadImagesView({
    super.key,
    required this.formData,
    required this.categoryId,
    required this.parentCategoryId,
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
        child: Column(
          children: [
            // Image counter and info
            Container(
              padding: EdgeInsets.all(AppSizes.s16),
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20.sp,
                    color: colorScheme.primary,
                  ),
                  SizedBox(width: AppSizes.s8),
                  Expanded(
                    child: Text(
                      'Upload ${_images.length}/$_maxImages images (Min: $_minImages)',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Images grid
            Expanded(
              child: _images.isEmpty
                  ? _buildEmptyState(colorScheme)
                  : _buildImageGrid(colorScheme),
            ),

            // Bottom button
            Padding(
              padding: EdgeInsets.all(AppSizes.s16),
              child: AppButton(text: 'Next', onPressed: _handleNext),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 80.sp,
            color: colorScheme.outline.withValues(alpha: 0.5),
          ),
          SizedBox(height: AppSizes.s16),
          Text(
            'No images selected',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: AppSizes.s8),
          Text(
            'Tap the button below to add images',
            style: TextStyle(
              fontSize: 14.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppSizes.s32),
          ElevatedButton.icon(
            onPressed: _pickMultipleImages,
            icon: const Icon(Icons.add_a_photo),
            label: const Text('Add Images'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.s24,
                vertical: AppSizes.s12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid(ColorScheme colorScheme) {
    return GridView.builder(
      padding: EdgeInsets.all(AppSizes.s16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: _images.length + (_images.length < _maxImages ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _images.length) {
          // Add button
          return _buildAddButton(colorScheme);
        }

        // Image item
        return _buildImageItem(index, colorScheme);
      },
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
