import 'package:dio/dio.dart';
import 'package:vesti_art/core/models/stats.dart';
import 'package:vesti_art/networking/api_config.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class ApiStats extends ApiConfig {
  static ApiStats instance = ApiStats();

  Future<StatsData> getStats() async {
    try {
      final response = await dio.get('/stat/retrieve');
      return StatsData.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (_) {
      throw sampleDioException;
    }
  }
}
