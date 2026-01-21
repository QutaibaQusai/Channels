import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  final DateTime? selectedDate;

  const RegisterInitial({this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
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
