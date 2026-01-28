import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';

class ImageItem extends StatelessWidget {
  final File image;
  final int index;
  final ColorScheme colorScheme;
  final VoidCallback onRemove;

  const ImageItem({
    super.key,
    required this.image,
    required this.index,
    required this.colorScheme,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
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
              image,
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
            onTap: onRemove,
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
