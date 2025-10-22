import 'package:flutter/material.dart';
import '../../atoms/books/book_title_text.dart';
import '../../atoms/books/custom_pdf_button.dart';

class BookInfoRow extends StatelessWidget {
  final String title;
  final String description;
  final String pdfUrl;

  const BookInfoRow({
    super.key,
    required this.title,
    required this.description,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookTitleText(title: title),
              const SizedBox(height: 4),
              Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        CustomPdfButton(pdfUrl: pdfUrl),
      ],
    );
  }
}
