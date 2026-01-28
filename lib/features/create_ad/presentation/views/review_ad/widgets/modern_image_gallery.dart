import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/shared/views/image_viewer_view.dart';

/// Modern Image Gallery with PageView
class ModernImageGallery extends StatefulWidget {
  final List<File> images;

  const ModernImageGallery({super.key, required this.images});

  @override
  State<ModernImageGallery> createState() => _ModernImageGalleryState();
}

class _ModernImageGalleryState extends State<ModernImageGallery> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 320.h,
      color: Colors.black,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewerView(
                        images: widget.images,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Image.file(
                  widget.images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),

          // Page Indicator
          if (widget.images.length > 1)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '${_currentPage + 1} / ${widget.images.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Navigation Arrows (if multiple images)
          if (widget.images.length > 1) ...[
            // Left Arrow
            if (_currentPage > 0)
              Positioned(
                left: 12.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.chevronLeft,
                        color: colorScheme.onSurface,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),

            // Right Arrow
            if (_currentPage < widget.images.length - 1)
              Positioned(
                right: 12.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: colorScheme.surface.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.chevronRight,
                        color: colorScheme.onSurface,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
