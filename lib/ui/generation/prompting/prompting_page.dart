import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/ui/generation/prompting/widgets/header.dart';
import '../../../core/models/creation_draft.dart';
import 'prompting_viewmodel.dart';
import 'widgets/bottom_actions.dart';
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
            return SafeArea(child: _buildContent(context, viewModel));
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PromptingViewModel viewModel) {
    return Column(
      children: [
        Header(
          viewModel: viewModel,
          showCreationSheet:
              () => _showCreationEditSheet(context, viewModel, isNew: true),
        ),
        Expanded(child: _buildCreationsList(context, viewModel)),
        BottomActions(
          viewModel: viewModel,
          onGenerate: () => viewModel.generate(context),
        ),
      ],
    );
  }

  Widget _buildCreationsList(
    BuildContext context,
    PromptingViewModel viewModel,
  ) {
    if (viewModel.creationDrafts.isEmpty) {
      return _buildEmptyState(context);
    }

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    if (isMobile) {
      // Liste verticale pour mobile
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.creationDrafts.length,
        itemBuilder: (context, index) {
          final draft = viewModel.creationDrafts[index];
          return CreationDraftCard(
            draft: draft,
            index: index,
            onEdit:
                () => _showCreationEditSheet(context, viewModel, index: index),
            onDelete: () => viewModel.removeDraft(index),
          );
        },
      );
    } else {
      // Grille pour tablette/desktop
      final crossAxisCount = width < 1200 ? 2 : 3;

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisExtent: 140,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: viewModel.creationDrafts.length,
        itemBuilder: (context, index) {
          final draft = viewModel.creationDrafts[index];
          return CreationDraftCard(
            draft: draft,
            index: index,
            onEdit:
                () => _showCreationEditSheet(context, viewModel, index: index),
            onDelete: () => viewModel.removeDraft(index),
          );
        },
      );
    }
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

  Future<void> _showCreationEditSheet(
    BuildContext context,
    PromptingViewModel viewModel, {
    int? index,
    bool isNew = false,
  }) async {
    CreationDraft draftToEdit;

    if (isNew) {
      draftToEdit = CreationDraft();
    } else if (index != null) {
      draftToEdit = viewModel.creationDrafts[index].copy();
    } else {
      draftToEdit = CreationDraft();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder:
          (context) => WillPopScope(
            onWillPop: () async {
              return await _confirmExit(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: CreationEditSheet(
                draft: draftToEdit,
                onSave: (updatedDraft) {
                  viewModel.updateDraft(updatedDraft);
                },
              ),
            ),
          ),
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Modifications non enregistrées'),
            content: const Text(
              'Vous avez des modifications non enregistrées. Voulez-vous vraiment quitter ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Continuer à éditer'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Quitter sans sauvegarder'),
              ),
            ],
          ),
    );
    return result ?? false;
  }
}
