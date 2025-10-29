import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gbook_mobile/presentation/pages/create_book_page.dart';

void main() {
  group('TW-02 - Validação do formulário CreateBookPage', () {

    testWidgets('Exibe mensagens de alerta quando campos estão vazios', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CreateBookPage()));

      // Toca no botão sem preencher nada
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verifica se cada campo obrigatóro exibe a mensagem correta
      expect(find.text('Por favor, insira o título'), findsOneWidget);
      expect(find.text('Por favor, insira a descrição'), findsOneWidget);
      expect(find.text('Por favor, insira a URL do PDF'), findsOneWidget);
    });

    testWidgets('Exibe alerta quando URL do PDF é inválida', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CreateBookPage()));

      // Preenche campos obrigatórios, mas deixa URL inválida
      await tester.enterText(find.byType(TextFormField).at(0), 'Livro de Teste');
      await tester.enterText(find.byType(TextFormField).at(1), 'Descrição de teste.');
      await tester.enterText(find.byType(TextFormField).at(2), 'not-a-valid-url');

      // Toca no botão
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Espera mensagem de URL inválida
      expect(find.text('Por favor, insira uma URL válida'), findsOneWidget);
    });

    testWidgets('Não exibe mensagens de alerta quando formulário está correto', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: CreateBookPage()));

      // Preenche todos os campos corretamente
      await tester.enterText(find.byType(TextFormField).at(0), 'Livro de Teste');
      await tester.enterText(find.byType(TextFormField).at(1), 'Descrição de teste.');
      await tester.enterText(find.byType(TextFormField).at(2), 'https://exemplo.com/livro.pdf');

      // Toca no botão
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Nenhuma mensagem de validação deve aparecer
      expect(find.textContaining('Por favor'), findsNothing);
    });
  });
}
