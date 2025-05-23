import 'package:flutter/material.dart';
import '../../core/models/creation.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Creation> _myCreations = [];
  final List<Creation> _recentCreations = [];
  Creation? _featuredCreation;
  bool _isLoading = false;

  HomeViewModel();

  List<Creation> get myCreations => _myCreations;
  List<Creation> get recentCreations => _recentCreations;
  Creation? get featuredCreation => _featuredCreation;
  bool get isLoading => _isLoading;

  Future<void> loadCreations() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _addMockCreations();

    _isLoading = false;
    notifyListeners();
  }

  void _addMockCreations() {
    final mockData = [
      {
        'name': 'Summer Dress',
        'text': 'A light and airy dress perfect for summer days.',
      },
      {
        'name': 'Winter Coat',
        'text': 'A warm and cozy coat for winter weather.',
      },
      {
        'name': 'Evening Gown',
        'text': 'An elegant gown for special occasions.',
      },
      {'name': 'Casual Outfit', 'text': 'A comfortable everyday outfit.'},
      {'name': 'Sportswear', 'text': 'Performance wear for active lifestyles.'},
    ];

    for (int i = 0; i < mockData.length; i++) {
      final item = mockData[i];
      final creation = Creation(
        uuid: i.toString(),
        name: item['name']!,
        text: item['text']!,
        image: CreationConstants.mockImageUrl,
      );

      // _recentCreations.add(creation);
      _myCreations.add(creation);
    }

    _featuredCreation = Creation(
      uuid: mockData.first['uuid'].toString(),
      name: mockData.first['name'].toString(),
      text: mockData.first['text'].toString(),
      image: CreationConstants.mockImageUrl,
    );
  }
}
