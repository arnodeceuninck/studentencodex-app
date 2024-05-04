import 'package:flutter/material.dart';
import 'theme_preference.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false; // will be overwritten by getPreferences (theme_preference.dart contains the default value)
    _preferences = ThemePreferences();
    getPreferences();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}