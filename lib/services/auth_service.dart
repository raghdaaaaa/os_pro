import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> registerUser(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email.trim(), password: password.trim());
    return result.user;
  }

  Future<User?> loginUser(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email.trim(), password: password.trim());
    return result.user;
  }

  Future<void> signOut() => _auth.signOut();

  // Converts Firebase error codes into readable messages
  String getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':       return 'No account found with this email.';
      case 'wrong-password':       return 'Incorrect password.';
      case 'invalid-credential':   return 'Wrong email or password.';
      case 'email-already-in-use': return 'This email is already registered.';
      case 'weak-password':        return 'Password needs 6+ characters.';
      default:                     return 'Something went wrong. Try again.';
    }
  }
}
