import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_routes.dart';
import 'core/services/authentication_service.dart';
import 'ui/auth/login/login_screen.dart';
import 'ui/auth/register/register_screen.dart';
import 'ui/common/theme/app_theme.dart';
import 'ui/generation/prompting/prompting_page.dart';
import 'ui/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService.instance),
      ],
      child: Consumer<AuthenticationService>(
        builder: (ctx, authService, _) {
          return MaterialApp(
            title: 'VestiArt',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            initialRoute: AppRoutes.home,
            routes: {
              AppRoutes.home: (context) => const HomePage(),
              AppRoutes.login: (context) => const LoginScreen(),
              AppRoutes.register: (context) => const RegisterScreen(),
              AppRoutes.creationPrompting: (context) => const PromptingPage(),
            },
          );
        },
      ),
    );
  }
}
