import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', ''); // Mặc định là tiếng Anh

  Locale get locale => _locale;

  List<Locale> get supportedLocales => const [
    Locale('en', ''), // Tiếng Anh
    Locale('vi', ''), // Tiếng Việt
  ];

  // Phương thức để thay đổi ngôn ngữ
  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  // Đặt lại ngôn ngữ về mặc định
  void clearLocale() {
    _locale = const Locale('en', '');
    notifyListeners();
  }
}
