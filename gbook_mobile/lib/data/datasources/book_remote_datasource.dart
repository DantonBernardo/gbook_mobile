import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getRecentBooks();
  Future<List<BookModel>> getAllBooks();
  Future<BookModel> getBookById(int id);
  Future<List<BookModel>> searchBooks(String query); // Adicione esta linha
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final http.Client client;

  BookRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookModel>> getRecentBooks() async {
    final response = await client.get(Uri.parse('http://127.0.0.1:8000/api/books/recents'));
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar livros recentes');
    }
  }

  @override
  Future<List<BookModel>> getAllBooks() async {
    final response = await client.get(Uri.parse('http://127.0.0.1:8000/api/books'));
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar todos os livros');
    }
  }

  @override
  Future<BookModel> getBookById(int id) async {
    final response = await client.get(Uri.parse('http://127.0.0.1:8000/api/books/$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return BookModel.fromJson(json);
    } else {
      throw Exception('Erro ao carregar detalhes do livro');
    }
  }

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    final response = await client.get(
      Uri.parse('http://127.0.0.1:8000/api/books/search?q=${Uri.encodeComponent(query)}'),
    );
    if (response.statusCode == 200) {
      final List jsonList = jsonDecode(response.body);
      return jsonList.map((json) => BookModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar livros');
    }
  }
}