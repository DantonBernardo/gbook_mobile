import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:gbook_mobile/presentation/pages/create_book_page.dart';

void main() {
  group('TU-02 - Teste de criação de livro', () {
    testWidgets('Deve criar um novo livro e exibir mensagem de sucesso', (WidgetTester tester) async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.toString(), contains('/api/books'));
        return http.Response(jsonEncode({'message': 'Livro criado com sucesso'}), 201);
      });

      await tester.pumpWidget(
        MaterialApp(
          home: CreateBookPage(client: mockClient), // 👈 injeta o mock
        ),
      );

      await tester.enterText(find.byType(TextFormField).at(0), 'O Senhor dos Anéis');
      await tester.enterText(find.byType(TextFormField).at(1), 'Uma jornada épica pela Terra Média.');
      await tester.enterText(find.byType(TextFormField).at(2), 'https://exemplo.com/livro.pdf');

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Livro adicionado com sucesso!'), findsOneWidget);
    });

    testWidgets('Deve mostrar erro se os campos estiverem vazios', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CreateBookPage()));

      await tester.tap(find.byType(ElevatedButton));

      await tester.pump();

      expect(find.text('Por favor, insira o título'), findsOneWidget);
      expect(find.text('Por favor, insira a descrição'), findsOneWidget);
      expect(find.text('Por favor, insira a URL do PDF'), findsOneWidget);
    });
  });
}
