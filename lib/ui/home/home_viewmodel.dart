import 'package:flutter/material.dart';
import '../../core/models/creation.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Creation> _creations = [];
  bool _isLoading = false;
  int _selectedIndex = 0;

  HomeViewModel();

  List<Creation> get creations => List.unmodifiable(_creations);
  bool get isLoading => _isLoading;
  int get selectedIndex => _selectedIndex;

  void changeTab(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  Future<Creation?> generateCreation(String name, String text) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final creation = Creation(
      uuid: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      text: text,
      image: CreationConstants.mockImageUrl,
    );

    _creations.add(creation);

    _isLoading = false;
    notifyListeners();

    return creation;
  }

  Future<void> loadCreations() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (_creations.isEmpty) {
      _addMockCreations();
    }

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

      _creations.add(creation);
    }
  }
}
