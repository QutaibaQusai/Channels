import 'dart:convert';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
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
