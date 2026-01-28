import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/l10n/app_localizations.dart';

class MyAdStatusBadge extends StatelessWidget {
  final bool isApproved;

  const MyAdStatusBadge({super.key, required this.isApproved});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isApproved
            ? colorScheme.primary.withValues(alpha: 0.1)
            : colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: isApproved
              ? colorScheme.primary.withValues(alpha: 0.2)
              : colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isApproved ? LucideIcons.checkCircle : LucideIcons.clock,
            size: 14.sp,
            color: isApproved ? colorScheme.primary : colorScheme.error,
          ),
          SizedBox(width: 6.w),
          Text(
            isApproved ? l10n.statusLiveNow : l10n.statusPendingReview,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isApproved ? colorScheme.primary : colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
