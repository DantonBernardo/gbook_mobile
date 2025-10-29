import 'package:flutter/material.dart';
import '../../molecules/books/book_info_row.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String description;
  final String pdfUrl;

  const BookCard({
    super.key,
    required this.title,
    required this.description,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: BookInfoRow(
          title: title,
          description: description,
          pdfUrl: pdfUrl,
        ),
      ),
    );
  }
}
