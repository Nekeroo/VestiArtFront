import 'package:dio/dio.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

abstract class ApiConfig {
  final Dio dio = Dio();

  ApiConfig() {
    dio.options.baseUrl = 'https://vestiartapp.mathieugr.fr/';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final userToken = AuthenticationService.instance.currentUser?.token;

          options.headers['Content-Type'] = 'application/json';
          options.headers['Authorization'] = 'Bearer $userToken';
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) {
          final exception = DioException(
            requestOptions: error.requestOptions,
            response: error.response,
            type: error.type,
            error: NetworkException.fromDioError(error),
          );

          handler.reject(exception);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
      ),
    );
  }
}
