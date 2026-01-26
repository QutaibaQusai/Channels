import 'package:channels/core/api/end_points.dart';

class UpdatePreferencesRequestModel {
  final String name;
  final String dateOfBirth;
  final String countryCode;

  UpdatePreferencesRequestModel({
    required this.name,
    required this.dateOfBirth,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.dateOfBirth: dateOfBirth,
      ApiKey.countryCode: countryCode,
    };
  }
}

class UpdatePreferencesResponseModel {
  final String status;

  UpdatePreferencesResponseModel({
    required this.status,
  });

  factory UpdatePreferencesResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdatePreferencesResponseModel(
      status: json[ApiKey.status] as String,
    );
  }
}
