import 'package:vesti_art/networking/api_config.dart';

class CreationApi extends ApiConfig {
  Future<List<dynamic>> getRecent({int nbrOfCreations = 10}) async {
    try {
      final response = await dio.get('/retrieve/last/$nbrOfCreations');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
