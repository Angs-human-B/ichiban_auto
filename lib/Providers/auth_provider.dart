import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/userModel.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final userModel = await _authService.signInWithEmail(email, password);
    if (userModel != null) {
      _user = userModel;
      await _saveUserLocally(userModel);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Login failed. Please check your credentials.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _saveUserLocally(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(userModel.toJson());
    await prefs.setString('user', userModel.toJson());
  }

  Future<void> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      _user = UserModel.fromJson(userJson);
      notifyListeners();
    }
  }

  Future<bool> signUp({required String name, required String phone, required String email, required String password, required String role}) async {
    _isLoading = true;
    notifyListeners();

    _user = await _authService.signUp(
      name: name,
      phone: phone,
      email: email,
      password: password,
      role: role
    );

    _isLoading = false;
    notifyListeners();

    if (_user != null) {
      return true;
    } else {
      _error = 'Failed to sign up. Please try again.';
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _user = null;
    notifyListeners();
  }
}
