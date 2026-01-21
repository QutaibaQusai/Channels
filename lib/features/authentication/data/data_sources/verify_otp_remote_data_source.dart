import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/authentication/data/models/verify_otp_model.dart';

abstract class VerifyOtpRemoteDataSource {
  Future<VerifyOtpResponseModel> verifyOtp({
    required String phone,
    required String otp,
  });
}

class VerifyOtpRemoteDataSourceImpl implements VerifyOtpRemoteDataSource {
  final ApiConsumer apiConsumer;

  VerifyOtpRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<VerifyOtpResponseModel> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    // Parse OTP to integer
    final otpInt = int.tryParse(otp) ?? 0;

    // Create request model
    final requestModel = VerifyOtpRequestModel(
      phone: phone,
      otp: otpInt,
    );

    // Make API call
    final response = await apiConsumer.post(
      EndPoint.verifyOtp,
      data: requestModel.toJson(),
    );

    // Parse response
    return VerifyOtpResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
