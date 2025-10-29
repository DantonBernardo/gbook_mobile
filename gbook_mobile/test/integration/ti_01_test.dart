import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbook_mobile/presentation/bloc/login_bloc.dart';
import 'package:gbook_mobile/presentation/widgets/molecules/login_form.dart';
import 'package:gbook_mobile/domain/entities/user.dart';
import 'package:gbook_mobile/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

// Mock do AuthRepository
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  testWidgets(
    'TI-01: ao fazer login, deve navegar para /all-books',
    (WidgetTester tester) async {
      
    // Configura o mock para retornar um usuário válido quando signIn for chamado
    final testUser = UserEntity(uid: '123', email: 'aluno@gmail.com');
    when(() => mockRepository.signIn(
      email: 'aluno@gmail.com',
      password: '123456',
    )).thenAnswer((_) async => testUser);

    // Rota /all-books de teste
    final allBooksKey = GlobalKey();

    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/all-books': (context) => Scaffold(key: allBooksKey, body: const Text('All Books Page')),
        },
        home: Scaffold(
          body: BlocProvider(
            create: (_) => LoginBloc(mockRepository),
            child: const LoginForm(),
          ),
        ),
      ),
    );

    // Digita o e-mail e senha
    await tester.enterText(find.byKey(const Key('emailField')), 'aluno@gmail.com');
    await tester.enterText(find.byKey(const Key('passwordField')), '123456');

    // Clica no botão de login
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump(); // dispara o evento LoginSubmitted

    // Como o LoginBloc é async, precisamos esperar o estado LoginSuccess
    await tester.pumpAndSettle();

    // Verifica se navegou para /all-books
    expect(find.byKey(allBooksKey), findsOneWidget);
    expect(find.text('All Books Page'), findsOneWidget);
  });
}
