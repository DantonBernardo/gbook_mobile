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

  Future<Book> fetchBookById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/books/$id"));

    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erro ao carregar livro");
    }
  }


  // Nova função para buscar livros
  Future<List<Book>> searchBooks(String query) async {
    if (query.isEmpty) {
      return [];
    }

    final response = await http.get(
      Uri.parse("$baseUrl/books/search?q=${Uri.encodeComponent(query)}")
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception("Erro na busca: ${response.statusCode}");
    }
  }

  Future<Book> createBook(String title, String description, String pdfUrl) async {
    final response = await http.post(
      Uri.parse("$baseUrl/books"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "description": description,
        "pdf_url": pdfUrl,
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body)["data"];
      return Book.fromJson(data);
    } else {
      throw Exception("Erro ao criar livro: ${response.body}");
    }
  }

}