import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/ui/home/widgets/creation_carousel.dart';
import '../../core/models/creation.dart';
import 'home_viewmodel.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/empty_state_section.dart';
import 'widgets/featured_creation_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
    _loadData();
  }

  Future<void> _loadData() async {
    await _viewModel.loadCreations();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: HomeAppBar(
          viewModel: _viewModel,
          onAddCreationPressed: (context, viewModel) => Map.from({}),
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            if (viewModel.creations.isEmpty) {
              return _buildEmptyState();
            }

            return _buildHomeContent(viewModel.creations);
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return EmptyStateSection(onAddCreation: () => {});
  }

  Widget _buildHomeContent(List<Creation> creations) {
    final recentCreations = creations.take(min(creations.length, 3)).toList();
    final myCreations =
        creations.length > 3 ? creations.skip(3).toList() : <Creation>[];

    void onCreationTap(Creation creation) {
      print('Creation tapped: ${creation.name}');
    }

    return CustomScrollView(
      slivers: [
        if (creations.isNotEmpty)
          FeaturedCreationSection(
            creation: creations.first,
            onTap: () => onCreationTap(creations.first),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        CreationCarousel(
          creations: recentCreations,
          title: 'Récents',
          icon: Icons.access_time,
        ),
        CreationCarousel(
          creations: myCreations,
          title: 'Mes créations',
          icon: Icons.person_rounded,
        ),
      ],
    );
  }
}
