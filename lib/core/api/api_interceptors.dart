import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:channels/core/services/secure_storage_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add auth token to headers (except for auth endpoints)
    final isAuthEndpoint = options.path.contains('auth/');

    if (!isAuthEndpoint) {
      final token = await SecureStorageService.getAuthToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Encode body data as JSON string for GET requests
    if (options.method == 'GET' &&
        options.data != null &&
        options.data is Map) {
      options.headers['Content-Type'] = 'application/json';
      options.data = json.encode(options.data);
    }

    super.onRequest(options, handler);
  }
}
