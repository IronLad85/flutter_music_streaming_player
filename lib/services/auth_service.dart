import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService._privateConstructor(this._firebaseAuth);

  static final AuthService _instance =
      AuthService._privateConstructor(FirebaseAuth.instance);

  factory AuthService() {
    return _instance;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }
}
