import 'package:channels/core/api/end_ponits.dart';

class UserModel {
  final String id;
  final String? name;
  final String phone;
  final String status;
  final String languageCode;
  final String countryCode;
  final String? address;

  UserModel({
    required this.id,
    this.name,
    required this.phone,
    required this.status,
    required this.languageCode,
    required this.countryCode,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[ApiKey.id] as String,
      name: json[ApiKey.name] as String?,
      phone: json[ApiKey.phone] as String,
      status: json[ApiKey.status] as String,
      languageCode: json[ApiKey.languageCode] as String,
      countryCode: json[ApiKey.countryCode] as String,
      address: json[ApiKey.address] as String?,
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
      ApiKey.address: address,
    };
  }

  // Helper method to check if user needs to complete registration
  bool get needsRegistration => name == null || address == null;
}
