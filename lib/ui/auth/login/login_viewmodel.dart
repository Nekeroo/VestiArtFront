import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/networking/models/network_exceptions.dart';

class LoginViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _usernameError;
  String? _passwordError;
  NetworkException? networkException;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
  String? get usernameError => _usernameError;
  String? get passwordError => _passwordError;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre nom d\'utilisateur';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre mot de passe';
    }

    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }

    return null;
  }

  Future<bool> login() async {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    setLoading(true);

    try {
      await AuthenticationService.instance.login(
        usernameController.text,
        passwordController.text,
      );
      setLoading(false);
      return true;
    } on DioException catch (e) {
      networkException = e.error as NetworkException;
      setLoading(false);
      return false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
