import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ================================
/// DIO PROVIDER (SINGLE INSTANCE)
/// ================================
final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: '', // Leave empty or set global baseUrl if you want
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  /// ---------- LOGGING ----------
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: (log) => debugPrint(log.toString()),
    ),
  );

  /// ---------- ERROR HANDLING ----------
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        debugPrint('════════════════════════════════════');
        debugPrint('DIO ERROR');
        debugPrint('Status: ${error.response?.statusCode}');
        debugPrint('URL: ${error.requestOptions.uri}');
        debugPrint('Message: ${error.message}');
        debugPrint('Response: ${error.response?.data}');
        debugPrint('════════════════════════════════════');
        handler.next(error);
      },
    ),
  );

  /// ---------- AUTO-DISPOSE SAFETY ----------
  ref.onDispose(() {
    dio.close();
  });

  return dio;
});
