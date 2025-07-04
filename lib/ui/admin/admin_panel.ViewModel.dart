import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/models/loading_state.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class AdminPanelViewModel extends ChangeNotifier {
  List<Creation> _articles = [];
  bool _isLoading = false;
  LoadingState _loadingState = LoadingState.none;
  NetworkException? _error;

  List<Creation> get articles => _articles;
  set articles(List<Creation> articles) {
    _articles = articles;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  LoadingState get loadingState => _loadingState;
  NetworkException? get error => _error;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles.clear();
      _articles = await ApiCreation().getAll(nbElements: 1000);
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
    final index = _articles.indexWhere(
      (article) => article.idExterneImage == id,
    );
    if (index != -1) {
      _articles[index] = updatedArticle;
      notifyListeners();
    }
  }

  Future<void> deleteArticle(String id, BuildContext context) async {
    _loadingState = LoadingState.loading;
    _error = null;
    notifyListeners();

    try {
      await ApiCreation.instance.delete(id);
      _articles.removeWhere((article) => article.idExternePdf == id);
      _loadingState = LoadingState.success;
      notifyListeners();
    } catch (e) {
      print('Error deleting article: $e');
      _error = e as NetworkException?;
      _loadingState = LoadingState.error;
      notifyListeners();
    }
  }
}

void generatePDF(Creation article) {}
