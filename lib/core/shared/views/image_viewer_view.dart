import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Full-screen image viewer with zoom and swipe functionality
/// Supports both network images (URLs) and local files
class ImageViewerView extends StatefulWidget {
  final List<dynamic> images; // Can be List<String> (URLs) or List<File> (local files)
  final int initialIndex;

  const ImageViewerView({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewerView> createState() => _ImageViewerViewState();
}

class _ImageViewerViewState extends State<ImageViewerView> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImage(dynamic image) {
    if (image is File) {
      // Local file
      return Image.file(
        image,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Icon(
          Icons.broken_image_outlined,
          size: 64.sp,
          color: Colors.white54,
        ),
      );
    } else if (image is String) {
      // Network URL
      return Image.network(
        image,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (_, __, ___) => Icon(
          Icons.broken_image_outlined,
          size: 64.sp,
          color: Colors.white54,
        ),
      );
    }
    // Fallback
    return Icon(
      Icons.image_not_supported_outlined,
      size: 64.sp,
      color: Colors.white54,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppAppBar(
          title: '${_currentIndex + 1} / ${widget.images.length}',
          showBackButton: true,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            // Image PageView with zoom
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Center(
                    child: _buildImage(widget.images[index]),
                  ),
                );
              },
            ),

            // Bottom indicator dots
            if (widget.images.length > 1)
              Positioned(
                bottom: 32.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      width: index == _currentIndex ? 24.w : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: index == _currentIndex
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(AppSizes.rFull),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
