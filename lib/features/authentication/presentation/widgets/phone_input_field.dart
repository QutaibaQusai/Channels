import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;
    final fieldHeight = AppSizes.inputHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Country code selector button
            InkWell(
              onTap: _openCountryPicker,
              borderRadius: BorderRadius.circular(AppSizes.r12),
              child: Container(
                height: fieldHeight,
                padding: EdgeInsets.symmetric(horizontal: AppSizes.s16),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  border: Border.all(
                    color: widget.errorText != null
                        ? colorScheme.error
                        : textExtension.border,
                    width: 1.5,
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
                        color: colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: AppSizes.s8),
                    Icon(
                      Icons.arrow_drop_down,
                      color: textExtension.textSecondary,
                      size: AppSizes.icon16,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: AppSizes.s8),

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
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: _placeholder,
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: textExtension.textHint,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSizes.s16,
                    vertical: AppSizes.s12,
                  ),
                ),
              ),
            ),
          ],
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
                color: colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
