import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation_draft.dart';
import 'package:vesti_art/ui/generation/loading/loading_constants.dart';
import 'package:vesti_art/ui/generation/loading/loading_viewmodel.dart';
import 'package:vesti_art/ui/generation/loading/widgets/animated_loading_indicator.dart';
import 'package:vesti_art/ui/generation/loading/widgets/loading_message.dart';

class LoadingPage extends StatelessWidget {
  final List<CreationDraft> creations;

  const LoadingPage({super.key, required this.creations});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoadingViewModel(creationsDraft: creations),
      child: Scaffold(
        body: Consumer<LoadingViewModel>(
          builder: (context, viewModel, _) {
            return LoadingPageContent(viewModel: viewModel);
          },
        ),
      ),
    );
  }
}

class LoadingPageContent extends StatelessWidget {
  final LoadingViewModel viewModel;

  const LoadingPageContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.secondary;

    return Stack(
      children: [
        SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: viewModel.hasError
                  ? _buildErrorState(context)
                  : viewModel.canContinue
                      ? _buildSuccessState(context)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LoadingConstants.titlePage,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              LoadingConstants.subtitlePage,
                              style: TextStyle(
                                fontSize: 18,
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(height: 60),
                            AnimatedLoadingIndicator(color: accentColor),
                            const SizedBox(height: 40),
                            LoadingMessage(message: viewModel.currentMessage),
                            const SizedBox(height: 80),
                            _buildDraftCountDisplay(context),
                          ],
                        ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDraftCountDisplay(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.design_services, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            '${viewModel.creationsDraft.length} ${LoadingConstants.creationsInProgress}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: 80, color: theme.colorScheme.error),
        const SizedBox(height: 24),
        Text(
          LoadingConstants.errorTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LoadingConstants.errorDescription,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          label: Text(LoadingConstants.backButton),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = Provider.of<LoadingViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            size: 60,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          LoadingConstants.successTitle,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LoadingConstants.successDescription,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.design_services, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                '${viewModel.creationsDraft.length} ${LoadingConstants.creationsCreated}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: () => viewModel.navigateToDetails(context),
          icon: const Icon(Icons.visibility),
          label: Text(LoadingConstants.viewCreationsButton),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
