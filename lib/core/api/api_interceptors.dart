import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:channels/core/services/secure_storage_service.dart';
import 'package:channels/core/constants/storage_keys.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get user's chosen language from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(StorageKeys.languageCode) ?? 'en';

    // Add lang to query params for GET, to body for other methods
    if (options.method == 'GET') {
      options.queryParameters['lang'] = langCode;
    } else {
      // For POST/PUT/PATCH/DELETE - add to body
      if (options.data == null) {
        options.data = {'lang': langCode};
      } else if (options.data is Map) {
        (options.data as Map)['lang'] = langCode;
      }
    }
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
