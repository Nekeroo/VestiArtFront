import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/auth/widgets/auth_banner.dart';
import 'package:vesti_art/ui/mobile/home/widgets/creation_carousel.dart';
import 'home_viewmodel.dart';
import 'widgets/home_app_bar.dart';

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

    // Vérifier les erreurs d'authentification
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthErrors();
    });
  }

  void _checkAuthErrors() {
    final authService = AuthenticationService.instance;
    if (authService.hasAuthError) {
      _showAuthErrorDialog();
    }
  }

  void _showAuthErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            title: const Text('Erreur d\'authentification'),
            content: const Text(
              'Impossible de récupérer vos informations utilisateur. Veuillez vous reconnecter.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
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
        appBar: HomeAppBar(viewModel: _viewModel),
        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                ),
              );
            }

            return _buildHomeContent(viewModel);
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(HomeViewModel viewModel) {
    final authService = Provider.of<AuthenticationService>(
      context,
      listen: false,
    );

    return CustomScrollView(
      slivers: [
        if (!authService.isAuthenticated && viewModel.showAuthBanner)
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        if (!authService.isAuthenticated && viewModel.showAuthBanner)
          SliverToBoxAdapter(
            child: AuthBanner(
              onDismiss: () {
                viewModel.dismissAuthBanner();
              },
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),

        CreationCarousel(
          creations: viewModel.recentCreations,
          title: 'Récents',
          icon: Icons.access_time,
          emptyMessage: 'Consultez les créations récentes des utilisateurs ici',
          sort: Sort.dateCreate,
        ),

        if (AuthenticationService.instance.isAuthenticated)
          CreationCarousel(
            creations: viewModel.myCreations,
            title: 'Mes créations',
            icon: Icons.person_rounded,
            emptyMessage: 'Ajoutez votre première création',
            sort: Sort.mine,
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 30)),
      ],
    );
  }
}
