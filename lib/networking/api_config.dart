import 'package:dio/dio.dart';

abstract class ApiConfig {
  final dio = Dio();

  ApiConfig() {
    dio.options.baseUrl = 'https://vestiartapp.mathieugr.fr/';
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }
}
