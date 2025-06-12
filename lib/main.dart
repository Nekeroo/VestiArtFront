import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routing/app_routes.dart';
import 'core/services/authentication_service.dart';
import 'ui/auth/login/login_page.dart';
import 'ui/auth/register/register_page.dart';
import 'package:vesti_art/ui/admin/admin_panel.View.dart';
import 'ui/common/theme/app_theme.dart';
import 'ui/generation/prompting/prompting_page.dart';
import 'ui/home/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthenticationService.instance.initialize();
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
              AppRoutes.home:
                  (context) =>
                      kIsWeb ? const AdminPanelView() : const HomePage(),
              AppRoutes.login: (context) => const LoginPage(),
              AppRoutes.register: (context) => const RegisterPage(),
              AppRoutes.creationPrompting: (context) => const PromptingPage(),
            },
          );
        },
      ),
      // (Platform.isAndroid || Platform.isIOS)
      //     ? const HomePage()
      //     : const AdminPanelView(),
    );
  }
}
