import 'package:flutter/material.dart';
import '../services/pref_service.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark = false;

  Future<void> loadTheme() async {
    isDark = await PrefService().getTheme();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    isDark = !isDark;
    await PrefService().saveTheme(isDark);
    notifyListeners();
  }
}
