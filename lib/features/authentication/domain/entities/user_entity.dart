import 'package:equatable/equatable.dart';

/// Domain entity for user
class UserEntity extends Equatable {
  final String id;
  final String? name;
  final String phone;
  final String status;
  final String languageCode;
  final String countryCode;
  final String? dateOfBirth;
  final String token;

  const UserEntity({
    required this.id,
    this.name,
    required this.phone,
    required this.status,
    required this.languageCode,
    required this.countryCode,
    this.dateOfBirth,
    required this.token,
  });

  /// Helper method to check if user needs to complete registration
  bool get needsRegistration => name == null || dateOfBirth == null;

  @override
  List<Object?> get props => [id, phone, name, status, languageCode, countryCode, dateOfBirth, token];
}
