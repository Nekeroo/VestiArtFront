import 'package:dio/dio.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_config.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

enum Sort {
  dateCreate,
  title,
  type,
  person,
  reference;

  String get name {
    switch (this) {
      case Sort.dateCreate:
        return 'dateCreate';
      case Sort.title:
        return 'title';
      case Sort.type:
        return 'type';
      case Sort.person:
        return 'tag1';
      case Sort.reference:
        return 'tag2';
    }
  }

  String get label {
    switch (this) {
      case Sort.dateCreate:
        return 'Date de création';
      case Sort.title:
        return 'Titre';
      case Sort.type:
        return 'Type';
      case Sort.person:
        return 'Personnage';
      case Sort.reference:
        return 'Référence';
    }
  }
}

class ApiCreation extends ApiConfig {
  static ApiCreation instance = ApiCreation();

  Future<List<Creation>> getAll({
    int start = 0,
    int nbElements = 10,
    Sort sort = Sort.dateCreate,
  }) async {
    try {
      final queryParameters = {
        'start': start,
        'nbElement': nbElements,
        'sortKey': sort.name,
      };

      final response = await dio.get(
        'idea/retrieve',
        queryParameters: queryParameters,
      );

      return Creation.fromJsonList(response.data["ideas"]);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw sampleDioException;
    }
  }

  Future<void> delete(String id) async {
    try {
      await dio.delete('idea/delete/$id');
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw sampleDioException;
    }
  }
}
