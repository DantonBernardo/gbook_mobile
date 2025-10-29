import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/all_books_page.dart';
import '../pages/create_book_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/login': (context) => const LoginPage(),
        '/all-books': (context) => const AllBooksPage(),
        '/create-book': (context) => const CreateBookPage(),
      };
}
