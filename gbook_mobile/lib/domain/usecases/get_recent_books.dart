import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetRecentBooks {
  final BookRepository repository;

  GetRecentBooks(this.repository);

  Future<List<Book>> call() async {
    return await repository.getRecentBooks();
  }
}