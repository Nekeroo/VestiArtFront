import 'package:flutter/material.dart';
import 'button_theme.dart';
import 'app_bar_theme.dart';

class AppColors {
  static const Color seedColor = Color(0xFF6200EE);
  static const Color errorColor = Color(0xFFB00020);
}

ThemeData _createTheme({required Brightness brightness}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seedColor,
    brightness: brightness,
    error: AppColors.errorColor,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    elevatedButtonTheme: AppButtonTheme.elevatedButtonTheme(colorScheme),
    filledButtonTheme: AppButtonTheme.filledButtonTheme(colorScheme),
    outlinedButtonTheme: AppButtonTheme.outlinedButtonTheme(colorScheme),
    textButtonTheme: AppButtonTheme.textButtonTheme(colorScheme),
    appBarTheme: AppBarStyles.appBarTheme(colorScheme),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
  );
}

final lightTheme = _createTheme(brightness: Brightness.light);
final darkTheme = _createTheme(brightness: Brightness.dark);

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
