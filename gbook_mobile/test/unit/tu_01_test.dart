import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';
import 'package:gbook_mobile/data/repositories/auth_repository_impl.dart';
import 'package:gbook_mobile/domain/entities/user.dart';
import 'package:gbook_mobile/domain/usecases/sign_in.dart';

void main() {
  late MockFirebaseAuthDataSource mockDataSource;
  late AuthRepositoryImpl repository;
  late SignIn signInUseCase;

  setUp(() {
    mockDataSource = MockFirebaseAuthDataSource();
    repository = AuthRepositoryImpl(mockDataSource);
    signInUseCase = SignIn(repository);
  });

  test('TU-01: login errado deve lançar exceção', () async {
    const wrongEmail = 'wrong@teste.com';
    const wrongPassword = 'qualquer';

    when(mockDataSource.signIn(wrongEmail, wrongPassword))
        .thenThrow(Exception('Usuário não encontrado'));

    expect(
      () async => await signInUseCase(wrongEmail, wrongPassword),
      throwsA(isA<Exception>()),
    );
  });

  test('TU-01: login correto deve retornar UserEntity', () async {
    const correctEmail = 'aluno@gmail.com';
    const correctPassword = '123456';

    final userEntity = UserEntity(uid: '12345', email: correctEmail);

    when(mockDataSource.signIn(correctEmail, correctPassword))
        .thenAnswer((_) async => userEntity);

    final result = await signInUseCase(correctEmail, correctPassword);

    expect(result, isA<UserEntity>());
    expect(result.email, equals(correctEmail));
    expect(result.uid, equals('12345'));

    verify(mockDataSource.signIn(correctEmail, correctPassword)).called(1);
  });
}
