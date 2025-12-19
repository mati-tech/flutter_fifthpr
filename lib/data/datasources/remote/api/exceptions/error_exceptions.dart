// // lib/data/datasources/remote/api/interceptors/error_interceptor.dart
// import 'package:dio/dio.dart';
// import './exceptions/network_exceptions.dart';
//
// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     final exception = _mapDioErrorToException(err);
//     handler.reject(err.copyWith(error: exception));
//   }
//
//   Exception _mapDioErrorToException(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return TimeoutException('Превышено время ожидания ответа от сервера');
//
//       case DioExceptionType.badResponse:
//         return _handleBadResponse(error.response!);
//
//       case DioExceptionType.unknown:
//         if (error.error.toString().contains('SocketException')) {
//           return NetworkException('Нет подключения к интернету');
//         }
//         return NetworkException('Неизвестная сетевая ошибка');
//
//       default:
//         return NetworkException('Произошла сетевая ошибка');
//     }
//   }
//
//   Exception _handleBadResponse(Response response) {
//     final statusCode = response.statusCode;
//
//     switch (statusCode) {
//       case 400:
//         return BadRequestException('Неверный запрос', response.data);
//       case 401:
//         return UnauthorizedException('Требуется аутентификация');
//       case 500:
//         return ServerException('Ошибка сервера', statusCode);
//       default:
//         return NetworkException('HTTP ошибка $statusCode', statusCode);
//     }
//   }
// }