import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Get current locale language code
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final languageCode = locale.languageCode;

    // Add language header - only add 'ar' if Arabic, otherwise don't add header
    if (languageCode == 'ar') {
      options.queryParameters['lang'] = 'ar';
    }

    super.onRequest(options, handler);
  }
}
