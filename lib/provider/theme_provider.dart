import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeMode();
  }
void _loadThemeMode() async {
    notifyListeners();
    final box = await Hive.openBox('Settings');
    final themeIndex =
        box.get('themeMode', defaultValue: ThemeMode.system.index);
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  void setTheme(ThemeMode themeMode) async {
    final box = await Hive.openBox('Settings');
    _themeMode = themeMode;
    box.put('themeMode', themeMode.index);

    notifyListeners();
  }

  
