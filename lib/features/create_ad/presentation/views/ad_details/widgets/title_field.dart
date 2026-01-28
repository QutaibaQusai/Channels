import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class TitleField extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;

  const TitleField({
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
          'Ad Title *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        verticalSpace(AppSizes.s8),
        AppTextField(
          controller: controller,
          hintText: 'Enter ad title',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Title is required';
            }
            if (value.trim().length < 3) {
              return 'Title must be at least 3 characters';
            }
            if (value.trim().length > 100) {
              return 'Title must not exceed 100 characters';
            }
            return null;
          },
        ),
      ],
    );
  }
}
