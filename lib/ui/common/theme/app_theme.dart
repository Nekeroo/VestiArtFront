import 'package:flutter/material.dart';
import 'package:vesti_art/ui/common/theme/drop_down_theme.dart';
import 'package:vesti_art/ui/common/theme/textfields_theme.dart';
import 'button_theme.dart';
import 'app_bar_theme.dart';

class AppColors {
  static const Color seedColor = Color(0xFF6200EE);
}

ThemeData _createTheme({required Brightness brightness}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seedColor,
    brightness: brightness,
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
    inputDecorationTheme: TextfieldsTheme.inputDecorationTheme(colorScheme),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
      },
    ),
    dropdownMenuTheme: DropDownTheme.dropdownMenuTheme(colorScheme),
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
