import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _errorMessage;

  bool _isLoadingAuth = true;
  bool _isAuthenticating = false;

  final Completer<void> _initialAuthCheckCompleted = Completer<void>();

  static Future<void> initializeAuthPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
  }

  Future<void> get initialAuthCheckCompleted =>
      _initialAuthCheckCompleted.future;

  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  bool get isLoadingAuth => _isLoadingAuth;
  bool get isAuthenticating => _isAuthenticating;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;

      if (!_initialAuthCheckCompleted.isCompleted) {
        _isLoadingAuth = false;
        _initialAuthCheckCompleted.complete();
      }

      notifyListeners();
    });
  }

  Future<void> register(String email, String password) async {
    _errorMessage = null;
    _isAuthenticating = true;
    notifyListeners();
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseAuthError(e);
      rethrow;
    } catch (e) {
      _errorMessage = 'Registration failed. Please try again.';
      rethrow;
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _errorMessage = null;
    _isAuthenticating = true;
    notifyListeners();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = _mapFirebaseAuthError(e);

      if (e.code == 'user-not-found') {
        _errorMessage = 'Email not registered yet.';
      }

      if (e.code == 'wrong-password') {
        _errorMessage = 'Wrong password.';
      }

      rethrow;
    } catch (e) {
      _errorMessage = 'Incorrect email or password';
      rethrow;
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isAuthenticating = true;
    notifyListeners();

    try {
      await _auth.signOut();

      await Future.delayed(const Duration(milliseconds: 500));

      _errorMessage = null;
    } on Exception {
      _errorMessage = 'Failed to log out. Please try again.';
      rethrow;
    } finally {
      _isAuthenticating = false;

      notifyListeners();
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for the specified email address.';
      case 'user-not-found':
        return 'No user was found for the specified email address.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'invalid-email':
        return 'The email format is invalid.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
