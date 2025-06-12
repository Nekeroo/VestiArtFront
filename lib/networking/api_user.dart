import 'package:dio/dio.dart';
import 'package:vesti_art/core/models/user.dart';
import 'package:vesti_art/networking/api_config.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class ApiUser extends ApiConfig {
  static final ApiUser instance = ApiUser();

  Future<User> getMe() async {
    try {
      final response = await dio.get('/auth/me');
      return User.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw sampleDioException;
    }
  }
}
