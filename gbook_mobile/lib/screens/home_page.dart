import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/app_bar.dart';
import '../widgets/expandable_menu.dart';
import '../widgets/app_carousel.dart';
import '../widgets/books/recent_books.dart';
import '../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BookService _bookService = BookService();
  late Future<List<Book>> _books;

  final GlobalKey<ExpandableMenuState> _menuKey =
      GlobalKey<ExpandableMenuState>();

  @override
  void initState() {
    super.initState();
    _books = _bookService.fetchRecentBooks();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);

    return ExpandableMenu(
      key: _menuKey,
      isDarkTheme: themeProvider?.isDarkTheme ?? true,
      onThemeToggle: themeProvider?.onThemeToggle ?? () {},
      child: Scaffold(
        appBar: CustomAppBar(
          onMenuPressed: () {
            _menuKey.currentState?.toggleMenu();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppCarousel(),
              BookCarousel(booksFuture: _books),
            ],
          ),
        ),
      ),
    );
  }
}