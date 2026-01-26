import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  final DateTime? selectedDate;
  final String? selectedCountryCode;
  final String? selectedCountryName;

  const RegisterInitial({
    this.selectedDate,
    this.selectedCountryCode,
    this.selectedCountryName,
  });

  @override
  List<Object?> get props => [selectedDate, selectedCountryCode, selectedCountryName];
}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

class RegisterFailure extends RegisterState {
  final String errorMessage;

  const RegisterFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
