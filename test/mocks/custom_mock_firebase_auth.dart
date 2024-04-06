import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

class CustomMockFirebaseAuth extends MockFirebaseAuth {
  CustomMockFirebaseAuth({super.mockUser});

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (email == 'nonexisting@example.com') {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for that email.',
      );
    }

    if (password == "wrong_password") {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message:
            'The password is invalid or the user does not have a password.',
      );
    }

    return super.signInWithEmailAndPassword(email: email, password: password);
  }
}
