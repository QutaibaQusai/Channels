import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/l10n/app_localizations.dart';

/// Attributes grid widget showing ad properties like year, color, etc.
class AdDetailsAttributes extends StatelessWidget {
  final Map<String, dynamic> attributes;

  const AdDetailsAttributes({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final l10n = AppLocalizations.of(context)!;

    // Filter out null/empty values
    final validAttributes = attributes.entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .toList();

    if (validAttributes.isEmpty) {
      return const SizedBox.shrink();
    }

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

        SizedBox(height: 12.h),

        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: Column(
            children: validAttributes.asMap().entries.map((entry) {
              final index = entry.key;
              final attr = entry.value;
              final isLast = index == validAttributes.length - 1;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatAttributeKey(attr.key),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: textExtension.textSecondary,
                          ),
                        ),
                        Text(
                          attr.value.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) Divider(height: 1, color: textExtension.divider),
                ],
              );
            }).toList(),
          ),
        ),
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
