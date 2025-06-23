import 'package:flutter/material.dart';
import 'package:vesti_art/ui/mobile/home/home_viewmodel.dart';


class LogoutDialog extends StatelessWidget {
  final HomeViewModel viewModel;

  const LogoutDialog({super.key, required this.viewModel});

  static Future<bool?> show(BuildContext context, HomeViewModel viewModel) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => LogoutDialog(viewModel: viewModel),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Déconnexion',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Êtes-vous sûr de vouloir vous déconnecter?',
        style: theme.textTheme.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Annuler',
            style: TextStyle(color: theme.colorScheme.onSurface),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.logout();
            Navigator.of(context).pop(true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Déconnexion'),
        ),
      ],
    );
  }
}