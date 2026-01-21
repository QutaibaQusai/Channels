import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/localization/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/presentation/widgets/phone_input_field.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_state.dart';

/// Phone authentication view - User enters phone number
class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final TextEditingController _phoneController = TextEditingController();
  String? _errorText;
  String _selectedCountryCode = '+962';
  String _selectedCountryISOCode = 'JO';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOTP() {
    setState(() {
      _errorText = null;
    });

    // Validate phone number
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() {
        _errorText = 'phoneAuth.errorEmpty'.tr(context);
      });
      return;
    }

    if (phone.length < 9) {
      setState(() {
        _errorText = 'phoneAuth.errorInvalid'.tr(context);
      });
      return;
    }

    // Format phone number: combine country code + phone number
    // Remove + from country code and remove leading 0 from phone if exists
    String formattedCountryCode = _selectedCountryCode.replaceAll('+', '');
    String formattedPhone = phone;
    if (formattedPhone.startsWith('0')) {
      formattedPhone = formattedPhone.substring(1);
    }

    final fullPhoneNumber = '+$formattedCountryCode$formattedPhone';

    // Call OTP API
    context.read<OtpCubit>().requestOtp(
      phone: fullPhoneNumber,
      countryCode: _selectedCountryISOCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          // Navigate to OTP verification view
          final phone = _phoneController.text.trim();
          String formattedPhone = phone;
          if (formattedPhone.startsWith('0')) {
            formattedPhone = formattedPhone.substring(1);
          }
          final fullPhoneNumber = '$_selectedCountryCode $formattedPhone';
          context.push(RouteNames.otpVerification, extra: fullPhoneNumber);
        } else if (state is OtpFailure) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(AppSizes.s20),

                // Title
                Text(
                  'phoneAuth.title'.tr(context),
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryLight,
                  ),
                ),

                verticalSpace(AppSizes.s12),

                // Subtitle
                Text(
                  'phoneAuth.subtitle'.tr(context),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.textSecondaryLight,
                    height: 1.5,
                  ),
                ),

                verticalSpace(AppSizes.s40),

                // Phone input field
                PhoneInputField(
                  controller: _phoneController,
                  errorText: _errorText,
                  onChanged: (value) {
                    if (_errorText != null) {
                      setState(() {
                        _errorText = null;
                      });
                    }
                  },
                  onCountryChanged: (country) {
                    setState(() {
                      _selectedCountryCode = country.dialingCode;
                      _selectedCountryISOCode = country.code;
                    });
                  },
                ),

                const Spacer(),

                // Send OTP button
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    return AppButton(
                      text: 'phoneAuth.sendButton'.tr(context),
                      onPressed: _sendOTP,
                      isLoading: state is OtpLoading,
                      backgroundColor: AppColors.primary,
                      textColor: Colors.white,
                    );
                  },
                ),

                verticalSpace(AppSizes.s32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
