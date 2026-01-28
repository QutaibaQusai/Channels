import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/shared/widgets/app_text_field.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';

class PriceField extends StatelessWidget {
  final TextEditingController controller;
  final ColorScheme colorScheme;

  const PriceField({
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
          'Price *',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        verticalSpace(AppSizes.s8),
        AppTextField(
          controller: controller,
          hintText: 'Enter price',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Price is required';
            }
            final price = double.tryParse(value.trim());
            if (price == null) {
              return 'Please enter a valid number';
            }
            if (price < 0) {
              return 'Price cannot be negative';
            }
            return null;
          },
        ),
      ],
    );
  }
}
