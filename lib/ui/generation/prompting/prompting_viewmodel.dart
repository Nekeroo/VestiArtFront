import 'package:flutter/material.dart';
import '../../../core/models/creation.dart';

class PromptingViewModel extends ChangeNotifier {
  static const int maxCreations = 5;
  
  final List<CreationDraft> _creationDrafts = [];
  bool _isGenerating = false;
  CreationDraft? _currentDraft;
  
  List<CreationDraft> get creationDrafts => List.unmodifiable(_creationDrafts);
  bool get isGenerating => _isGenerating;
  bool get canAddMore => _creationDrafts.length < maxCreations;
  int get remainingCreations => maxCreations - _creationDrafts.length;
  CreationDraft? get currentDraft => _currentDraft;
  
  void addDraft() {
    if (canAddMore) {
      final draft = CreationDraft();
      _creationDrafts.add(draft);
      _currentDraft = draft;
      notifyListeners();
    }
  }
  
  void removeDraft(int index) {
    if (index >= 0 && index < _creationDrafts.length) {
      final removed = _creationDrafts.removeAt(index);
      if (_currentDraft == removed) {
        _currentDraft = null;
      }
      notifyListeners();
    }
  }
  
  void editDraft(int index) {
    if (index >= 0 && index < _creationDrafts.length) {
      _currentDraft = _creationDrafts[index];
      notifyListeners();
    }
  }
  
  void updateCurrentDraft({String? name, String? promptText}) {
    if (_currentDraft != null) {
      if (name != null) {
        _currentDraft!.name = name;
      }
      if (promptText != null) {
        _currentDraft!.promptText = promptText;
      }
      notifyListeners();
    }
  }
  
  void clearCurrentDraft() {
    _currentDraft = null;
    notifyListeners();
  }
  
  bool isDraftValid(CreationDraft draft) {
    return draft.name.isNotEmpty && draft.promptText.isNotEmpty;
  }
  
  bool areAllDraftsValid() {
    return _creationDrafts.isNotEmpty && 
           _creationDrafts.every((draft) => isDraftValid(draft));
  }
  
  Future<List<Creation>> generateCreations() async {
    if (!areAllDraftsValid()) {
      return [];
    }
    
    _isGenerating = true;
    notifyListeners();
    
    try {
      await Future.delayed(const Duration(seconds: 2));
      
      final creations = _creationDrafts.map((draft) => Creation(
        uuid: DateTime.now().millisecondsSinceEpoch.toString(),
        name: draft.name,
        text: draft.promptText,
        image: '',
      )).toList();
      
      return creations;
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }
}

class CreationDraft {
  String name;
  String promptText;
  
  CreationDraft({
    this.name = '',
    this.promptText = '',
  });
}
