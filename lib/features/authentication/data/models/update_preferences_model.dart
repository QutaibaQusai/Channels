import 'package:channels/core/api/end_ponits.dart';

class UpdatePreferencesRequestModel {
  final String name;
  final String address;

  UpdatePreferencesRequestModel({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.address: address,
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
