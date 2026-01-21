import 'package:channels/core/api/end_ponits.dart';

class OtpRequestModel {
  final String phone;
  final String countryCode;

  OtpRequestModel({
    required this.phone,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.phone: phone,
      ApiKey.countryCode: countryCode,
    };
  }
}

class OtpResponseModel {
  final String message;

  OtpResponseModel({
    required this.message,
  });

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) {
    return OtpResponseModel(
      message: json[ApiKey.message] as String,
    );
  }
}
