import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:gbook_mobile/presentation/pages/create_book_page.dart';

// Mock do http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('TI-02 - Fluxo criar livro e listar', (WidgetTester tester) async {
    final mockClient = MockClient();

    // Configura o mock pra retornar sucesso
    when(() => mockClient.post(
          Uri.parse('http://127.0.0.1:8000/api/books'),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer(
      (_) async => http.Response('{"message": "success"}', 201),
    );

    // Inicializa a página CreateBookPage com o mock
    await tester.pumpWidget(
      MaterialApp(
        home: CreateBookPage(client: mockClient),
        routes: {
          '/all-books': (context) => const Scaffold(body: Text('Página de Livros')),
        },
      ),
    );

    // Preenche os campos do formulário
    await tester.enterText(find.byType(TextFormField).at(0), 'Livro de Teste');
    await tester.enterText(find.byType(TextFormField).at(1), 'Descrição do livro de teste');
    await tester.enterText(find.byType(TextFormField).at(2), 'https://teste.com/livro.pdf');

    // Clica no botão de adicionar livro
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // espera animações e SnackBar

    // Verifica se o SnackBar de sucesso apareceu
    expect(find.text('Livro adicionado com sucesso!'), findsOneWidget);
  });
}
