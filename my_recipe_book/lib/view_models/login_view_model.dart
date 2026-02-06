import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService apiService;
  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LoginViewModel(this.apiService);

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final response = await apiService.post('/users/login', data: {
        'username': username.trim(),
        'password': password.trim(),
      });
      _isLoading = false;
      if (response != null && response['success'] == true) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = (username == 'alice' || username == 'bob')
            ? 'Invalid password.'
            : 'Login failed, only users alice and bob exist.';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = (username == 'alice' || username == 'bob')
          ? 'Invalid password.'
          : 'Login failed, only users alice and bob exist.';
      notifyListeners();
      return false;
    }
  }
}
