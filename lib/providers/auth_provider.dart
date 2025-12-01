import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flood_detection/service/navigation_service.dart';
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
      _errorMessage = 'Gagal mendaftar. Silakan coba lagi.';
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
        _errorMessage = 'Email belum terdaftar.';
      }

      if (e.code == 'wrong-password') {
        _errorMessage = 'Password salah.';
      }

      rethrow;
    } catch (e) {
      _errorMessage = 'Email atau password salah.';
      rethrow;
    } finally {
      _isAuthenticating = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isAuthenticating = true;
    notifyListeners();

    _showLoadingDialog();

    await Future.delayed(const Duration(milliseconds: 700));

    _isAuthenticating = false;
    notifyListeners();

    _closeDialog();
  }

  void _showLoadingDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  void _closeDialog() {
    navigatorKey.currentState?.pop();
  }

  String _mapFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'Password yang diberikan terlalu lemah.';
      case 'email-already-in-use':
        return 'Akun sudah ada untuk email tersebut.';
      case 'user-not-found':
        return 'Tidak ditemukan pengguna untuk email tersebut.';
      case 'wrong-password':
        return 'Password salah.';
      case 'invalid-email':
        return 'Format email tidak valid.';
      default:
        return 'Autentikasi gagal. Silakan coba lagi.';
    }
  }
}
