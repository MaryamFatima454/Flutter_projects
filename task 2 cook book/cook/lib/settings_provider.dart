import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _darkMode = false;
  String _languageCode = "en";
  bool compactMode = false;
  String defaultCategory = "All";

  void toggleCompactMode(bool val) {
    compactMode = val;
    notifyListeners();
  }

  void changeDefaultCategory(String val) {
    defaultCategory = val;
    notifyListeners();
  }

  bool get darkMode => _darkMode;
  String get languageCode => _languageCode;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void changeLanguage(String code) {
    _languageCode = code;
    notifyListeners();
  }
}
