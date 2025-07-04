import 'package:dio/dio.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/models/creation_draft.dart';
import 'package:vesti_art/networking/api_config.dart';
import 'package:vesti_art/networking/models/creations_response.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

enum Sort {
  dateCreate,
  title,
  type,
  person,
  reference,
  mine;

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
      case Sort.mine:
        return 'mine';
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
      case Sort.mine:
        return 'Mes Créations';
    }
  }
}

class ApiCreation extends ApiConfig {
  static ApiCreation instance = ApiCreation();

  Future<CreationsResponse> getAllPagined({
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
      return CreationsResponse.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      print(e);
      throw sampleDioException;
    }
  }

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

  Future<CreationsResponse> getMe({int start = 0, int nbElements = 10}) async {
    try {
      final queryParameters = {'start': start, 'nbElement': nbElements};

      final response = await dio.get(
        'idea/retrieve/mine',
        queryParameters: queryParameters,
      );

      return CreationsResponse.fromJson(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw sampleDioException;
    }
  }

  Future<CreationsResponse> getByType({
    int start = 0,
    int nbElements = 10,
    required ReferenceType type,
  }) async {
    try {
      final queryParameters = {
        'start': start,
        'nbElement': nbElements,
        'type': type.name.toUpperCase(),
      };

      final response = await dio.get(
        'idea/retrieve/type',
        queryParameters: queryParameters,
      );

      return CreationsResponse.fromJson(response.data);
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

  Future<List<Creation>> create(List<CreationDraft> creations) async {
    try {
      final response = await dio.post(
        '/innovation/create',
        data: creations.toJson(),
      );
      return Creation.fromJsonList(response.data);
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      print("ERRORR => $e");
      throw sampleDioException;
    }
  }
}
