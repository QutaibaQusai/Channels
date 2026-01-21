import 'package:equatable/equatable.dart';
import 'package:channels/features/authentication/data/models/user_model.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {
  final int resendTimer;
  final bool canResend;

  const OtpVerificationInitial({
    this.resendTimer = 60,
    this.canResend = false,
  });

  @override
  List<Object?> get props => [resendTimer, canResend];
}

class OtpVerificationTimerTick extends OtpVerificationState {
  final int resendTimer;
  final bool canResend;

  const OtpVerificationTimerTick({
    required this.resendTimer,
    required this.canResend,
  });

  @override
  List<Object?> get props => [resendTimer, canResend];
}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {
  final String token;
  final UserModel user;

  const OtpVerificationSuccess({
    required this.token,
    required this.user,
  });

  @override
  List<Object?> get props => [token, user];
}

class OtpVerificationFailure extends OtpVerificationState {
  final String errorMessage;

  const OtpVerificationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class OtpResendLoading extends OtpVerificationState {}

class OtpResendSuccess extends OtpVerificationState {
  final String message;

  const OtpResendSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpResendFailure extends OtpVerificationState {
  final String errorMessage;

  const OtpResendFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
