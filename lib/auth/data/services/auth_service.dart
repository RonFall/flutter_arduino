import 'package:firebase_auth/firebase_auth.dart';

/// Сервис аутентификации Firebase
class AuthService {
  User? get user => FirebaseAuth.instance.currentUser;

  String? get userId => user?.uid;

  String? get userEmail => user?.email;

  bool get isAlreadyLoggedIn => userId != null;

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async => FirebaseAuth.instance.signOut();
}
