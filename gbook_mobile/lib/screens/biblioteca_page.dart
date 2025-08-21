import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/app_bar.dart';
import '../widgets/expandable_menu.dart';
import '../widgets/books/all_books.dart';

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
    _books = _bookService.fetchRecentBooks();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableMenu(
      key: _menuKey,
      child: Scaffold(
        appBar: CustomAppBar(
          onMenuPressed: () {
            _menuKey.currentState?.toggleMenu();
          },
        ),
        body: Column(
          children: [Expanded(child: BookList(booksFuture: _books))],
        ),
      ),
    );
  }
}
