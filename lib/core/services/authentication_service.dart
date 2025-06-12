import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService extends ChangeNotifier {
  static const storageKeyToken = "auth_token";

  User? _currentUser;
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String username, String password) async {
    return true;
  }

  Future<bool> register(String username, String password) async {
    return true;
  }

  Future<void> logout() async {}
  Future<bool> checkAuthStatus() async {
    return _currentUser != null;
  }

  bool canAccess(PermissionLevel requiredLevel) {
    return _currentUser == null
        ? false
        : _currentUser!.permissionLevel.index >= requiredLevel.index;
  }

  Future<void> _saveToken(String token) async {
    await storage.write(key: storageKeyToken, value: token);
  }

  Future<String?> _getToken() async {
    return await storage.read(key: storageKeyToken);
  }

  Future<void> _clearToken() async {
    await storage.delete(key: storageKeyToken);
  }
}
