import 'package:brill_app/core/network/status.dart';
import 'package:brill_app/features/auth/model/user.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

enum AuthenticationError {
  noInternetConnection,
  invalidEmailOrPassword,
  noServerConnection,
  invalidToken,
  expiredToken,
}

class AuthenticationData {
  final User user;

  AuthenticationData({required this.user});
}

class AuthenticationStatus
    extends Status<AuthenticationData, AuthenticationError> {
  AuthenticationStatus.success(super._data) : super.success();
  AuthenticationStatus.error(super._error) : super.error();

  @override
  String toString() {
    if (isError) {
      return 'AuthenticationError: ${error.name}';
    } else {
      return 'AuthenticationSuccess: ${data.user.toJson()}';
    }
  }
}

enum RegistrationError {
  invalidRegisterData,
  registrationFailed,
  noServerConnection,
}

class RegistrationData {}

class RegistrationStatus extends Status<RegistrationData, RegistrationError> {
  RegistrationStatus.success(super._data) : super.success();
  RegistrationStatus.error(super._error) : super.error();
}

class AuthenticationController {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  AuthenticationData? _authenticationData;

  static const _tokenKey = 'auth_token';

  Future<RegistrationStatus> register({
    required String email,
    required String password,
    required String fullname,
    required String username,
  }) async {
    try {
      if (email.isEmpty ||
          password.isEmpty ||
          fullname.isEmpty ||
          username.isEmpty) {
        return RegistrationStatus.error(RegistrationError.invalidRegisterData);
      }

      // TODO: Chamar a API para criar usuário

      final status = await tryRegister(email, password, fullname, username);

      if (status.isSuccess) {
        return RegistrationStatus.success(RegistrationData());
      } else {
        return RegistrationStatus.error(RegistrationError.noServerConnection);
      }
    } catch (e) {
      return RegistrationStatus.error(RegistrationError.noServerConnection);
    }
  }

  Future<AuthenticationStatus> tryRestoreSession() async {
    try {
      final token = await _secureStorage.read(key: _tokenKey);

      if (token == null) {
        return AuthenticationStatus.error(AuthenticationError.invalidToken);
      }

      if (JwtDecoder.isExpired(token)) {
        await logout();
        return AuthenticationStatus.error(AuthenticationError.expiredToken);
      }

      final decoded = JwtDecoder.decode(token);

      final user = User(
        id: decoded['id'] ?? 0,
        email: decoded['email'] ?? '',
        username: decoded['username'] ?? '',
        fullname: decoded['fullname'] ?? '',
      );

      _authenticationData = AuthenticationData(user: user);

      return AuthenticationStatus.success(_authenticationData!);
    } catch (e) {
      debugPrint(e.toString());
      return AuthenticationStatus.error(AuthenticationError.noServerConnection);
    }
  }

  Future<AuthenticationStatus> login({
    required String email,
    required String password,
  }) async {
    // TODO: Chamar a API aqui
    bool emailAndPasswordValid = true;

    if (email.isEmpty || password.isEmpty) {
      emailAndPasswordValid = false;
    }

    if (!emailAndPasswordValid) {
      return AuthenticationStatus.error(
        AuthenticationError.invalidEmailOrPassword,
      );
    }

    // TODO: Chamar a API aqui
    final token = createToken(email, password);

    if (token == null) {
      return AuthenticationStatus.error(
        AuthenticationError.invalidEmailOrPassword,
      );
    }

    await _secureStorage.write(key: _tokenKey, value: token);

    final decoded = JwtDecoder.decode(token);

    final user = User(
      id: decoded['id'] ?? 0,
      email: decoded['email'] ?? '',
      username: decoded['username'] ?? '',
      fullname: decoded['fullname'] ?? '',
    );

    _authenticationData = AuthenticationData(user: user);

    return AuthenticationStatus.success(_authenticationData);
  }

  String? createToken(String email, String password) {
    return generateFakeToken();
  }

  String generateFakeToken() {
    final jwt = JWT({
      'sub': 'user123',
      'fullname': 'Vitor Henrique Silva de Sá',
      'username': 'LordVtko',
      'email': 'vitorhenriquesilvadesa@gmail.com',
      'iat': DateTime.now().millisecondsSinceEpoch,
      'exp': DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch,
    });

    final token = jwt.sign(SecretKey('very_secret_key'));

    return token;
  }

  Future<void> logout() async {
    _authenticationData = null;
    await _secureStorage.delete(key: _tokenKey);
  }

  AuthenticationData? get currentSession => _authenticationData;
  bool get isLoggedIn => _authenticationData != null;

  Future<RegistrationStatus> tryRegister(
    String email,
    String password,
    String fullname,
    String username,
  ) async {
    // TODO: Chamar a API aqui
    return RegistrationStatus.success(RegistrationData());
  }
}
