import 'package:flutter/material.dart';

/// WhatsApp style color palette
class AppColors {
  // LIGHT THEME (WhatsApp jaisa)
  static const Color primaryLight = Color(0xFF075E54); // AppBar green
  static const Color secondary = Color(0xFF25D366); // FAB + accent
  static const Color backgroundLight = Color(0xFFECE5DD); // Chat list bg
  static const Color surfaceLight = Color(0xFFFFFFFF); // Cards, tiles

  // DARK THEME (WhatsApp dark jaisa)
  static const Color primaryDark = Color(0xFF075E54); // Top bar
  static const Color backgroundDark = Color(0xFF111B21); // Main bg
  static const Color surfaceDark = Color(0xFF1F2C34); // Chat tiles

  // Common error colors
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  // On-colors (text/icons on top of backgrounds)
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFFFFFFFF);

  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);

  static const Color onBackgroundLight = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFE9EDEF); // WhatsApp text

  static const Color onSurfaceLight = Color(0xFF000000);
  static const Color onSurfaceDark = Color(0xFFE9EDEF);

  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);
}

ColorScheme get lightColorScheme {
  return const ColorScheme.light(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.onPrimaryLight,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondaryLight,
    background: AppColors.backgroundLight,
    onBackground: AppColors.onBackgroundLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
    error: AppColors.errorLight,
    onError: AppColors.onErrorLight,
  );
}

ColorScheme get darkColorScheme {
  return const ColorScheme.dark(
    primary: AppColors.primaryDark,
    onPrimary: AppColors.onPrimaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondaryDark,
    background: AppColors.backgroundDark,
    onBackground: AppColors.onBackgroundDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    error: AppColors.errorDark,
    onError: AppColors.onErrorDark,
  );
}

AppBarTheme appBarThemeFromScheme(ColorScheme scheme) {
  return AppBarTheme(
    backgroundColor: scheme.primary,
    elevation: 4,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: scheme.onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: scheme.onPrimary),
  );
}

// NOTE: ButtonThemeData purana system hai, lekin agar tum abhi bhi
// old buttons use kar rahe ho to ye theek chalega.
ButtonThemeData buttonThemeFromScheme(ColorScheme scheme) {
  return ButtonThemeData(
    buttonColor: scheme.primary,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}

InputDecorationTheme inputDecorationThemeFromScheme(ColorScheme scheme) {
  return InputDecorationTheme(
    filled: true,
    fillColor: scheme.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  );
}

TextTheme textThemeFromScheme(ColorScheme scheme) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: scheme.onBackground,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: scheme.onBackground),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: scheme.onPrimary,
    ),
  );
}

ThemeData themeFromScheme(ColorScheme scheme) {
  return ThemeData(
    useMaterial3: true, // optional, agar M3 use kar rahe ho
    colorScheme: scheme,
    primaryColor: scheme.primary,
    scaffoldBackgroundColor: scheme.background,
    appBarTheme: appBarThemeFromScheme(scheme),
    buttonTheme: buttonThemeFromScheme(scheme),
    inputDecorationTheme: inputDecorationThemeFromScheme(scheme),
    textTheme: textThemeFromScheme(scheme),
  );
}

ThemeData get lightTheme => themeFromScheme(lightColorScheme);
ThemeData get darkTheme => themeFromScheme(darkColorScheme);
