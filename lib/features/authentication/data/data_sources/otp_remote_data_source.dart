import 'package:channels/core/api/api_consumer.dart';
import 'package:channels/core/api/end_ponits.dart';
import 'package:channels/features/authentication/data/models/otp_request_model.dart';

abstract class OtpRemoteDataSource {
  Future<OtpResponseModel> requestOtp({
    required String phone,
    required String countryCode,
  });
}

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final ApiConsumer apiConsumer;

  OtpRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OtpResponseModel> requestOtp({
    required String phone,
    required String countryCode,
  }) async {
    // Format phone number: remove leading 0 if present
    String formattedPhone = phone;
    if (formattedPhone.startsWith('0')) {
      formattedPhone = formattedPhone.substring(1);
    }

    // Create request model
    final requestModel = OtpRequestModel(
      phone: formattedPhone,
      countryCode: countryCode,
    );

    // Make API call
    final response = await apiConsumer.post(
      EndPoint.requestOtp,
      data: requestModel.toJson(),
    );

    // Parse response
    return OtpResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
