import '../entities/book.dart';
import '../repositories/book_repository.dart';

class GetAllBooks {
  final BookRepository repository;

  GetAllBooks(this.repository);

  Future<List<Book>> call() async {
    return await repository.getAllBooks();
  }
}
