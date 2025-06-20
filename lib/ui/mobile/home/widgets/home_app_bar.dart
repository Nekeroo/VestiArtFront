import 'package:flutter/material.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/ui/common/theme/app_radius.dart';
import '../home_viewmodel.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeViewModel viewModel;

  const HomeAppBar({super.key, required this.viewModel});

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 2,
      backgroundColor: theme.colorScheme.surface,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppRadius.m),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.2),
              theme.colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            'Vesti',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            'Art',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explorez vos créations',
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            if (AuthenticationService.instance.isAuthenticated)
              Positioned(
                right: 16,
                bottom: -20,
                child: ElevatedButton.icon(
                  onPressed:
                      () => Navigator.pushNamed(context, AppRoutes.prompting),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nouvelle création'),
                ),
              ),
          ],
        ),
      ),
      actions: [],
    );
  }
}
