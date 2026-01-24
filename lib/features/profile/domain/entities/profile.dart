import 'package:equatable/equatable.dart';

/// Profile entity - domain layer
class Profile extends Equatable {
  final String id;
  final String? name;
  final String phone;
  final String status;
  final String languageCode;
  final String countryCode;
  final String? dateOfBirth;
  final DateTime createdAt;
  final bool isMe;

  const Profile({
    required this.id,
    this.name,
    required this.phone,
    required this.status,
    required this.languageCode,
    required this.countryCode,
    this.dateOfBirth,
    required this.createdAt,
    required this.isMe,
  });

  /// Get formatted phone number with country code
  String get formattedPhone => '+$phone';

  /// Check if profile is complete
  bool get isProfileComplete => name != null && dateOfBirth != null;

  /// Get display name or fallback
  String get displayName => name ?? 'User';

  /// Get first name (first part of name)
  String get firstName {
    if (name == null || name!.isEmpty) return '';
    final parts = name!.split(' ');
    return parts.first;
  }

  /// Get last name (rest of name after first)
  String get lastName {
    if (name == null || name!.isEmpty) return '';
    final parts = name!.split(' ');
    if (parts.length <= 1) return '';
    return parts.sublist(1).join(' ');
  }

  /// Get initials for avatar
  String get initials {
    if (name == null || name!.isEmpty) return 'U';
    final parts = name!.split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phone,
    status,
    languageCode,
    countryCode,
    dateOfBirth,
    createdAt,
    isMe,
  ];
}
