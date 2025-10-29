import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gbook_mobile/presentation/bloc/login_bloc.dart';
import 'package:gbook_mobile/presentation/widgets/molecules/login_form.dart';
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
    'TW-01: campos de e-mail, senha e botão de login devem estar presentes',
    (WidgetTester tester) async {

    // Renderiza apenas o LoginForm com BlocProvider fake
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (_) => LoginBloc(mockRepository),
            child: const LoginForm(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verifica se os campos de e-mail e senha estão na tela
    expect(find.byKey(const Key('emailField')), findsOneWidget);
    expect(find.byKey(const Key('passwordField')), findsOneWidget);

    // Verifica se o botão de login está na tela
    expect(find.byKey(const Key('loginButton')), findsOneWidget);
  });
}
