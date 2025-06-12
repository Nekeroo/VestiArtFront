import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';

class AdminPanelViewModel extends ChangeNotifier {
  List<Creation> _articles = [];
  bool _isLoading = false;

  List<Creation> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles.clear();
      _articles = await CreationApi().getAll();
    } catch (e) {
      print('Error loading articles: $e');
    }

    print('Articles loaded: ${_articles.length}');
    _isLoading = false;
    notifyListeners();
  }

  void addArticle(Creation article) {
    _articles.add(article);
    notifyListeners();
  }

  void editArticle(int id, Creation updatedArticle) {
    final index = _articles.indexWhere((article) => article.idExterne == id);
    if (index != -1) {
      _articles[index] = updatedArticle;
      notifyListeners();
    }
  }

  void deleteArticle(String id) {
    _articles.removeWhere((article) => article.idExterne == id);
    notifyListeners();
  }
}

void generatePDF(Creation article) {}
