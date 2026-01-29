import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class PreviewActionButtons extends StatelessWidget {
  final VoidCallback? onPublish;

  const PreviewActionButtons({super.key, this.onPublish});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline, width: 1)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
        child: _ActionButton(
          iconWidget: Icon(
            LucideIcons.upload,
            size: 20.sp,
            color: colorScheme.onPrimary,
          ),
          label: 'Publish Now', // TODO: Localize
          onTap: onPublish ?? () {},
          isPrimary: true,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget iconWidget;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.iconWidget,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.buttonHeightLarge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            horizontalSpace(8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? colorScheme.onPrimary
                    : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
