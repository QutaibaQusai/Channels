
import 'package:channels/core/api/end_points.dart';

class ErrorModel {
  final int? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    // Try different error message keys
    String message = '';

    if (jsonData.containsKey('error')) {
      message = jsonData['error'] as String;
    } else if (jsonData.containsKey(ApiKey.errorMessage)) {
      message = jsonData[ApiKey.errorMessage] as String;
    } else if (jsonData.containsKey('message')) {
      message = jsonData['message'] as String;
    } else {
      message = 'An error occurred';
    }

    return ErrorModel(
      status: jsonData[ApiKey.status],
      errorMessage: message,
    );
  }
}