import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book_model.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> getRecentBooks();
  Future<List<BookModel>> getAllBooks();
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
}