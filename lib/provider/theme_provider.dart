// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeProvider(this._themeData);

  ThemeData get getTheme => _themeData;

  void setDarkMode() {
    _themeData = ThemeData.dark();
    notifyListeners();
  }

  void setLightMode() {
    _themeData = ThemeData.light();
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = (_themeData.brightness == Brightness.dark)
        ? ThemeData.light()
        : ThemeData.light();
    notifyListeners();
  }
}
