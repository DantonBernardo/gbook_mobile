import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';
import '../../theme/theme_provider.dart';

void main() {  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = true;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkTheme: isDarkTheme,
      onThemeToggle: toggleTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GBook',
        theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.routes,
      ),
    );
  }
}