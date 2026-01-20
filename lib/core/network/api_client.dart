import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:channels/core/network/interceptors/auth_interceptor.dart';
import 'package:channels/core/network/interceptors/logging_interceptor.dart';
import 'package:channels/core/constants/app_constants.dart';

/// Centralized API client using Dio for Channels app
class ApiClient {
  late final Dio _dio;
  final Logger _logger = Logger();

  ApiClient({
    String? baseUrl,
    String? authToken,
    int? connectTimeout,
    int? receiveTimeout,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout ?? AppConstants.apiTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout ?? AppConstants.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _setupInterceptors(authToken);
  }

  void _setupInterceptors(String? authToken) {
    _dio.interceptors.add(LoggingInterceptor());

    if (authToken != null) {
      _dio.interceptors.add(AuthInterceptor(authToken: authToken));
    }
  }

  /// Update auth token dynamically
  void updateAuthToken(String token) {
    _dio.interceptors.removeWhere((interceptor) => interceptor is AuthInterceptor);
    _dio.interceptors.add(AuthInterceptor(authToken: token));
  }

  /// Clear auth token
  void clearAuthToken() {
    _dio.interceptors.removeWhere((interceptor) => interceptor is AuthInterceptor);
  }

  // ==================== HTTP METHODS ====================

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      _logger.e('GET request failed: $path', error: e);
      rethrow;
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      _logger.e('POST request failed: $path', error: e);
      rethrow;
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      _logger.e('PUT request failed: $path', error: e);
      rethrow;
    }
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      _logger.e('PATCH request failed: $path', error: e);
      rethrow;
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      _logger.e('DELETE request failed: $path', error: e);
      rethrow;
    }
  }

  /// Upload file/images
  Future<Response<T>> upload<T>(
    String path, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      _logger.e('Upload request failed: $path', error: e);
      rethrow;
    }
  }
}
