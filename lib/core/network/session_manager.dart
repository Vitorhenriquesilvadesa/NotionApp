import 'package:brill_app/core/network/authentication.dart';
import 'package:flutter/material.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  final AuthenticationController _authController = AuthenticationController();

  AuthenticationData? get currentSession => _authController.currentSession;

  bool get isLoggedIn => _authController.isLoggedIn;

  Future<AuthenticationStatus> tryRestoreSession() async {
    final status = await _authController.tryRestoreSession();
    return status;
  }

  Future<AuthenticationStatus> login({
    required String email,
    required String password,
  }) async {
    final status = await _authController.login(
      email: email,
      password: password,
    );
    return status;
  }

  Future<void> logout() async {
    await _authController.logout();
  }

  Future<RegistrationStatus> register({
    required String email,
    required String password,
    required String fullname,
    required String username,
  }) async {
    final status = await _authController.register(
      email: email,
      password: password,
      fullname: fullname,
      username: username,
    );
    return status;
  }
}
