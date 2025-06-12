import 'package:flutter/material.dart';
import 'article.model.dart';

class AdminPanelViewModel extends ChangeNotifier {
  final List<Article> _articles = [];
  bool _isLoading = false;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;

  Future<void> loadArticles() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _addMockArticles();

    _isLoading = false;
    notifyListeners();
  }

  void _addMockArticles() {
    final mockData = [
      Article(
        id: 1,
        title: 'Outfit Daffy !',
        description:
            'Get ready to waddle into style with our exclusive Daffy Duck-inspired outfit (soft cotton blend, glossy finish; sizes XS-XXL) featuring black base, orange shoes/beak, yellow accents, white details—complete with cap, sunglasses & orange sneakers!',
        idExterne: 'ext1',
        image: 'image1.jpg',
        pdf: 'pdf1.pdf',
        tag1: 'tag1',
        tag2: 'tag2',
        type: TypeEnum.Animed,
        dateCreate: DateTime.now(),
      ),
      Article(
        id: 2, // Future<void> loadArticles() async {
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
        image: 'image2.jpg',
        pdf: 'pdf2.pdf',
        tag1: 'tag1',
        tag2: 'tag2',
        type: TypeEnum.Serie,
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
    final index = _articles.indexWhere((article) => article.id == id);
    if (index != -1) {
      _articles[index] = updatedArticle;
      notifyListeners();
    }
  }

  void deleteArticle(int id) {
    _articles.removeWhere((article) => article.id == id);
    notifyListeners();
  }
}
