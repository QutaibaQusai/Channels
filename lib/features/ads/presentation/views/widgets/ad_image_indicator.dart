import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdImageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const AdImageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          height: 6.h,
          width: isActive ? 16.w : 6.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: isActive ? 0.9 : 0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
        );
      }),
    );
  }
}
