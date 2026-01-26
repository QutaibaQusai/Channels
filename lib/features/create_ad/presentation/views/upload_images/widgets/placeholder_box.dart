import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class PlaceholderBox extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const PlaceholderBox({
    super.key,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
            verticalSpace(AppSizes.s4),
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
}
