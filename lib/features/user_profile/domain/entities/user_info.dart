import 'package:equatable/equatable.dart';

/// User information entity
class UserInfo extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String status;
  final String languageCode;
  final String countryCode;
  final String countryName;
  final String? dayOfBirth;
  final DateTime createdAt;

  const UserInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.status,
    required this.languageCode,
    required this.countryCode,
    required this.countryName,
    this.dayOfBirth,
    required this.createdAt,
  });

  /// Get user initials for avatar
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  /// Check if user is active
  bool get isActive => status == 'active';

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        status,
        languageCode,
        countryCode,
        countryName,
        dayOfBirth,
        createdAt,
      ];
}
