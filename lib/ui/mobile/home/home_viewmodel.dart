import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/stats.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/api_stats.dart';
import 'package:vesti_art/networking/api_creation.dart';
import '../../../core/models/creation.dart';

class HomeViewModel extends ChangeNotifier {
  List<Creation> _myCreations = [];
  List<Creation> _recentCreations = [];
  ReferenceType _referenceType = ReferenceType.movie;
  bool _isLoading = false;
  bool _showAuthBanner = true;
  StatsData? _statsData;

  HomeViewModel();

  List<Creation> get myCreations => _myCreations;
  List<Creation> get recentCreations => _recentCreations;
  ReferenceType get referenceType => _referenceType;
  bool get isLoading => _isLoading;
  bool get showAuthBanner => _showAuthBanner;
  StatsData? get statsData => _statsData;

  void logout() {
    AuthenticationService.instance.logout();
    notifyListeners();
  }

  void setReferenceType(ReferenceType referenceType) {
    _referenceType = referenceType;
    notifyListeners();
  }

  void dismissAuthBanner() {
    _showAuthBanner = false;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> loadCreations() async {
    _recentCreations = await ApiCreation.instance.getAll();

    if (AuthenticationService.instance.isAuthenticated) {
      final myCreations = await ApiCreation.instance.getMe();
      _myCreations = myCreations.creations;
    }

    notifyListeners();
  }

  Future<void> loadStats() async {
    _statsData = await ApiStats.instance.getStats();
    notifyListeners();
  }
}
