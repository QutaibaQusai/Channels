import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/data/models/country_model.dart';

/// Custom phone input field with country code selector
class PhoneInputField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(CountryModel)? onCountryChanged;
  final String? initialCountryCode;
  final String? initialPlaceholder;
  final String? errorText;

  const PhoneInputField({
    super.key,
    this.controller,
    this.onChanged,
    this.onCountryChanged,
    this.initialCountryCode = '+962',
    this.initialPlaceholder = '7X XXX XXXX',
    this.errorText,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  late String _selectedCountryCode;
  late String _placeholder;

  @override
  void initState() {
    super.initState();
    _selectedCountryCode = widget.initialCountryCode ?? '+962';
    _placeholder = widget.initialPlaceholder ?? '7X XXX XXXX';
  }

  Future<void> _openCountryPicker() async {
    final selectedCountry = await context.push<CountryModel>(
      RouteNames.countryPicker,
    );

    if (selectedCountry != null) {
      setState(() {
        _selectedCountryCode = selectedCountry.dialingCode;
        _placeholder = selectedCountry.placeholder;
      });

      // Notify parent widget
      widget.onCountryChanged?.call(selectedCountry);

      // Clear phone input when country changes
      widget.controller?.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: widget.errorText != null
                  ? AppColors.error
                  : AppColors.borderLight,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Country code selector button
              InkWell(
                onTap: _openCountryPicker,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: AppColors.borderLight, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedCountryCode,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryLight,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.textSecondaryLight,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),

              // Phone number input field
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryLight,
                  ),
                  decoration: InputDecoration(
                    hintText: _placeholder,
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.textHintLight,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error message
        if (widget.errorText != null) ...[
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
