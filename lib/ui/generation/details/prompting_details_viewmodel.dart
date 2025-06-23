import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/routing/app_routes.dart';

class PromptingDetailsViewModel extends ChangeNotifier {
  List<Creation> _creations = [];

  List<Creation> get creations => _creations;
  bool get hasCreations => _creations.isNotEmpty;

  PromptingDetailsViewModel({required List<Creation> initialCreations}) {
    _creations = initialCreations;
  }

  void navigateToCreationDetails(BuildContext context, Creation creation) {
    Navigator.pushNamed(
      context,
      AppRoutes.creationDetails,
      arguments: creation,
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.home,
      (route) => false,
    );
  }
}
