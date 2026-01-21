import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_state.dart';
import 'package:channels/features/authentication/data/data_sources/verify_otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/otp_remote_data_source.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final VerifyOtpRemoteDataSource verifyOtpRemoteDataSource;
  final OtpRemoteDataSource otpRemoteDataSource;
  Timer? _timer;
  int _resendTimer = 60;

  OtpVerificationCubit({
    required this.verifyOtpRemoteDataSource,
    required this.otpRemoteDataSource,
  }) : super(const OtpVerificationInitial());

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

  Future<void> verifyOtp(String otpCode, String phone) async {
    // Validate OTP code length
    if (otpCode.length < 4) {
      emit(const OtpVerificationFailure(
        errorMessage: 'Please enter the complete code',
      ));
      return;
    }

    emit(OtpVerificationLoading());
    try {
      // Call verify OTP API
      final response = await verifyOtpRemoteDataSource.verifyOtp(
        phone: phone,
        otp: otpCode,
      );

      // Emit success with user data and token
      emit(OtpVerificationSuccess(
        token: response.token,
        user: response.user,
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
      // Call resend OTP API
      await otpRemoteDataSource.requestOtp(
        phone: phone,
        countryCode: countryCode,
      );

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
