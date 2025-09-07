import 'package:flutter/material.dart';

class AppTheme {
  // Cores
  static const Color primary = Color.fromARGB(255, 89, 63, 182);
  static const Color darkerPrimary = Color(0xFF623CEA);
  static const Color secondary = Color(0xFFFFC012);
  static const Color background = Color(0xFF1A1A1A);
  static const Color textPrimary = Color(0xFFF4F0F0);

  static const Color lightBackground = Color(0xFFF4F0F0);
  static const Color lightTextPrimary = Color(0xFF1A1A1A); // Texto escuro para tema claro

  // Text Styles para tema escuro
  static const TextStyle headlineLargeDark = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static const TextStyle headlineMediumDark = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static const TextStyle bodyLargeDark = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );

  // Text Styles para tema claro
  static const TextStyle headlineLargeLight = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: lightTextPrimary,
  );

  static const TextStyle headlineMediumLight = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: lightTextPrimary,
  );

  static const TextStyle bodyLargeLight = TextStyle(
    fontSize: 16,
    color: lightTextPrimary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Tema escuro
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: background,
      background: background,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: textPrimary,
      onBackground: textPrimary,
    ),
    textTheme: const TextTheme(
      headlineLarge: headlineLargeDark,
      headlineMedium: headlineMediumDark,
      bodyLarge: bodyLargeDark,
      labelLarge: buttonText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: background,
      foregroundColor: textPrimary,
      elevation: 0,
    ),
    // Configuração dos inputs para tema escuro
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: textPrimary),
      hintStyle: TextStyle(color: Color(0xFF888888)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: textPrimary, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      filled: true,
      fillColor: Color(0xFF2A2A2A),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: buttonText,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: lightBackground,
      background: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: lightTextPrimary,
      onBackground: lightTextPrimary,
    ),
    textTheme: const TextTheme(
      headlineLarge: headlineLargeLight,
      headlineMedium: headlineMediumLight,
      bodyLarge: bodyLargeLight,
      labelLarge: buttonText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightBackground,
      foregroundColor: lightTextPrimary,
      elevation: 0,
    ),
    // Configuração dos inputs para tema claro
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: lightTextPrimary),
      hintStyle: TextStyle(color: Color(0xFF666666)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: lightTextPrimary, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: buttonText,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}