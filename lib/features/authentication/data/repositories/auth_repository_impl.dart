import 'package:channels/features/authentication/data/data_sources/countries_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/otp_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/update_preferences_remote_data_source.dart';
import 'package:channels/features/authentication/data/data_sources/verify_otp_remote_data_source.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/domain/entities/otp_response_entity.dart';
import 'package:channels/features/authentication/domain/entities/user_entity.dart';
import 'package:channels/features/authentication/domain/repositories/auth_repository.dart';

/// Implementation of authentication repository
class AuthRepositoryImpl implements AuthRepository {
  final OtpRemoteDataSource otpDataSource;
  final VerifyOtpRemoteDataSource verifyOtpDataSource;
  final CountriesRemoteDataSource countriesDataSource;
  final UpdatePreferencesRemoteDataSource updatePreferencesDataSource;

  AuthRepositoryImpl({
    required this.otpDataSource,
    required this.verifyOtpDataSource,
    required this.countriesDataSource,
    required this.updatePreferencesDataSource,
  });

  @override
  Future<OtpResponseEntity> requestOtp({
    required String phone,
    required String countryCode,
  }) async {
    final response = await otpDataSource.requestOtp(
      phone: phone,
      countryCode: countryCode,
    );

    return OtpResponseEntity(
      message: response.message,
    );
  }

  @override
  Future<UserEntity> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    final response = await verifyOtpDataSource.verifyOtp(
      phone: phone,
      otp: otp,
    );

    return UserEntity(
      id: response.user.id,
      name: response.user.name,
      phone: response.user.phone,
      status: response.user.status,
      languageCode: response.user.languageCode,
      countryCode: response.user.countryCode,
      dateOfBirth: response.user.dateOfBirth,
      token: response.token,
    );
  }

  @override
  Future<List<CountryEntity>> getCountries({
    required String languageCode,
  }) async {
    final countries = await countriesDataSource.getCountries(languageCode);

    return countries
        .map((country) => CountryEntity(
              code: country.code,
              name: country.name,
              dialCode: country.dialingCode,
              placeholder: country.placeholder,
              flagUrl: country.flagUrl,
            ))
        .toList();
  }

  @override
  Future<void> updatePreferences({
    required String token,
    required String name,
    required String dateOfBirth,
  }) async {
    await updatePreferencesDataSource.updatePreferences(
      token: token,
      name: name,
      dateOfBirth: dateOfBirth,
    );
  }
}
