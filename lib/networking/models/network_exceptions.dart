import 'package:dio/dio.dart';

enum NetworkException {
  ideaNotFound,
  invalidCredentials,
  usernameAlreadyTaken,
  serverError,
  timeout,
  other;

  String get message {
    switch (this) {
      case NetworkException.ideaNotFound:
        return "L'idée n'a pas été trouvée";
      case NetworkException.invalidCredentials:
        return "Nom d'utilisateur ou mot de passe invalide";
      case NetworkException.usernameAlreadyTaken:
        return "Nom d'utilisateur déjà pris";
      default:
        return "Une erreur inattendue s'est produite";
    }
  }

  static NetworkException fromDioError(DioException error) {
    print(error.response?.data);
    final statusCode = error.response?.statusCode;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException.timeout;
      case DioExceptionType.badResponse:
        if (statusCode == 500) {
          return NetworkException.serverError;
        }

        return _getErrorFromBody(error.response?.data ?? {});
      default:
        return NetworkException.other;
    }
  }

  static NetworkException _getErrorFromBody(Map<String, dynamic> body) {
    final message = body['message'] as String?;

    switch (message) {
      case 'Idea not found':
        return NetworkException.ideaNotFound;
      case 'Invalid username or password':
        return NetworkException.invalidCredentials;
      case 'Username is already taken!':
        return NetworkException.usernameAlreadyTaken;
      default:
        return NetworkException.other;
    }
  }
}
