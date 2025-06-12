import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/common/theme/app_theme.dart';
import 'ui/home/home_page.dart';
import 'core/services/authentication_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
      ],
      child: Consumer<AuthenticationService>(
        builder: (ctx, authService, _) {
          return MaterialApp(
            title: 'VestiArt',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.system,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
