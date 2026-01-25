import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/features/create_ad/domain/entities/filter.dart';

/// Text input field for filters
class TextFilterField extends StatefulWidget {
  final Filter filter;
  final ValueChanged<String> onChanged;

  const TextFilterField({
    super.key,
    required this.filter,
    required this.onChanged,
  });

  @override
  State<TextFilterField> createState() => _TextFilterFieldState();
}

class _TextFilterFieldState extends State<TextFilterField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
        AppTextField(
          controller: _controller,
          hintText: widget.filter.label,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
