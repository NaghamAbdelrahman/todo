import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeTheme(ThemeMode newMode) {
    currentTheme = newMode;
    notifyListeners();
  }

  bool lightMood() {
    return currentTheme == ThemeMode.light;
  }

  void changeLanguage(String newLanguage) {
    currentLanguage = newLanguage;
    notifyListeners();
  }
}
