import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/ui/admin/admin_panel.ViewModel.dart';

void showDeleteConfirmation(
  BuildContext context,
  Creation article,
  AdminPanelViewModel viewModel,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Article'),
        content: Text(
          'Are you sure you want to delete the article ${article.title}?',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              viewModel.deleteArticle(article.idExterne);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
