import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbook_mobile/presentation/pages/create_book_page.dart';
import 'package:gbook_mobile/presentation/pages/all_books_page.dart';
import 'package:gbook_mobile/domain/entities/book.dart';
import 'package:gbook_mobile/domain/usecases/get_all_books.dart';
import 'package:gbook_mobile/data/repositories/book_repository_impl.dart';
import 'package:gbook_mobile/data/datasources/book_remote_datasource.dart';
import 'package:gbook_mobile/presentation/bloc/books/bloc/book_bloc.dart';
import 'package:gbook_mobile/presentation/bloc/books/bloc/book_event.dart';
import 'package:gbook_mobile/presentation/bloc/books/bloc/book_state.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('TI-02 - Fluxo criar livro e listar', () {
    testWidgets('Deve criar um livro e verificar se aparece na listagem', (WidgetTester tester) async {
      // Mock do client HTTP para a criação de livro
      final mockClient = MockClient((request) async {
        if (request.url.toString().contains('/api/books') && request.method == 'POST') {
          return http.Response(jsonEncode({'id': 1, 'title': 'O Senhor dos Anéis', 'description': 'Uma jornada épica.', 'pdf_url': 'https://exemplo.com/livro.pdf'}), 201);
        }
        return http.Response('Erro', 400);
      });

      // Mock do RemoteDataSource para listagem de livros
      final mockDataSource = BookRemoteDataSourceImpl(client: mockClient);

      // Mock do Repository
      final repository = BookRepositoryImpl(remoteDataSource: mockDataSource);

      // UseCase
      final getAllBooks = GetAllBooks(repository);

      // Livro que vamos criar
      final createdBook = Book(
        id: 1,
        title: 'O Senhor dos Anéis',
        description: 'Uma jornada épica.',
        pdfUrl: 'https://exemplo.com/livro.pdf',
      );

      // === PASSO 1: Abrir a página de criar livro ===
      await tester.pumpWidget(MaterialApp(
        home: CreateBookPage(client: mockClient),
      ));

      // Preencher formulário
      await tester.enterText(find.byType(TextFormField).at(0), createdBook.title);
      await tester.enterText(find.byType(TextFormField).at(1), createdBook.description);
      await tester.enterText(find.byType(TextFormField).at(2), createdBook.pdfUrl);

      // Clicar no botão
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verifica SnackBar de sucesso
      expect(find.text('Livro adicionado com sucesso!'), findsOneWidget);

      // === PASSO 2: Abrir AllBooksPage com BookBloc ===
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => BookBloc(getAllBooks)..add(LoadAllBooks()),
            child: const AllBooksPage(),
          ),
        ),
      );

      // Aguarda o FutureBuilder e o BlocBuilder renderizarem
      await tester.pumpAndSettle();

      // Verifica se o livro recém-criado aparece na tela
      expect(find.text(createdBook.title), findsOneWidget);
      expect(find.text(createdBook.description), findsOneWidget);
    });
  });
}
