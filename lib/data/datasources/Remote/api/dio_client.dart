import 'package:dio/dio.dart';
//
// class DioClient {
//   static Dio create({String? token}) {
//     final dio = Dio(
//       BaseOptions(
//         connectTimeout: 10000,
//         receiveTimeout: 10000,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           if (token != null) 'Authorization': 'Bearer $token',
//         },
//       ),
//     );
//
//     dio.interceptors.add(
//       LogInterceptor(
//         requestBody: true,
//         responseBody: true,
//       ),
//     );
//
//     return dio;
//   }
// }

// In dio_client.dart
import 'package:flutter/cupertino.dart';

class DioClient {
  static Dio create({String? token}) {

    final dio = Dio(
      BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ),
    );

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

    // Add error interceptor to catch 400 errors
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          debugPrint('═══════════════════════════════════════════════════');
          debugPrint('DIO ERROR DETAILS:');
          debugPrint('Type: ${error.type}');
          debugPrint('Message: ${error.message}');
          debugPrint('Error: ${error.error}');
          debugPrint('Status Code: ${error.response?.statusCode}');
          debugPrint('Response Data: ${error.response?.data}');
          debugPrint('Request Method: ${error.requestOptions.method}');
          debugPrint('Request URL: ${error.requestOptions.path}');
          debugPrint('Request Data: ${error.requestOptions.data}');
          debugPrint('═══════════════════════════════════════════════════');
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}