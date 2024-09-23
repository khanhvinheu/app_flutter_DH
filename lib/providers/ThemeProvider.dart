import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Biến để lưu trữ trạng thái ThemeMode
  // ThemeMode _themeMode = ThemeMode.system;
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;  
    notifyListeners();
  }
}
