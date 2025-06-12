import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'article.model.dart';

class AdminPanelViewModel extends ChangeNotifier {
  final List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 1));
    // _addMockArticles();

    try {
      _articles.clear();
      final creations = await CreationApi().getAll();
      for (var creation in creations) {
        _articles.add(articleFromJson(creation));
      }
    } catch (e) {
      print('Error loading articles: $e');
    }

    print('Articles loaded: ${_articles.length}');
    _isLoading = false;
    notifyListeners();
  }

  void addArticle(Article article) {
    _articles.add(article);
    notifyListeners();
  }

  void editArticle(int id, Article updatedArticle) {
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

Article articleFromJson(Map<String, dynamic> json) {
  print('articleFromJson: $json');
  if (json.isEmpty) {
    throw Exception('Empty JSON data');
  }
  print("Type of Article :" + TypeEnum.movie.toString());
  return Article(
    title: json['title'],
    description: json['description'],
    idExterne: json['idExterne'],
    imageUrl: json['imageUrl'],
    tag1: json['tag1'],
    tag2: json['tag2'],
    type: TypeEnum.fromString(json['type']),
    dateCreate: DateTime.parse(json['dateCreate']),
  );
}

void generatePDF(Article article) {}
