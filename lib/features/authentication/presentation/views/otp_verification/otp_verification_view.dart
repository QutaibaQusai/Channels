import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:channels/core/theme/app_theme_extensions.dart';
import 'package:channels/core/theme/app_sizes.dart';
import 'package:channels/core/utils/spacing.dart';
import 'package:channels/core/shared/widgets/app_button.dart';
import 'package:channels/core/shared/widgets/app_bar.dart';
import 'package:channels/l10n/app_localizations.dart';
import 'package:channels/core/router/route_names.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_cubit.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_state.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification/widgets/otp_input_widget.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification/widgets/otp_resend_widget.dart';
import 'package:channels/features/authentication/presentation/views/otp_verification/widgets/otp_error_widget.dart';

/// OTP verification view - User enters OTP code
class OtpVerificationView extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationView({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    context.read<OtpVerificationCubit>().startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textExtension = theme.extension<AppColorsExtension>()!;

    return BlocListener<OtpVerificationCubit, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          // Navigate based on user data
          if (state.user.needsRegistration) {
            // New user - navigate to register view (allow back navigation)
            // Pass token as extra data
            context.push(RouteNames.register, extra: state.token);
          } else {
            // Existing user - navigate to home (replace stack)
            context.pushReplacement(RouteNames.home);
          }
        } else if (state is OtpResendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.otpVerificationOtpResent)),
          );
        } else if (state is OtpResendFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const AppAppBar(showBackButton: true),
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
                  l10n.otpVerificationTitle,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                verticalSpace(AppSizes.s12),

                // Subtitle with phone number
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: textExtension.textSecondary,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: l10n.otpVerificationSubtitle,
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      // Force LTR for phone number display
                      WidgetSpan(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            widget.phoneNumber,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(AppSizes.s40),

                // OTP Input Fields
                OtpInputWidget(
                  onCodeChanged: (code) {
                    // Clear any previous errors when user types
                  },
                  onSubmit: (verificationCode) {
                    setState(() {
                      _otpCode = verificationCode;
                    });
                  },
                ),

                // Error message from cubit
                BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                  builder: (context, state) {
                    if (state is OtpVerificationFailure) {
                      return Column(
                        children: [
                          verticalSpace(AppSizes.s16),
                          OtpErrorWidget(errorMessage: state.errorMessage),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                verticalSpace(AppSizes.s24),

                // Resend OTP section
                BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                  builder: (context, state) {
                    int resendTimer = 60;
                    bool canResend = false;
                    bool isResending = state is OtpResendLoading;

                    if (state is OtpVerificationTimerTick) {
                      resendTimer = state.resendTimer;
                      canResend = state.canResend;
                    }

                    return OtpResendWidget(
                      canResend: canResend,
                      resendTimer: resendTimer,
                      isResending: isResending,
                      onResend: () {
                        // TODO: Extract phone and country code from widget.phoneNumber
                        context.read<OtpVerificationCubit>().resendOtp(
                              phone: widget.phoneNumber,
                              countryCode: 'JO',
                            );
                      },
                    );
                  },
                ),

                const Spacer(),

                // Verify button
                BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
                  builder: (context, state) {
                    return AppButton(
                      text: l10n.otpVerificationVerifyButton,
                      onPressed: () {
                        context.read<OtpVerificationCubit>().verifyOtp(
                              _otpCode,
                              widget.phoneNumber,
                            );
                      },
                      isLoading: state is OtpVerificationLoading,
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
