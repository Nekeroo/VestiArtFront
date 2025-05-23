import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/models/creation.dart';
import 'prompting_viewmodel.dart';
import 'widgets/creation_draft_card.dart';
import 'widgets/creation_edit_sheet.dart';

class PromptingPage extends StatefulWidget {
  const PromptingPage({super.key});

  @override
  State<PromptingPage> createState() => _PromptingPageState();
}

class _PromptingPageState extends State<PromptingPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromptingViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Création de vêtements'),
          elevation: 0,
        ),
        body: Consumer<PromptingViewModel>(
          builder: (context, viewModel, _) {
            return SafeArea(
              child: _buildContent(context, viewModel),
            );
          },
        ),

      ),
    );
  }

  Widget _buildContent(BuildContext context, PromptingViewModel viewModel) {
    return Column(
      children: [
        _buildHeader(context, viewModel),
        Expanded(
          child: _buildCreationsList(context, viewModel),
        ),
        _buildBottomActions(context, viewModel),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, PromptingViewModel viewModel) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Générer des créations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Créations : ${viewModel.creationDrafts.length}/${PromptingViewModel.maxCreations}',
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: viewModel.canAddMore 
                ? () => _showCreationEditSheet(context, viewModel, isNew: true)
                : null,
            icon: const Icon(Icons.add),
            label: const Text('Ajouter'),
            style: OutlinedButton.styleFrom(
              backgroundColor: theme.colorScheme.surface,
              foregroundColor: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreationsList(BuildContext context, PromptingViewModel viewModel) {
    if (viewModel.creationDrafts.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.creationDrafts.length,
      itemBuilder: (context, index) {
        final draft = viewModel.creationDrafts[index];
        final isValid = viewModel.isDraftValid(draft);
        
        return CreationDraftCard(
          draft: draft,
          index: index,
          isValid: isValid,
          onEdit: () => _showCreationEditSheet(
            context, 
            viewModel,
            index: index,
          ),
          onDelete: () => viewModel.removeDraft(index),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 64,
              color: theme.colorScheme.secondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune création',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Appuyez sur le bouton + pour ajouter votre première création',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, PromptingViewModel viewModel) {
    final theme = Theme.of(context);
    final hasCreations = viewModel.creationDrafts.isNotEmpty;
    final hasInvalidDrafts = hasCreations && !viewModel.areAllDraftsValid();
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
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
            Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Certains brouillons sont incomplets',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: hasCreations && !viewModel.isGenerating
                  ? () => _handleGenerate(context, viewModel)
                  : null,
              icon: viewModel.isGenerating
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreationEditSheet(BuildContext context, PromptingViewModel viewModel, {int? index, bool isNew = false}) {
    if (isNew) {
      viewModel.addDraft();
    } else if (index != null) {
      viewModel.editDraft(index);
    }
    
    if (viewModel.currentDraft == null) return;
    
    final currentDraft = viewModel.currentDraft!;
    
    showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CreationEditSheet(
          draft: currentDraft,
          onNameChanged: (value) => viewModel.updateCurrentDraft(name: value),
          onPromptChanged: (value) => viewModel.updateCurrentDraft(promptText: value),
          onSave: viewModel.clearCurrentDraft,
        ),
      ),
    ).then((saved) {
      // Si l'utilisateur annule ou ferme sans sauvegarder et que c'est une nouvelle création
      if (saved != true && isNew) {
        // Supprimer le brouillon non sauvegardé
        viewModel.removeDraft(viewModel.creationDrafts.length - 1);
      }
    });
  }

  Future<void> _handleGenerate(BuildContext context, PromptingViewModel viewModel) async {
    final creations = await viewModel.generateCreations();
    
    if (context.mounted && creations.isNotEmpty) {
      _showSuccessDialog(context, creations);
    }
  }

  void _showSuccessDialog(BuildContext context, List<Creation> creations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Génération réussie'),
          ],
        ),
        content: Text(
          '${creations.length} création${creations.length > 1 ? 's' : ''} générée${creations.length > 1 ? 's' : ''} avec succès !',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(creations);
            },
            child: const Text('Voir mes créations'),
          ),
        ],
      ),
    );
  }
}
