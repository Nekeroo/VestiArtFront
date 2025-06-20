import 'package:flutter/material.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import '../../../core/models/creation_draft.dart';

class PromptingViewModel extends ChangeNotifier {
  static const int maxCreations = 5;

  final List<CreationDraft> _creationDrafts = [];
  final bool _isGenerating = false;

  List<CreationDraft> get creationDrafts => List.unmodifiable(_creationDrafts);
  bool get isGenerating => _isGenerating;
  bool get canAddMore => _creationDrafts.length < maxCreations;
  int get remainingCreations => maxCreations - _creationDrafts.length;

  void addDraft(CreationDraft draft) {
    if (canAddMore) {
      _creationDrafts.add(draft);
      notifyListeners();
    }
  }

  void removeDraft(int index) {
    if (index >= 0 && index < _creationDrafts.length) {
      _creationDrafts.removeAt(index);
      notifyListeners();
    }
  }

  void updateDraft(CreationDraft updatedDraft) {
    final index = _creationDrafts.indexWhere(
      (d) => d.uuid == updatedDraft.uuid,
    );

    if (index >= 0) {
      _creationDrafts[index] = updatedDraft;
    } else {
      _creationDrafts.add(updatedDraft);
    }

    notifyListeners();
  }

  bool areAllDraftsValid() {
    return _creationDrafts.isNotEmpty &&
        _creationDrafts.every((draft) => draft.isValid);
  }

  void generate(BuildContext context) {
    if (areAllDraftsValid()) {
      Navigator.pushNamed(
        context,
        AppRoutes.promptingLoading,
        arguments: _creationDrafts,
      );
    }
  }
}
