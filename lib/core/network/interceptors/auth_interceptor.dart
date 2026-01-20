import 'package:dio/dio.dart';

/// Interceptor to add authentication token to requests
class AuthInterceptor extends Interceptor {
  final String authToken;

  AuthInterceptor({required this.authToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $authToken';
    super.onRequest(options, handler);
  }
}
