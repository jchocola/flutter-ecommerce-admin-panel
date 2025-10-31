import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      User? user = _firebaseAuth.currentUser;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  // singleton pattern
  AuthRepository._privateConstructor();
  static final AuthRepository _instance = AuthRepository._privateConstructor();
  static AuthRepository get instance => _instance;
}
