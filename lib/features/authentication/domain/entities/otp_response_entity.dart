import 'package:equatable/equatable.dart';

/// Domain entity for OTP response
class OtpResponseEntity extends Equatable {
  final String message;

  const OtpResponseEntity({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
