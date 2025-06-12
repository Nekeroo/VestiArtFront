import 'package:flutter/material.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/api_creation.dart';
import '../../core/models/creation.dart';

class HomeViewModel extends ChangeNotifier {
  List<Creation> _myCreations = [];
  List<Creation> _recentCreations = [];
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

    _recentCreations = await ApiCreation.instance.getAll();
    _featuredCreation = _recentCreations.first;

    if (AuthenticationService.instance.isAuthenticated) {
      _myCreations = await ApiCreation.instance.getAll();
    }

    _isLoading = false;
    notifyListeners();
  }
}
