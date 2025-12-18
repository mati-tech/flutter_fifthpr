// lib/data/datasources/remote/api/exceptions/network_exceptions.dart
abstract class NetworkException implements Exception {
  final String message;
  final dynamic data;

  NetworkException(this.message, [this.data]);

  @override
  String toString() => 'NetworkException: $message';
}

class TimeoutException extends NetworkException {
  TimeoutException(String message) : super(message);
}

class BadRequestException extends NetworkException {
  BadRequestException(String message, dynamic data) : super(message, data);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException(String message) : super(message);
}

class ServerException extends NetworkException {
  final int statusCode;

  ServerException(String message, this.statusCode) : super(message);
}