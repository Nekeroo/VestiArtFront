import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vesti_art/networking/api_authentication.dart';

class AuthenticationService extends ChangeNotifier {
  static final AuthenticationService instance = AuthenticationService();
  static const storageKeyToken = "auth_token";

  User? _currentUser;
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<User> login(String username, String password) async {
    try {
      final user = await ApiAuthentication.instance.login(username, password);
      _currentUser = user;
      await _saveToken(user.token);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> register(String username, String password) async {
    try {
      final user = await ApiAuthentication.instance.register(
        username,
        password,
      );
      _currentUser = user;
      await _saveToken(user.token);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    await _clearToken();
  }

  Future<bool> checkAuthStatus() async {
    return _currentUser != null;
  }

  bool canAccess(PermissionLevel requiredLevel) {
    return _currentUser == null
        ? false
        : _currentUser!.role.index >= requiredLevel.index;
  }

  Future<void> _saveToken(String token) async {
    await storage.write(key: storageKeyToken, value: token);
  }

  Future<void> _clearToken() async {
    await storage.delete(key: storageKeyToken);
  }
}
