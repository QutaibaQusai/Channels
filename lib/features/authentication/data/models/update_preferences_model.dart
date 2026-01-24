import 'package:channels/core/api/end_points.dart';

class UpdatePreferencesRequestModel {
  final String name;
  final String dateOfBirth;

  UpdatePreferencesRequestModel({
    required this.name,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.dateOfBirth: dateOfBirth,
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
