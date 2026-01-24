import 'package:channels/core/api/end_points.dart';
import 'package:channels/features/authentication/data/models/user_model.dart';

class VerifyOtpRequestModel {
  final String phone;
  final int otp;

  VerifyOtpRequestModel({
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      ApiKey.phone: phone,
      ApiKey.otp: otp,
    };
  }
}

class VerifyOtpResponseModel {
  final String token;
  final UserModel user;

  VerifyOtpResponseModel({
    required this.token,
    required this.user,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      token: json[ApiKey.token] as String,
      user: UserModel.fromJson(json[ApiKey.user] as Map<String, dynamic>),
    );
  }
}
