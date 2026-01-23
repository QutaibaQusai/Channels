import 'package:channels/features/authentication/domain/entities/otp_response_entity.dart';
import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for requesting OTP
class RequestOtpUseCase {
  final AuthRepository repository;

  RequestOtpUseCase(this.repository);

  Future<OtpResponseEntity> call({
    required String phone,
    required String countryCode,
  }) {
    return repository.requestOtp(
      phone: phone,
      countryCode: countryCode,
    );
  }
}
