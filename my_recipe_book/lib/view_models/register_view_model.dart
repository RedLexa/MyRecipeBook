import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final ApiService apiService;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  RegisterViewModel(this.apiService);

  Future<bool> register(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
    try {
      final response = await apiService.post('/users/create', data: {
        'username': username.trim(),
        'password': password.trim(),
      });
      _isLoading = false;
      if (response != null && response['success'] == true) {
        _successMessage = response['message'] ?? 'You have registered successfully.';
        notifyListeners();
        return true;
      } else {
        _errorMessage = response != null && response['error'] != null
            ? response['error']['message'] ?? response['message'] ?? 'Registration failed'
            : response['message'] ?? 'Registration failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
