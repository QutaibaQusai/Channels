import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/domain/entities/otp_response_entity.dart';
import 'package:channels/features/authentication/domain/entities/user_entity.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Request OTP for phone number
  Future<OtpResponseEntity> requestOtp({
    required String phone,
    required String countryCode,
  });

  /// Verify OTP code
  Future<UserEntity> verifyOtp({
    required String phone,
    required String otp,
  });

  /// Get list of countries
  Future<List<CountryEntity>> getCountries({
    required String languageCode,
  });

  /// Update user preferences
  Future<void> updatePreferences({
    required String token,
    required String name,
    required String dateOfBirth,
  });
}
