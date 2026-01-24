import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';

/// Custom phone input field with country code selector
class PhoneInputField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(CountryEntity)? onCountryChanged;
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
    final selectedCountry = await context.push<CountryEntity>(
      RouteNames.countryPicker,
    );

    if (selectedCountry != null) {
      setState(() {
        _selectedCountryCode = selectedCountry.dialCode;
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
        // Force LTR layout for phone input (even in RTL languages like Arabic)
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
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
                    border: widget.errorText != null
                        ? Border.all(color: colorScheme.error, width: 2)
                        : null,
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
                      horizontalSpace(AppSizes.s8),
                      Icon(
                        Icons.arrow_drop_down,
                        color: textExtension.textSecondary,
                        size: AppSizes.icon16,
                      ),
                    ],
                  ),
                ),
              ),

              horizontalSpace(AppSizes.s8),

              // Phone number input field
              Expanded(
                child: SizedBox(
                  height: fieldHeight,
                  child: TextField(
                    autofocus: true,
                    controller: widget.controller,
                    onChanged: widget.onChanged,
                    keyboardType: TextInputType.phone,
                    textDirection: TextDirection.ltr,
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

                      filled: true,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        borderSide: BorderSide(
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        borderSide: BorderSide(
                          color: colorScheme.error,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                        borderSide: BorderSide(
                          color: colorScheme.error,
                          width: 2,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSizes.s16,
                        vertical: AppSizes.s12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Error message
        if (widget.errorText != null) ...[
          verticalSpace(AppSizes.s8),
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
