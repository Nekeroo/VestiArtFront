import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/models/creation_draft.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/networking/api_creation.dart';

class LoadingViewModel extends ChangeNotifier {
  final List<CreationDraft> creationsDraft;
  final Random _random = Random();
  List<Creation> _creations = [];
  bool _hasError = false;
  bool _canContinue = false;
  Timer? _messageTimer;
  String _currentMessage = "";
  List<String> _allMessages = [];
  List<int> _messageOrder = [];
  int _currentIndex = 0;

  final List<String> _loadingMessages = [
    'Préparation des modèles...',
    'Configuration de l\'environnement...',
    'Connexion aux serveurs...',
    'Envoi des données...',
    'Analyse des références...',
    'Calcul des paramètres...',
    'Génération des designs...',
    'Création des détails...',
    'Application des styles...',
    'Finalisation des créations...',
    'Optimisation des résultats...',
    'Analyse des tendances...',
    'Ajustement des couleurs...',
    'Vérification de la cohérence...',
    'Application des textures...',
  ];

  String get currentMessage => _currentMessage;
  bool get hasError => _hasError;
  bool get canContinue => _canContinue;

  LoadingViewModel({required this.creationsDraft}) {
    _allMessages = List.from(_loadingMessages);
    _shuffleMessages();
    _updateCurrentMessage();
    _startMessageChange();
    ApiCreation.instance
        .create(creationsDraft)
        .then((creations) {
          _creations = creations;
          _canContinue = true;
          notifyListeners();
        })
        .catchError((_) {
          _hasError = true;
          notifyListeners();
        });
  }

  void _startMessageChange() {
    _messageTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      _updateCurrentMessage();
      notifyListeners();
    });
  }

  void _updateCurrentMessage() {
    // Si on a affiché tous les messages, on mélange à nouveau
    if (_currentIndex >= _messageOrder.length) {
      _shuffleMessages();
      _currentIndex = 0;
    }

    int messageIdx = _messageOrder[_currentIndex++];
    _currentMessage = _allMessages[messageIdx];
  }

  void _shuffleMessages() {
    _messageOrder = List.generate(_allMessages.length, (index) => index);
    _messageOrder.shuffle(_random);
  }

  void navigateToDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppRoutes.promptingDetails,
      arguments: _creations,
    );
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    super.dispose();
  }
}
