// // lib/data/datasources/remote/api/interceptors/logging_interceptor.dart
// import 'package:dio/dio.dart';
//
//
// class LoggingInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     print('📤 Request: ${options.method} ${options.url}');
//     print('📋 Headers: ${options.headers}');
//     print('📦 Data: ${options.data}');
//     super.onRequest(options, handler);
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     print('✅ Response: ${response.statusCode} ${response.requestOptions.url}');
//     print('📦 Data: ${response.data}');
//     super.onResponse(response, handler);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     print('❌ Error: ${err.type} ${err.requestOptions.url}');
//     print('📝 Message: ${err.message}');
//     print('📦 Response: ${err.response?.data}');
//     super.onError(err, handler);
//   }
// }