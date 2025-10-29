import 'package:flutter/material.dart';

class AppTheme {
  // Cores principais
  static const Color primary = Color(0xFF623CEA); // Roxo vibrante
  static const Color primaryDark = Color(0xFF4A2DB0); // Roxo mais escuro para hover/pressed
  static const Color accent = Color(0xFFFFC012); // Amarelo para destaques
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2A2A2A); // Cards, inputs
  static const Color darkSurfaceVariant = Color(0xFF363636); // Elementos elevados
  static const Color darkText = Color(0xFFF4F0F0);
  static const Color darkTextSecondary = Color(0xFFB8B8B8);
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF0F0F0);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);

  // Cores de status
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Text Styles - Agora mais flexíveis
  static TextStyle _headlineLarge(Color color) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: color,
    height: 1.2,
  );

  static TextStyle _headlineMedium(Color color) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.3,
  );

  static TextStyle _titleLarge(Color color) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color,
    height: 1.3,
  );

  static TextStyle _bodyLarge(Color color) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: color,
    height: 1.5,
  );

  static TextStyle _bodyMedium(Color color) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: color,
    height: 1.5,
  );

  static TextStyle _labelLarge(Color color) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color,
    letterSpacing: 0.5,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  // Tema escuro
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primary,
    scaffoldBackgroundColor: darkBackground,
    
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: accent,
      surface: darkSurface,
      surfaceContainerHighest: darkSurfaceVariant,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: darkText,
      onSurfaceVariant: darkTextSecondary,
    ),
    
    textTheme: TextTheme(
      headlineLarge: _headlineLarge(darkText),
      headlineMedium: _headlineMedium(darkText),
      titleLarge: _titleLarge(darkText),
      bodyLarge: _bodyLarge(darkText),
      bodyMedium: _bodyMedium(darkTextSecondary),
      labelLarge: _labelLarge(Colors.white),
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBackground,
      foregroundColor: darkText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      labelStyle: const TextStyle(color: darkTextSecondary),
      hintStyle: const TextStyle(color: darkTextSecondary),
      // Cor do texto digitado no dark theme
      floatingLabelStyle: const TextStyle(color: primary),
      
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: darkSurfaceVariant, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primary, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: buttonText,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),
    
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    
    dividerTheme: const DividerThemeData(
      color: darkSurfaceVariant,
      thickness: 1,
      space: 1,
    ),
  );

  // Tema claro
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primary,
    scaffoldBackgroundColor: lightBackground,
    
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      surface: lightSurface,
      surfaceContainerHighest: lightSurfaceVariant,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: lightText,
      onSurfaceVariant: lightTextSecondary,
    ),
    
    textTheme: TextTheme(
      headlineLarge: _headlineLarge(lightText),
      headlineMedium: _headlineMedium(lightText),
      titleLarge: _titleLarge(lightText),
      bodyLarge: _bodyLarge(lightText),
      bodyMedium: _bodyMedium(lightTextSecondary),
      labelLarge: _labelLarge(Colors.white),
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: lightText,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightText,
      ),
      // Adiciona uma sombra sutil
      shadowColor: Colors.black.withOpacity(0.05),
    ),
    
    cardTheme: CardThemeData(
      color: lightSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: lightSurfaceVariant,
          width: 1,
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightSurface,
      labelStyle: const TextStyle(color: lightTextSecondary),
      hintStyle: const TextStyle(color: lightTextSecondary),
      
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: lightSurfaceVariant, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primary, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: error, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        textStyle: buttonText,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // Adiciona sombra sutil no light theme
        shadowColor: primary.withOpacity(0.3),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,
        side: const BorderSide(color: primary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 4,
      highlightElevation: 8,
    ),
    
    dividerTheme: const DividerThemeData(
      color: lightSurfaceVariant,
      thickness: 1,
      space: 1,
    ),
  );

  // Helper methods para usar cores de destaque
  static BoxDecoration accentGradientBox = BoxDecoration(
    gradient: LinearGradient(
      colors: [accent, accent.withOpacity(0.8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration primaryGradientBox = BoxDecoration(
    gradient: LinearGradient(
      colors: [primary, primaryDark],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}