import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/all_books_page.dart';
import '../pages/create_book_page.dart';
import '../pages/book_detail_page.dart';
import '../pages/search_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/login': (context) => const LoginPage(),
        '/all-books': (context) => const AllBooksPage(),
        '/create-book': (context) => const CreateBookPage(),
        '/search': (context) => const SearchPage(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/book-detail') {
      final bookId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (context) => BookDetailPage(bookId: bookId),
      );
    }
    return null;
  }
}