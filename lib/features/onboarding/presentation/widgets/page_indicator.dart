import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';

/// Page indicator dots for onboarding
class PageIndicator extends StatelessWidget {
  final int pageCount;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.pageCount,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textExtension = Theme.of(context).extension<AppColorsExtension>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => _buildDot(index == currentPage, colorScheme, textExtension),
      ),
    );
  }

  Widget _buildDot(
    bool isActive,
    ColorScheme colorScheme,
    AppColorsExtension textExtension,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      height: 8.h,
      width: 8.w,
      decoration: BoxDecoration(
        color: isActive ? colorScheme.primary : textExtension.border,
        shape: BoxShape.circle,
      ),
    );
  }
}
