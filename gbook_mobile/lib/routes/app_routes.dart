import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import '../screens/home_page.dart';
import '../screens/biblioteca_page.dart';
import '../screens/addBook_page.dart';

class AppRoutes {
  // nomes das rotas
  static const String login = '/login';
  static const String home = '/home';
  static const String biblioteca = '/biblioteca';
  static const String addBook = '/addBook';

  // mapa de rotas
  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginPage(),
      home: (context) => const HomePage(),
      biblioteca: (context) => const BibliotecaPage(),
      addBook: (context) => const AddBookPage(),
    };
  }
}
