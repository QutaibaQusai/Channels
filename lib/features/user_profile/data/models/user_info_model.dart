import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/user_profile/domain/entities/user_info.dart';

/// User Info model - data layer
class UserInfoModel extends UserInfo {
  const UserInfoModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.status,
    required super.languageCode,
    required super.countryCode,
    required super.countryName,
    super.dayOfBirth,
    required super.createdAt,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json[ApiKey.id] as String,
      name: json[ApiKey.name] as String,
      phone: json[ApiKey.phone] as String,
      status: json[ApiKey.status] as String,
      languageCode: json[ApiKey.languageCode] as String,
      countryCode: json[ApiKey.countryCode] as String,
      countryName: json[ApiKey.countryName] as String,
      dayOfBirth: json['day-of-dirth'] as String?,
      createdAt: DateTime.parse(json[ApiKey.createdAt] as String),
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
      ApiKey.countryName: countryName,
      'day-of-dirth': dayOfBirth,
      ApiKey.createdAt: createdAt.toIso8601String(),
    };
  }
}
