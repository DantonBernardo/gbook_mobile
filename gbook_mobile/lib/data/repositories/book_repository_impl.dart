import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Book>> getRecentBooks() async {
    return await remoteDataSource.getRecentBooks();
  }

  @override
  Future<List<Book>> getAllBooks() async {
    return await remoteDataSource.getAllBooks();
  }
}
