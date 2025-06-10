import 'package:dio/dio.dart';

enum NetworkException {
  serverError,
  timeout,
  badRequest,
  notFound,
  other;

  String get message {
    switch (this) {
      default:
        return "Une erreur inattendue s'est produite";
    }
  }

  static NetworkException fromDioError(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException.timeout;
      case DioExceptionType.badResponse:
        if (statusCode == 500) {
          return NetworkException.serverError;
        } else if (statusCode == 400) {
          return NetworkException.badRequest;
        } else if (statusCode == 404) {
          return NetworkException.notFound;
        }
        return NetworkException.other;
      default:
        return NetworkException.other;
    }
  }
}
