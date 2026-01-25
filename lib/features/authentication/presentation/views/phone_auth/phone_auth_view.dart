import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/shared/widgets/app_toast.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/presentation/views/phone_auth/widgets/phone_input_field.dart';
import 'package:channels/features/authentication/presentation/views/phone_auth/widgets/phone_auth_header.dart';
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

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccess) {
          // Navigate to OTP verification view with formatted phone number
          context.push(
            RouteNames.otpVerification,
            extra: state.formattedPhoneNumber,
          );
        } else if (state is OtpFailure) {
          // Show error message using AppToast
          AppToast.error(context, title: state.errorMessage);
        }
      },
      child: Scaffold(
        appBar: AppAppBar(showBackButton: false),
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                PhoneAuthHeader(
                  title: l10n.phoneAuthTitle,
                  subtitle: l10n.phoneAuthSubtitle,
                ),

                // Phone input field
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    return PhoneInputField(
                      controller: _phoneController,
                      errorText: state.phoneError,
                      initialCountryCode: state.selectedCountryCode,
                      onChanged: (value) {
                        // Clear error when user types
                        context.read<OtpCubit>().clearPhoneError();
                      },
                      onCountryChanged: (country) {
                        // Update selected country in cubit
                        context.read<OtpCubit>().updateCountry(country);
                      },
                    );
                  },
                ),

                const Spacer(),

                // Send OTP button
                BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    return AppButton(
                      text: l10n.phoneAuthSendButton,
                      onPressed: () {
                        context.read<OtpCubit>().validateAndSendOtp(
                          phone: _phoneController.text,
                          emptyErrorMessage: l10n.phoneAuthErrorEmpty,
                          invalidErrorMessage: l10n.phoneAuthErrorInvalid,
                        );
                      },
                      isLoading: state is OtpLoading,
                      backgroundColor: colorScheme.primary,
                      textColor: colorScheme.onPrimary,
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
