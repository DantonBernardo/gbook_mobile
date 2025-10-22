import '../entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> getRecentBooks();
  Future<List<Book>> getAllBooks();
}