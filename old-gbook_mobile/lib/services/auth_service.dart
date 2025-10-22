import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw AuthException("Dados inválidos. Verifique os campos.");
    } else if (response.statusCode == 401) {
      throw AuthException("Email ou senha incorretos.");
    } else if (response.statusCode == 500) {
      throw AuthException("Erro no servidor. Tente novamente mais tarde.");
    } else {
      throw AuthException("Erro inesperado (${response.statusCode}).");
    }
  }
}
