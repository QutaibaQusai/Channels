import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:channels/core/theme/app_colors.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/helpers/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/custom_app_bar.dart';
import 'package:channels/features/authentication/presentation/widgets/phone_input_field.dart';

/// Phone authentication view - User enters phone number
class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({super.key});

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends State<PhoneAuthView> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

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
        _errorText = 'Please enter your phone number';
      });
      return;
    }

    if (phone.length < 9) {
      setState(() {
        _errorText = 'Please enter a valid phone number';
      });
      return;
    }

    // TODO: Implement OTP sending logic
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // TODO: Navigate to OTP verification view
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('OTP sent successfully!')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(showBackButton: true),
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
                'Enter your phone number',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
              ),

              verticalSpace(AppSizes.s12),

              // Subtitle
              Text(
                'We\'ll send you a verification code to confirm your number',
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
              ),

              const Spacer(),

              // Send OTP button
              AppButton(
                text: 'Send OTP',
                onPressed: _sendOTP,
                isLoading: _isLoading,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),

              verticalSpace(AppSizes.s32),
            ],
          ),
        ),
      ),
    );
  }
}
