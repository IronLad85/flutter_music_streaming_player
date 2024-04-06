import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/custom_mock_firebase_auth.dart';

void main() {
  late MockUser mockUser;
  late CustomMockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockUser = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'test@example.com',
    );
    mockFirebaseAuth = CustomMockFirebaseAuth(mockUser: mockUser);
  });

  test('sign in with correct email and password', () async {
    final result = await mockFirebaseAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password',
    );
    expect(result.user, isNotNull);
    expect(result.user!.uid, 'someuid');
  });

  test('sign in with wrong password', () async {
    try {
      await mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'wrong_password',
      );
      fail('This call should throw a FirebaseAuthException.');
    } on FirebaseAuthException catch (e) {
      expect(e.code, 'wrong-password');
    }
  });

  test('sign in with a non-existing user email', () async {
    try {
      await mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'nonexisting@example.com',
        password: 'password',
      );
      fail(
        'This call should throw a FirebaseAuthException for a non-existing user.',
      );
    } on FirebaseAuthException catch (e) {
      expect(e.code, 'user-not-found');
    }
  });
}
