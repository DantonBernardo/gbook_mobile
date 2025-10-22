import '../../domain/entities/book.dart';

class BookModel extends Book {
  const BookModel({
    required super.id,
    required super.title,
    required super.description,
    required super.pdfUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      pdfUrl: json['pdf_url'] ?? '',
    );
  }
}