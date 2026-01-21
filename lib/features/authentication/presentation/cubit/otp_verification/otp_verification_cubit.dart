import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  Timer? _timer;
  int _resendTimer = 60;

  OtpVerificationCubit() : super(const OtpVerificationInitial());

  void startResendTimer() {
    _resendTimer = 60;
    emit(OtpVerificationTimerTick(resendTimer: _resendTimer, canResend: false));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        _resendTimer--;
        emit(OtpVerificationTimerTick(
          resendTimer: _resendTimer,
          canResend: false,
        ));
      } else {
        timer.cancel();
        emit(const OtpVerificationTimerTick(
          resendTimer: 0,
          canResend: true,
        ));
      }
    });
  }

  Future<void> verifyOtp(String otpCode) async {
    // Validate OTP code length
    if (otpCode.length < 4) {
      emit(const OtpVerificationFailure(
        errorMessage: 'Please enter the complete code',
      ));
      return;
    }

    emit(OtpVerificationLoading());
    try {
      // TODO: Implement actual OTP verification API call
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success
      emit(const OtpVerificationSuccess(
        message: 'Phone number verified successfully!',
      ));
    } catch (e) {
      emit(OtpVerificationFailure(errorMessage: e.toString()));
    }
  }

  Future<void> resendOtp({
    required String phone,
    required String countryCode,
  }) async {
    emit(OtpResendLoading());
    try {
      // TODO: Implement actual resend OTP API call
      await Future.delayed(const Duration(seconds: 2));

      // Restart timer
      startResendTimer();

      emit(const OtpResendSuccess(message: 'Code resent successfully!'));
    } catch (e) {
      emit(OtpResendFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
