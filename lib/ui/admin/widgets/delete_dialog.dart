import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/models/loading_state.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';
import 'package:vesti_art/ui/admin/admin_panel.ViewModel.dart';

void showDeleteConfirmation(
  BuildContext context,
  Creation article,
  AdminPanelViewModel viewModel,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer<AdminPanelViewModel>(
        builder: (context, viewModel, child) {
          switch (viewModel.loadingState) {
            case LoadingState.loading:
              return _loadingStateContent();
            case LoadingState.error:
              return _errorStateContent(context, viewModel.error!);
            case LoadingState.success:
              // TODO: REFACTO!!!!!!!!!
              Navigator.of(context).pop();
              return _deleteSuccessStateContent(context);
            case LoadingState.none:
              return _content(
                context,
                article,
                () => viewModel.deleteArticle(article.idExternePdf!, context),
              );
          }
        },
      );
    },
  );
}

AlertDialog _content(
  BuildContext context,
  Creation article,
  Function() onDelete,
) {
  return AlertDialog(
    title: const Text('Suppression'),
    content: Text(
      'Etes vous sûr de vouloir supprimer l\'article ${article.title}?',
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Annuler'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
        onPressed: () {
          onDelete();
        },
      ),
    ],
  );
}

AlertDialog _loadingStateContent() {
  return const AlertDialog(
    title: Text('Loading...'),
    content: Center(child: CircularProgressIndicator()),
  );
}

AlertDialog _errorStateContent(
  BuildContext context,
  NetworkException exception,
) {
  return AlertDialog(
    title: const Text('Erreur'),
    content: Text(exception.message),
    actions: <Widget>[
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

AlertDialog _deleteSuccessStateContent(BuildContext context) {
  return AlertDialog(
    title: const Text('Succès'),
    content: const Text('Article supprimé avec succès'),
    actions: <Widget>[
      TextButton(
        child: const Text('OK'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
