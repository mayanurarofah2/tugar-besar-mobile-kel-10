import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class AuthProvider extends ChangeNotifier {
  Map<String, dynamic>? user;
  bool isLoading = false;

  /// REGISTER
  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await APIService().registerUser(name, email, password);

    isLoading = false;
    notifyListeners();

    return result != null;
  }

  /// LOGIN
  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    final result = await APIService().loginUser(email, password);

    isLoading = false;

    if (result != null) {
      user = result;
      await PrefService().saveLogin(email); // ✅ SharedPreferences
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  /// LOGOUT
  Future<void> logout() async {
    await PrefService().logout();
    user = null;
    notifyListeners();
  }

  /// CHECK SESSION (AUTO LOGIN)
  Future<void> checkSession() async {
    final savedEmail = await PrefService().getLogin();
    if (savedEmail != null) {
      user = {"email": savedEmail};
    }
    notifyListeners();
  }
}
