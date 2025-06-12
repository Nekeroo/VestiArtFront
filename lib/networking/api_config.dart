import 'package:dio/dio.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

abstract class ApiConfig {
  final Dio dio = Dio();

  ApiConfig() {
    dio.options.baseUrl = 'https://vestiartapp.mathieugr.fr/';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    final userToken = AuthenticationService.instance.currentUser?.token;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Content-Type'] = 'application/json';
          options.headers['Authorization'] = 'Bearer $userToken';
          printRequestData(options);
          handler.next(options);
        },
        onResponse: (response, handler) {
          printResponseData(response);
          handler.next(response);
        },
        onError: (error, handler) {
          printResponseData(error.response);
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
  }

  void printRequestData(RequestOptions? options) {
    if (options == null) return;
    print("REQUEST ENDPOINT => ${options.path}");
    print("REQUEST METHOD => ${options.method}");
    print("REQUEST DATA => ${options.data}");
  }

  void printResponseData(Response? response) {
    if (response == null) return;
    print("RESPONSE ENDPOINT => ${response.requestOptions.path}");
    print("RESSPONSE STATUS CODE => ${response.statusCode}");
    print("RESSPONSE DATA => ${response.data}");
  }
}
