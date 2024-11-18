import 'package:dio/dio.dart';
import 'package:flutter_awesome_app/utils/logging_interceptor.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.pexels.com/';
  final String _apiKey =
      '563492ad6f917000010000011bab5181d8e7469d874a626a549d0a38';

  ApiProvider() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Authorization'] = _apiKey;
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio get dio => _dio;
  String get baseUrl => _baseUrl;
}
