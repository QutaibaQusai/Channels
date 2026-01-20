import 'package:dio/dio.dart';

/// Standardized API error model
class ApiError {
  final String message;
  final int? statusCode;
  final ApiErrorType type;

  ApiError({
    required this.message,
    this.statusCode,
    required this.type,
  });

  factory ApiError.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'Connection timeout. Please try again.',
          type: ApiErrorType.timeout,
        );

      case DioExceptionType.badResponse:
        return ApiError(
          message: _parseErrorMessage(exception.response),
          statusCode: exception.response?.statusCode,
          type: ApiErrorType.response,
        );

      case DioExceptionType.cancel:
        return ApiError(
          message: 'Request was cancelled',
          type: ApiErrorType.cancel,
        );

      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No internet connection',
          type: ApiErrorType.network,
        );

      default:
        return ApiError(
          message: 'An unexpected error occurred',
          type: ApiErrorType.unknown,
        );
    }
  }

  static String _parseErrorMessage(Response? response) {
    if (response?.data is Map) {
      final data = response!.data as Map<String, dynamic>;
      return data['message'] ?? data['error'] ?? 'Server error occurred';
    }
    return 'Server error occurred';
  }

  @override
  String toString() => message;
}

enum ApiErrorType {
  network,
  timeout,
  response,
  cancel,
  unknown,
}
