import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vesti_art/networking/api_authentication.dart';
import 'package:vesti_art/networking/api_user.dart';

class AuthenticationService extends ChangeNotifier {
  static final AuthenticationService instance = AuthenticationService();
  static const storageKeyToken = "auth_token";

  Future<void> initialize() async {
    try {
      _token = await storage.read(key: storageKeyToken);
      if (_token != null) {
        final user = await ApiUser.instance.getMe();
        _currentUser = user;
        notifyListeners();
      }
    } catch (e) {
      _hasAuthError = true;
      _clearToken();
      notifyListeners();
    }
  }

  String? _token;
  bool _hasAuthError = false;
  User? _currentUser;
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get hasAuthError => _hasAuthError;
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

  Future<void> _saveToken(String token) async {
    await storage.write(key: storageKeyToken, value: token);
    _token = token;
  }

  Future<void> _clearToken() async {
    await storage.delete(key: storageKeyToken);
    _token = null;
  }
}
