import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class AnnouncementBanner extends StatefulWidget {
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const AnnouncementBanner({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<AnnouncementBanner> createState() => _AnnouncementBannerState();
}

class _AnnouncementBannerState extends State<AnnouncementBanner> {
  bool _isVisible = true;

  void _dismiss() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSizes.s12),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.screenPaddingH,
        vertical: AppSizes.s12,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppSizes.r8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.megaphone,
              size: 18.sp,
              color: colorScheme.primary,
            ),
          ),
          horizontalSpace(12.w),
          Expanded(
            child: Text(
              widget.message,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: widget.textColor ?? colorScheme.onSurface,
              ),
            ),
          ),
          horizontalSpace(8.w),
          InkWell(
            onTap: _dismiss,
            child: Icon(
              LucideIcons.x,
              size: 18.sp,
              color:
                  widget.textColor?.withValues(alpha: 0.6) ??
                  colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
