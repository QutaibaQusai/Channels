import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/profile/domain/entities/profile.dart';

/// Profile model - data layer
class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    super.name,
    required super.phone,
    required super.status,
    required super.languageCode,
    required super.countryCode,
    super.dateOfBirth,
    required super.createdAt,
    required super.isMe,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json[ApiKey.id] as String,
      name: json[ApiKey.name] as String?,
      phone: json[ApiKey.phone] as String,
      status: json[ApiKey.status] as String,
      languageCode: json[ApiKey.languageCode] as String,
      countryCode: json[ApiKey.countryCode] as String,
      dateOfBirth: json[ApiKey.dateOfBirth] as String?,
      createdAt: DateTime.parse(json[ApiKey.createdAt] as String),
      isMe: json[ApiKey.isMe] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ApiKey.id: id,
      ApiKey.name: name,
      ApiKey.phone: phone,
      ApiKey.status: status,
      ApiKey.languageCode: languageCode,
      ApiKey.countryCode: countryCode,
      ApiKey.dateOfBirth: dateOfBirth,
      ApiKey.createdAt: createdAt.toIso8601String(),
      ApiKey.isMe: isMe,
    };
  }
}
