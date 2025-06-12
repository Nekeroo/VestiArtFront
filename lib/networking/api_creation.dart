import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_config.dart';

class CreationApi extends ApiConfig {
  static CreationApi instance = CreationApi();

  Future<List<Creation>> getAll() async {
    try {
      final response = await dio.get('idea/retrieve/all');
      return Creation.fromJsonList(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
