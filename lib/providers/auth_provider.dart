import 'package:c_tax/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier
 {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  String _errorMessage = '';

  bool get isAuthenticated => _isAuthenticated;
  String get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    String result = await _authService.login(username, password);

    if (result == 'success') {
      _isAuthenticated = true;
      _errorMessage = '';
    } else {
      _isAuthenticated = false;
      _errorMessage = result;
    }
    notifyListeners();
  }
}
