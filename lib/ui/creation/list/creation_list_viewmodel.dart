import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/networking/models/creations_response.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class CreationListViewModel extends ChangeNotifier {
  Sort sort;
  ReferenceType referenceType;

  CreationListViewModel({required this.sort, required this.referenceType}) {
    final shouldLoadByReferenceType = referenceType != ReferenceType.all;
    loadCreations(shouldLoadByReferenceType: shouldLoadByReferenceType);
  }

  List<Creation> _creations = [];
  bool _isLoading = false;
  NetworkException? _error;
  int _start = 0;
  bool hasNextPage = true;
  final int _nbElements = 20;

  List<Creation> get creations => List.unmodifiable(_creations);
  bool get isLoading => _isLoading;
  NetworkException? get error => _error;

  Future<void> loadCreations({
    bool fromStart = true,
    bool shouldLoadByReferenceType = false,
  }) async {
    if (!hasNextPage && !fromStart) return;
    _isLoading = true;
    notifyListeners();

    if (fromStart) _start = 0;

    try {
      CreationsResponse response;

      if (shouldLoadByReferenceType && referenceType != ReferenceType.all) {
        response = await loadByReferenceType();
      } else {
        response =
            sort == Sort.mine
                ? await loadMyCreations()
                : await loadSortedCreations();
      }

      if (fromStart) {
        _creations = response.creations;
      } else {
        _creations.addAll(response.creations);
      }

      _start = response.nextKey ?? _start;
      hasNextPage = response.nextKey != null;
    } on DioException catch (e) {
      _error = e.error as NetworkException;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<CreationsResponse> loadMyCreations() async {
    try {
      return await ApiCreation().getMe(start: _start, nbElements: _nbElements);
    } catch (_) {
      rethrow;
    }
  }

  Future<CreationsResponse> loadSortedCreations() async {
    try {
      return await ApiCreation().getAllPagined(
        sort: sort,
        start: _start,
        nbElements: _nbElements,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<CreationsResponse> loadByReferenceType() async {
    try {
      return await ApiCreation().getByType(
        type: referenceType,
        start: _start,
        nbElements: _nbElements,
      );
    } catch (_) {
      rethrow;
    }
  }

  void changeReferenceType(ReferenceType referenceType) {
    if (referenceType == this.referenceType) return;

    this.referenceType = referenceType;
    loadCreations(
      shouldLoadByReferenceType: referenceType != ReferenceType.all,
    );
  }

  void changeSort(Sort sort) {
    if (sort == this.sort) return;

    this.sort = sort;
    loadCreations();
  }
}
