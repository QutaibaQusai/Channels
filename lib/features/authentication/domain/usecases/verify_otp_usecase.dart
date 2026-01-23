import 'package:channels/features/authentication/domain/entities/user_entity.dart';
import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<UserEntity> call({
    required String phone,
    required String otp,
  }) {
    return repository.verifyOtp(
      phone: phone,
      otp: otp,
    );
  }
}
