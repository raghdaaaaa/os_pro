import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brain_stack/services/auth_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • login(email, password)   → signs user in with Firebase
//  • register(username, phone, password) → creates account + saves profile
//  • isLoading                → true while Firebase is working (show spinner)
//  • errorMessage             → non-null when something fails (show in red)
//  • isSuccess                → true when done (navigate to Home)
// ──────────────────────────────────────────────────────────

class AuthController extends ChangeNotifier {
  final _auth = AuthService();
  final _db   = FirebaseFirestore.instance;

  bool    isLoading    = false;
  bool    isSuccess    = false;
  String? errorMessage;

  // Called by Sign In button
  Future<void> login(String email, String password) async {
    _start();
    try {
      final user = await _auth.loginUser(email, password);
      isSuccess = user != null;
    } on FirebaseAuthException catch (e) {
      errorMessage = _auth.getErrorMessage(e.code);
    } catch (_) {
      errorMessage = 'Something went wrong. Try again.';
    }
    _done();
  }

  // Called by Sign Up button
  Future<void> register(String username, String phone, String password) async {
    // Basic validation before hitting Firebase
    if (username.isEmpty || phone.isEmpty || password.isEmpty) {
      errorMessage = 'Please fill in all fields.';
      notifyListeners();
      return;
    }

    _start();
    // Build email from username because the UI has no email field
    final email = '${username.trim().toLowerCase().replaceAll(' ', '_')}@dosmart.app';

    try {
      final user = await _auth.registerUser(email, password);
      if (user != null) {
        // Save profile info to Firestore
        await _db.collection('users').doc(user.uid).set({
          'uid':       user.uid,
          'username':  username.trim(),
          'phone':     phone.trim(),
          'points':    0,
          'badges':    [],
          'createdAt': FieldValue.serverTimestamp(),
        });
        isSuccess = true;
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = _auth.getErrorMessage(e.code);
    } catch (_) {
      errorMessage = 'Something went wrong. Try again.';
    }
    _done();
  }

  void _start() {
    isLoading = true; isSuccess = false; errorMessage = null;
    notifyListeners();
  }

  void _done() {
    isLoading = false;
    notifyListeners();
  }
}
