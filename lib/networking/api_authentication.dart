import 'package:dio/dio.dart';
import 'package:vesti_art/core/models/user.dart';
import 'package:vesti_art/networking/api_config.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class ApiAuthentication extends ApiConfig {
  static ApiAuthentication instance = ApiAuthentication();

  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/api/login',
        data: {'username': username, 'password': password},
      );
      return User.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      print(e);
      throw sampleDioException;
    }
  }

  Future<User> register(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/api/register',
        data: {'username': username, 'password': password},
      );
      return User.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw sampleDioException;
    }
  }
}
