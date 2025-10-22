import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserEntity> signIn(String email, String password) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = result.user;
    if (user == null) throw Exception("Usuário não encontrado");

    return UserEntity(uid: user.uid, email: user.email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  UserEntity? getCurrentUser() {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email);
  }
}
