import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vesti_art/ui/common/theme/app_radius.dart';

class AppBarStyles {
  static AppBarTheme appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 4,
      backgroundColor: colorScheme.primaryContainer.withOpacity(0.95),
      foregroundColor: colorScheme.onPrimaryContainer,
      shadowColor: colorScheme.shadow.withOpacity(0.3),
      surfaceTintColor: colorScheme.primary.withOpacity(0.2),
      iconTheme: IconThemeData(color: colorScheme.onPrimaryContainer, size: 24),
      actionsIconTheme: IconThemeData(
        color: colorScheme.onPrimaryContainer,
        size: 24,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: colorScheme.onPrimaryContainer,
      ),
      toolbarHeight: 64,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
        statusBarBrightness: colorScheme.brightness,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.m),
        ),
      ),
    );
  }
}
