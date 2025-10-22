import 'package:flutter/material.dart';
import '../../domain/entities/book.dart';
import '../widgets/organisms/book_card.dart';

class AllBooksTemplate extends StatelessWidget {
  final List<Book> books;

  const AllBooksTemplate({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCard(
          title: book.title,
          description: book.description,
          pdfUrl: book.pdfUrl,
        );
      },
    );
  }
}
