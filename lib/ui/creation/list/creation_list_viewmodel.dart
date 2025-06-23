import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class CreationListViewModel extends ChangeNotifier {
  Sort sort;

  CreationListViewModel({required this.sort}) {
    loadCreations();
  }

  List<Creation> _creations = [];
  bool _isLoading = false;
  NetworkException? _error;
  int _start = 0;
  final int _nbElements = 20;

  List<Creation> get creations => List.unmodifiable(_creations);
  bool get isLoading => _isLoading;
  NetworkException? get error => _error;

  Future<void> loadCreations({bool fromStart = true}) async {
    _isLoading = true;
    notifyListeners();

    if (fromStart) _start = 0;

    try {
      final creations = await ApiCreation().getAll(
        sort: sort,
        start: _start,
        nbElements: _nbElements,
      );

      if (fromStart) {
        _creations = creations;
      } else {
        _creations.addAll(creations);
      }
    } on DioException catch (e) {
      _error = e.error as NetworkException;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeSort(Sort sort) {
    if (sort == this.sort) return;

    this.sort = sort;
    loadCreations();
  }
}
