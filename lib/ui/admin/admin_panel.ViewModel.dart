import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/creation_api.dart';
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

  void _addMockArticles() {
    final mockData = [
      Article(
        title: 'Outfit Daffy !',
        description:
            'Get ready to waddle into style with our exclusive Daffy Duck-inspired outfit (soft cotton blend, glossy finish; sizes XS-XXL) featuring black base, orange shoes/beak, yellow accents, white details—complete with cap, sunglasses & orange sneakers!',
        idExterne: 'ext1',
        imageUrl: 'image1.jpg',
        tag1: 'tag1',
        tag2: 'tag2',
        type: TypeEnum.anime,
        dateCreate: DateTime.now(),
      ),
      Article(
        //   _isLoading = true;
        //   notifyListeners();

        //   await Future.delayed(const Duration(seconds: 1));
        //   _addMockArticles();

        //   _isLoading = false;
        //   notifyListeners();
        // }
        title: 'Article 2',
        description: 'Description for Article 2',
        idExterne: 'ext2',
        imageUrl: 'image2.jpg',
        tag1: 'tag1',
        tag2: 'tag2',
        type: TypeEnum.serie,
        dateCreate: DateTime.now(),
      ),
    ];

    _articles.addAll(mockData);
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

  void deleteArticle(int id) {
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
