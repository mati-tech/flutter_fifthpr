// lib/data/datasources/remote/api/interceptors/auth_interceptor.dart
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String apiKey;

  AuthInterceptor(this.apiKey);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Добавляем API ключ как query параметр
    options.queryParameters['appid'] = apiKey;
    super.onRequest(options, handler);
  }
}