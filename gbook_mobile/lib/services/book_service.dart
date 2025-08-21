import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<Book>> fetchRecentBooks() async {
    final response = await http.get(Uri.parse("$baseUrl/books/recents"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao carregar livros recentes: ${response.statusCode}");
    }
  }

  Future<List<Book>> fetchAllBooks() async {
    final response = await http.get(Uri.parse("$baseUrl/books"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception("Erro ao carregar todos os livros: ${response.statusCode}");
    }
  }
}