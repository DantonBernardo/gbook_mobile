import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/app_bar.dart';
import '../widgets/expandable_menu.dart';
import '../widgets/books/all_books.dart';
import '../theme/theme_provider.dart';

class BibliotecaPage extends StatefulWidget {
  const BibliotecaPage({super.key});

  @override
  State<BibliotecaPage> createState() => _BibliotecaPageState();
}

class _BibliotecaPageState extends State<BibliotecaPage> {
  final BookService _bookService = BookService();
  late Future<List<Book>> _books;

  final GlobalKey<ExpandableMenuState> _menuKey =
      GlobalKey<ExpandableMenuState>();

  @override
  void initState() {
    super.initState();
    _books = _bookService.fetchAllBooks();
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
        body: SingleChildScrollView( // scroll único pra toda a página
          child: Column(
            children: [
              BookList(booksFuture: _books), // primeiro BookList
            ],
          ),
        ),
      ),
    );
  }
}