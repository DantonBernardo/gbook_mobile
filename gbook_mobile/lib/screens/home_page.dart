import 'package:flutter/material.dart';
import '../services/book_service.dart';
import '../models/book.dart';
import '../widgets/app_bar.dart';
import '../widgets/expandable_menu.dart';
import '../widgets/app_carousel.dart';
import '../widgets/books/recent_books.dart';

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
    return ExpandableMenu(
      key: _menuKey,
      child: Scaffold(
        appBar: CustomAppBar(
          onMenuPressed: () {
            _menuKey.currentState?.toggleMenu();
          },
        ),
        body: Column(
          children: [
            AppCarousel(),
            BookList(booksFuture: _books),
            
          ],
        ),
      ),
    );
  }
}
