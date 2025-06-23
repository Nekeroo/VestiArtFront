import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/ui/common/widgets/creation_card.dart';
import 'package:vesti_art/ui/generation/details/prompting_details_viewmodel.dart';

class PromptingDetailsPage extends StatelessWidget {
  final List<Creation> creations;

  const PromptingDetailsPage({super.key, required this.creations});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (context) => PromptingDetailsViewModel(initialCreations: creations),
      child: const _PromptingCreationsDetailsView(),
    );
  }
}

class _PromptingCreationsDetailsView extends StatelessWidget {
  const _PromptingCreationsDetailsView();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PromptingDetailsViewModel>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Créations générées'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => viewModel.navigateToHome(context),
        ),
      ),
      body: _buildBody(context, viewModel),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        child: ElevatedButton.icon(
          onPressed: () => viewModel.navigateToHome(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.home),
          label: const Text('Continuer', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PromptingDetailsViewModel viewModel) {
    if (!viewModel.hasCreations) {
      return Center(
        child: Text(
          'Aucune création disponible',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: viewModel.creations.length,
        itemBuilder: (context, index) {
          final creation = viewModel.creations[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CreationCard(
              creation: creation,
              onTap:
                  () => viewModel.navigateToCreationDetails(context, creation),
            ),
          );
        },
      ),
    );
  }
}
