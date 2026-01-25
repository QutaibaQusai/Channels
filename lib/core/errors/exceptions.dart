import 'package:channels/core/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'Connection timeout with server'),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'Bad certificate'),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'Request to server was cancelled'),
      );
    case DioExceptionType.connectionError:
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'No Internet Connection'),
      );
    case DioExceptionType.unknown:
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'Unexpected error occurred'),
      );
    case DioExceptionType.badResponse:
      if (e.response != null && e.response!.data != null) {
        throw ServerException(
          errModel: ErrorModel.fromJson(
            e.response!.data,
            status: e.response?.statusCode,
          ),
        );
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: e.response?.statusCode,
            errorMessage: 'Server returned an empty error response',
          ),
        );
      }
  }
}
