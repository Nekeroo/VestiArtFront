import 'package:vesti_art/core/models/user.dart';
import 'package:vesti_art/networking/api_config.dart';

class ApiAuthentication extends ApiConfig {
  static ApiAuthentication instance = ApiAuthentication();

  Future<User> login(String username, String password) async {
    final response = await dio.post(
      '/auth/api/login',
      data: {'username': username, 'password': password},
    );

    return User.fromJson(response.data);
  }

  Future<User> register(String username, String password) async {
    final response = await dio.post(
      '/auth/api/register',
      data: {'username': username, 'password': password},
    );

    return User.fromJson(response.data);
  }
}
