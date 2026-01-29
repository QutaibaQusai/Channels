import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/core/theme/app_sizes.dart';

/// Image carousel widget for ad details
class AdDetailsImages extends StatefulWidget {
  final List<String> images;

  const AdDetailsImages({super.key, required this.images});

  @override
  State<AdDetailsImages> createState() => _AdDetailsImagesState();
}

class _AdDetailsImagesState extends State<AdDetailsImages> {
  int _currentIndex = 0;
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
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.images.isEmpty) {
      return _buildPlaceholder(context);
    }

    return SizedBox(
      height: 350.h,
      child: Stack(
        children: [
          // Image PageView
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  context.push(
                    RouteNames.imageViewer,
                    extra: {'images': widget.images, 'initialIndex': index},
                  );
                },
                child: Image.network(
                  widget.images[index],
                  width: double.infinity,
                  height: 350.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildPlaceholder(context),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              );
            },
          ),

          // Image indicator dots
          if (widget.images.length > 1)
            Positioned(
              bottom: 16.h,
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
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(AppSizes.rFull),
                    ),
                  ),
                ),
              ),
            ),

          // Image count badge
          if (widget.images.length > 1)
            Positioned(
              bottom: 40.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(AppSizes.r16),
                ),
                child: Text(
                  '${_currentIndex + 1}/${widget.images.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      height: 350.h,
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.image_outlined,
        size: 64.sp,
        color: colorScheme.onSurface.withValues(alpha: 0.3),
      ),
    );
  }
}
