import '../entities/user.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn({required String email, required String password});
  Future<void> signOut();
  UserEntity? get currentUser;
}
