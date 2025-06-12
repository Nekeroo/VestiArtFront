import 'package:flutter/material.dart';
import 'package:vesti_art/ui/auth/login/login_screen.dart';
import 'package:vesti_art/ui/auth/register/register_screen.dart';

class AuthBanner extends StatefulWidget {
  final VoidCallback? onDismiss;

  const AuthBanner({Key? key, this.onDismiss}) : super(key: key);

  @override
  State<AuthBanner> createState() => _AuthBannerState();
}

class _AuthBannerState extends State<AuthBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismissBanner() {
    _animationController.reverse().then((_) {
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FadeTransition(
      opacity: _animationController,
      child: SizeTransition(
        sizeFactor: _animationController,
        axis: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;

              return Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child:
                      isSmallScreen
                          ? _buildVerticalLayout(context, colorScheme)
                          : _buildHorizontalLayout(context, colorScheme),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalLayout(BuildContext context, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.person_outline, color: colorScheme.onPrimary, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Connectez-vous pour profiter de toutes les fonctionnalités',
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.close, color: colorScheme.onPrimary),
              onPressed: _dismissBanner,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => _navigateToLogin(context),
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Connexion'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextButton(
                onPressed: () => _navigateToRegister(context),
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.onPrimary,
                  foregroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Inscription'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(Icons.person_outline, color: colorScheme.onPrimary, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Connectez-vous pour profiter de toutes les fonctionnalités',
            style: TextStyle(
              color: colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () => _navigateToLogin(context),
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.onPrimary.withValues(alpha: 51),
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: const Text('Connexion'),
        ),
        const SizedBox(width: 8),
        TextButton(
          onPressed: () => _navigateToRegister(context),
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.onPrimary,
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: const Text('Inscription'),
        ),
        IconButton(
          icon: Icon(Icons.close, color: colorScheme.onPrimary),
          onPressed: _dismissBanner,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
