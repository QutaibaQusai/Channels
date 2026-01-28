import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class DescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;

  const DescriptionField({
    super.key,
    required this.controller,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        verticalSpace(AppSizes.s8),
        AppTextField(
          controller: controller,
          hintText: 'Enter detailed description',
          maxLines: 5,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Description is required';
            }
            if (value.trim().length < 10) {
              return 'Description must be at least 10 characters';
            }
            if (value.trim().length > 1000) {
              return 'Description must not exceed 1000 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
