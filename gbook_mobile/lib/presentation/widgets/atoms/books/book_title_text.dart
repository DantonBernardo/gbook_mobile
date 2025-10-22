import 'package:flutter/material.dart';

class BookTitleText extends StatelessWidget {
  final String title;

  const BookTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
