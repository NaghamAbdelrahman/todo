import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;
  String currentLanguage = 'en';

  void changeTheme(ThemeMode newMode) async {
    currentTheme = newMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'theme', currentTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  bool lightMood() {
    return currentTheme == ThemeMode.light;
  }

  void changeLanguage(String newLanguage) async {
    currentLanguage = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('language', currentLanguage);
    notifyListeners();
  }
}
