import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_dropdown_field.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';

/// Dropdown select field for filters with options
class SelectFilterField extends StatefulWidget {
  final Filter filter;
  final ValueChanged<String?> onChanged;

  const SelectFilterField({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  @override
  State<SelectFilterField> createState() => _SelectFilterFieldState();
}

class _SelectFilterFieldState extends State<SelectFilterField> {
  List<String>? _generatedOptions;

  @override
  void initState() {
    super.initState();
    // Generate options for year filter if validation exists
    if (widget.filter.validation != null &&
        widget.filter.validation!.min != null &&
        widget.filter.validation!.max != null) {
      _generatedOptions = _generateYearOptions(
        widget.filter.validation!.min!,
        widget.filter.validation!.max!,
        widget.filter.validation!.step ?? 1,
      );
    }
  }

  List<String> _generateYearOptions(int min, int max, int step) {
    final List<String> options = [];
    for (int i = max; i >= min; i -= step) {
      options.add(i.toString());
    }
    return options;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Use generated options or filter options
    final options = _generatedOptions ??
        widget.filter.options?.map((opt) => opt.value).toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.filter.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: AppSizes.s8),
        AppDropdownField<String>(
          hintText: widget.filter.label,
          items: options.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
