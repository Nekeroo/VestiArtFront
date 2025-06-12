import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/ui/auth/login/login_viewmodel.dart';
import 'package:vesti_art/ui/auth/widgets/error_container.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Form(
      key: viewModel.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: viewModel.usernameController,
            decoration: InputDecoration(
              labelText: 'Nom d\'utilisateur',
              hintText: 'Entrez votre nom d\'utilisateur',
              prefixIcon: const Icon(Icons.person_outline),
              errorText: viewModel.usernameError,
            ),
            validator: viewModel.validateUsername,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: viewModel.passwordController,
            obscureText: !viewModel.isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Mot de passe',
              hintText: 'Entrez votre mot de passe',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  viewModel.isPasswordVisible 
                      ? Icons.visibility_off_outlined 
                      : Icons.visibility_outlined,
                ),
                onPressed: viewModel.togglePasswordVisibility,
              ),
              errorText: viewModel.passwordError,
            ),
            validator: viewModel.validatePassword,
          ),
          const SizedBox(height: 24),
          if (viewModel.networkException != null)
            ErrorContainer(message: viewModel.networkException!.message),
          ElevatedButton(
            onPressed:
                viewModel.isLoading
                    ? null
                    : () async {
                      if (await viewModel.login()) {
                        if (context.mounted) {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                        }
                      }
                    },
            child:
                viewModel.isLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}
