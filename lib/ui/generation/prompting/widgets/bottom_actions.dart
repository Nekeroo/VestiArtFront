import 'package:flutter/material.dart';
import '../prompting_viewmodel.dart';

class BottomActions extends StatelessWidget {
  final PromptingViewModel viewModel;
  final VoidCallback onGenerate;

  const BottomActions({
    super.key,
    required this.viewModel,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasCreations = viewModel.creationDrafts.isNotEmpty;
    final hasInvalidDrafts = hasCreations && !viewModel.areAllDraftsValid();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasInvalidDrafts) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 18,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Veuillez compléter tous les champs requis',
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: viewModel.areAllDraftsValid() ? onGenerate : null,
              icon:
                  viewModel.isGenerating
                      ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.onPrimary,
                        ),
                      )
                      : const Icon(Icons.auto_awesome),
              label: Text(
                viewModel.isGenerating
                    ? 'Génération en cours...'
                    : 'Générer les créations',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
