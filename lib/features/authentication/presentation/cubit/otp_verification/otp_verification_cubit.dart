import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/presentation/cubit/otp_verification/otp_verification_state.dart';
import 'package:channels/core/errors/exceptions.dart';
import 'package:channels/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:channels/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:channels/core/services/secure_storage_service.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final VerifyOtpUseCase verifyOtpUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  Timer? _timer;
  int _resendTimer = 60;

  OtpVerificationCubit({
    required this.verifyOtpUseCase,
    required this.requestOtpUseCase,
  }) : super(const OtpVerificationInitial());

  void startResendTimer() {
    _resendTimer = 60;
    emit(OtpVerificationTimerTick(resendTimer: _resendTimer, canResend: false));

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        _resendTimer--;
        emit(
          OtpVerificationTimerTick(resendTimer: _resendTimer, canResend: false),
        );
      } else {
        timer.cancel();
        emit(const OtpVerificationTimerTick(resendTimer: 0, canResend: true));
      }
    });
  }

  Future<void> verifyOtp(String otpCode, String phone) async {
    // Validate OTP code length
    if (otpCode.length < 4) {
      emit(
        const OtpVerificationFailure(
          errorMessage: 'Please enter the complete code',
        ),
      );
      return;
    }

    emit(OtpVerificationLoading());
    try {
      // Call verify OTP use case
      final user = await verifyOtpUseCase(phone: phone, otp: otpCode);

      // Save token and user ID to secure storage
      await SecureStorageService.saveAuthToken(user.token);
      await SecureStorageService.saveUserId(user.id);

      // Emit success with user data and token
      emit(OtpVerificationSuccess(token: user.token, user: user));
    } on ServerException catch (e) {
      emit(OtpVerificationFailure(errorMessage: e.errModel.errorMessage));
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
      // Call resend OTP use case
      await requestOtpUseCase(phone: phone, countryCode: countryCode);

      // Restart timer
      startResendTimer();

      emit(const OtpResendSuccess(message: 'Code resent successfully!'));
    } on ServerException catch (e) {
      emit(OtpResendFailure(errorMessage: e.errModel.errorMessage));
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
