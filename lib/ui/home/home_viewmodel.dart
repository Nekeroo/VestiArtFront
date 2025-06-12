import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/reference_type.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import '../../core/models/creation.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Creation> _myCreations = [];
  final List<Creation> _recentCreations = [];
  Creation? _featuredCreation;
  bool _isLoading = false;
  bool _showAuthBanner = true;

  HomeViewModel();

  List<Creation> get myCreations => _myCreations;
  List<Creation> get recentCreations => _recentCreations;
  Creation? get featuredCreation => _featuredCreation;
  bool get isLoading => _isLoading;
  bool get showAuthBanner => _showAuthBanner;

  void logout() {
    AuthenticationService.instance.logout();
    notifyListeners();
  }

  void dismissAuthBanner() {
    _showAuthBanner = false;
    notifyListeners();
  }

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
        'reference': 'Baptman',
        'referenceType': '',
      },
      {
        'name': 'Winter Coat',
        'text': 'A warm and cozy coat for winter weather.',
        'reference': 'Clair obscur: Expédition 33',
        'referenceType': '',
      },
      {
        'name': 'Evening Gown',
        'text': 'An elegant gown for special occasions.',
        'reference': 'Frieren',
        'referenceType': '',
      },
      {
        'name': 'Casual Outfit',
        'text': 'A comfortable everyday outfit.',
        'reference': 'Les carnets de l\'apoticaire',
        'referenceType': '',
      },
      {
        'name': 'Sportswear',
        'text': 'Performance wear for active lifestyles.',
        'reference': 'Oshi no ko',
        'referenceType': '',
      },
    ];

    for (int i = 0; i < mockData.length; i++) {
      final item = mockData[i];
      final creation = Creation(
        uuid: i.toString(),
        name: item['name']!,
        text: item['text']!,
        reference: item['reference']!,
        referenceType: ReferenceType.fromString(
          item['referenceType']!.toString(),
        ),
        image: "",
      );

      _recentCreations.add(creation);
      _myCreations.add(creation);
    }

    _featuredCreation = Creation(
      uuid: mockData.first['uuid'].toString(),
      name: mockData.first['name'].toString(),
      text: mockData.first['text'].toString(),
      reference: mockData.first['reference']!,
      referenceType: ReferenceType.fromString(
        mockData.first['referenceType'].toString(),
      ),
      image: "",
    );
  }
}
