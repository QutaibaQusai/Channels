import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:channels/features/authentication/domain/entities/country_entity.dart';
import 'package:channels/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:channels/features/authentication/presentation/cubit/otp/otp_state.dart';
import 'package:channels/core/errors/exceptions.dart';

class OtpCubit extends Cubit<OtpState> {
  final RequestOtpUseCase requestOtpUseCase;

  OtpCubit({required this.requestOtpUseCase}) : super(const OtpInitial());

  /// Update selected country
  void updateCountry(CountryEntity country) {
    emit(
      OtpInitial(
        selectedCountryCode: country.dialCode,
        selectedCountryISOCode: country.code,
      ),
    );
  }

  /// Clear phone validation error
  void clearPhoneError() {
    if (state.phoneError != null) {
      emit(
        OtpInitial(
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
        ),
      );
    }
  }

  /// Validate and send OTP
  Future<void> validateAndSendOtp({
    required String phone,
    required String emptyErrorMessage,
    required String invalidErrorMessage,
  }) async {
    // Clear any previous errors
    final trimmedPhone = phone.trim();

    // Validate phone number
    if (trimmedPhone.isEmpty) {
      emit(
        OtpInitial(
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
          phoneError: emptyErrorMessage,
        ),
      );
      return;
    }

    if (trimmedPhone.length < 9) {
      emit(
        OtpInitial(
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
          phoneError: invalidErrorMessage,
        ),
      );
      return;
    }

    // Format phone number
    final formattedPhone = _formatPhoneNumber(trimmedPhone);
    final fullPhoneNumber = _buildFullPhoneNumber(formattedPhone);

    // Send OTP
    emit(
      OtpLoading(
        selectedCountryCode: state.selectedCountryCode,
        selectedCountryISOCode: state.selectedCountryISOCode,
      ),
    );

    try {
      final response = await requestOtpUseCase(
        phone: fullPhoneNumber,
        countryCode: state.selectedCountryISOCode,
      );

      // Build formatted phone number for display (with space)
      final displayPhoneNumber = '${state.selectedCountryCode} $formattedPhone';

      emit(
        OtpSuccess(
          message: response.message,
          formattedPhoneNumber: displayPhoneNumber,
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
        ),
      );
    } on ServerException catch (e) {
      emit(
        OtpFailure(
          errorMessage: e.errModel.errorMessage,
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
        ),
      );
    } catch (e) {
      emit(
        OtpFailure(
          errorMessage: e.toString(),
          selectedCountryCode: state.selectedCountryCode,
          selectedCountryISOCode: state.selectedCountryISOCode,
        ),
      );
    }
  }

  /// Format phone number by removing leading zero
  String _formatPhoneNumber(String phone) {
    if (phone.startsWith('0')) {
      return phone.substring(1);
    }
    return phone;
  }

  /// Build full phone number with country code
  String _buildFullPhoneNumber(String formattedPhone) {
    final countryCodeWithoutPlus = state.selectedCountryCode.replaceAll(
      '+',
      '',
    );
    return '+$countryCodeWithoutPlus$formattedPhone';
  }
}
