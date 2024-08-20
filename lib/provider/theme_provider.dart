import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }

  void setTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
  }

  void _loadThemeMode() async {
    notifyListeners();
  }
}
