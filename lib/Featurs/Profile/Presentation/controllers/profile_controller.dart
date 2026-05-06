import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brain_stack/services/auth_service.dart';

// ──────────────────────────────────────────────────────────
// WHAT THIS CONTROLLER DOES (for teammates):
//
//  • loadUserData()           → call in initState() to load profile
//  • userData                 → Map with 'username', 'phone', 'points', 'badges'
//  • updateUsername(newName)  → saves new username to Firestore
//  • logout(context)          → signs out and goes to Login screen
//  • isLoading                → show spinner while loading
// ──────────────────────────────────────────────────────────

class ProfileController extends ChangeNotifier {
  final _auth = AuthService();
  final _db = FirebaseFirestore.instance;

  String get userId => FirebaseAuth.instance.currentUser?.uid ?? '';

  bool isLoading = false;
  Map<String, dynamic>? userData;

  // Call this once in initState() of the Profile screen
  Future<void> loadUserData() async {
    isLoading = true;
    notifyListeners();

    if (userId.isEmpty) {
      isLoading = false;
      notifyListeners();
      return;
    }

    final doc = await _db.collection('users').doc(userId).get();
    userData = doc.data();
    isLoading = false;
    notifyListeners();
  }

  // Save new username to Firestore
  Future<void> updateUsername(String name) async {
    await _db.collection('users').doc(userId).update({'username': name.trim()});
    userData?['username'] = name.trim();
    notifyListeners();
  }

  // Sign out and go back to login
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (_) => false);
    }
  }
}
