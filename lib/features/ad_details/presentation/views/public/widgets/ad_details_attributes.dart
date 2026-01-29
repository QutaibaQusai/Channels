import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Attributes grid widget showing ad properties like year, color, etc.
class AdDetailsAttributes extends StatefulWidget {
  final Map<String, dynamic> attributes;

  const AdDetailsAttributes({super.key, required this.attributes});

  @override
  State<AdDetailsAttributes> createState() => _AdDetailsAttributesState();
}

class _AdDetailsAttributesState extends State<AdDetailsAttributes> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // Filter out null/empty values
    final validAttributes = widget.attributes.entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .toList();

    if (validAttributes.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxVisible = 5;
    final hasMore = validAttributes.length > maxVisible;
    final displayedAttributes = _isExpanded
        ? validAttributes
        : validAttributes.take(maxVisible).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.adDetailsAttributes,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),

        verticalSpace(12.h),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Column(
            children: List.generate(displayedAttributes.length, (index) {
              final entry = displayedAttributes[index];
              final isEven = index % 2 == 0;
              final isLast = index == displayedAttributes.length - 1;

              return Container(
                decoration: BoxDecoration(
                  color: isEven
                      ? colorScheme.surface
                      : colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.vertical(
                    top: index == 0 ? Radius.circular(11.r) : Radius.zero,
                    bottom: isLast ? Radius.circular(11.r) : Radius.zero,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatAttributeKey(entry.key),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      entry.value.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),

        if (hasMore) ...[
          verticalSpace(8.h),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              children: [
                Text(
                  _isExpanded ? 'See less' : 'See more',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  _isExpanded
                      ? LucideIcons.chevronUp
                      : LucideIcons.chevronDown,
                  size: 16.sp,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Format attribute key from snake_case to Title Case
  String _formatAttributeKey(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
