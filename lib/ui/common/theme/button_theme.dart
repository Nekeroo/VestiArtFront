import 'package:flutter/material.dart';
import 'app_spacing.dart';
import 'app_radius.dart';

const _buttonRadius = AppRadius.s;

class AppButtonStyles {
  // Elevated Button Styles
  static ButtonStyle elevatedButtonStyle(ColorScheme colorScheme) {
    return ElevatedButton.styleFrom(
      foregroundColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
      elevation: 2,
    );
  }

  // Filled Button Styles
  static ButtonStyle filledButtonStyle(ColorScheme colorScheme) {
    return FilledButton.styleFrom(
      foregroundColor: colorScheme.onPrimary,
      backgroundColor: colorScheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    );
  }

  // Outlined Button Styles
  static ButtonStyle outlinedButtonStyle(ColorScheme colorScheme) {
    return OutlinedButton.styleFrom(
      foregroundColor: colorScheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      side: BorderSide(color: colorScheme.primary, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    );
  }

  // Text Button Styles
  static ButtonStyle textButtonStyle(ColorScheme colorScheme) {
    return TextButton.styleFrom(
      foregroundColor: colorScheme.primary,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.xs,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    );
  }

  // Icon Button Styles
  static ButtonStyle iconButtonStyle(ColorScheme colorScheme) {
    return IconButton.styleFrom(
      foregroundColor: colorScheme.primary,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_buttonRadius),
      ),
    );
  }
}

class AppButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: AppButtonStyles.elevatedButtonStyle(colorScheme),
    );
  }

  static FilledButtonThemeData filledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: AppButtonStyles.filledButtonStyle(colorScheme),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: AppButtonStyles.outlinedButtonStyle(colorScheme),
    );
  }

  static TextButtonThemeData textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: AppButtonStyles.textButtonStyle(colorScheme),
    );
  }
}
