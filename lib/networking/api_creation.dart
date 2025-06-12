import 'package:dio/dio.dart';
import 'package:vesti_art/networking/api_config.dart';

class CreationApi extends ApiConfig {
  // Future<List<dynamic>> getRecent({int nbrOfCreations = 10}) async {
  //   try {
  //     final response = await dio.get('idea/retrieve/last/$nbrOfCreations');
  //     return response.data;
  //   } on DioException catch (e) {
  //     // Log the error or show a message to the user
  //     print('DioException: $e');
  //     rethrow;
  //   } catch (e) {
  //     // Handle other types of errors
  //     print('Error: $e');
  //     rethrow;
  //   }
  // }

  Future<List<dynamic>> getAll() async {
    try {
      final response = await dio.get('idea/retrieve/all');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
