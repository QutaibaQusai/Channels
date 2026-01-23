import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  final String selectedCountryCode;
  final String selectedCountryISOCode;
  final String? phoneError;

  const OtpState({
    this.selectedCountryCode = '+962',
    this.selectedCountryISOCode = 'JO',
    this.phoneError,
  });

  @override
  List<Object?> get props => [selectedCountryCode, selectedCountryISOCode, phoneError];
}

class OtpInitial extends OtpState {
  const OtpInitial({
    super.selectedCountryCode,
    super.selectedCountryISOCode,
    super.phoneError,
  });
}

class OtpLoading extends OtpState {
  const OtpLoading({
    required super.selectedCountryCode,
    required super.selectedCountryISOCode,
  });
}

class OtpSuccess extends OtpState {
  final String message;
  final String formattedPhoneNumber;

  const OtpSuccess({
    required this.message,
    required this.formattedPhoneNumber,
    required super.selectedCountryCode,
    required super.selectedCountryISOCode,
  });

  @override
  List<Object?> get props => [message, formattedPhoneNumber, selectedCountryCode, selectedCountryISOCode];
}

class OtpFailure extends OtpState {
  final String errorMessage;

  const OtpFailure({
    required this.errorMessage,
    required super.selectedCountryCode,
    required super.selectedCountryISOCode,
  });

  @override
  List<Object?> get props => [errorMessage, selectedCountryCode, selectedCountryISOCode];
}
