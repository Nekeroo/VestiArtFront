import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/ui/common/widgets/responsive_layout_builder.dart';
import 'login_viewmodel.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _viewModel = LoginViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: AppBar(title: const Text('Connexion'), centerTitle: true),
        body: ResponsiveLayoutBuilder(
          maxWidth: 480,
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 480;
            final horizontalPadding = isDesktop ? 48.0 : 24.0;
            final verticalSpacing = isDesktop ? 32.0 : 24.0;
            
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: isDesktop ? 32.0 : 16.0),
                    Center(
                      child: Text(
                        'VestiArt',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          fontSize: isDesktop ? 48.0 : null,
                        ),
                      ),
                    ),
                    SizedBox(height: verticalSpacing * 2),
                    Card(
                      elevation: isDesktop ? 4.0 : 0.0,
                      margin: isDesktop ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
                      shape: isDesktop
                          ? RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            )
                          : null,
                      child: Padding(
                        padding: isDesktop
                            ? const EdgeInsets.all(32.0)
                            : EdgeInsets.zero,
                        child: const LoginForm(),
                      ),
                    ),
                    SizedBox(height: verticalSpacing),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.register);
                      },
                      child: const Text('Pas encore de compte ? S\'inscrire'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
