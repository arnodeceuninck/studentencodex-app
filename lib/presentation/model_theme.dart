import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'theme_preference.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _preferences;
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark =
        false; // will be overwritten by getPreferences (theme_preference.dart contains the default value)
    _preferences = ThemePreferences();
    getPreferences();
  }

  String getTheme() => _preferences.getTheme();

//Switching the themes
  set theme(String theme) {
    print("Theme: $theme");
    _preferences.setTheme(theme);
    _isDark = isDarkTheme(theme);
    notifyListeners();
  }

  bool isDarkTheme(String theme) {
    if (theme == "System") {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    } else if (theme == "Dark") {
      return true;
    } else {
      return false;
    }
  }

  getPreferences() async {
    String theme = await _preferences.getTheme();
    print("Theme: $theme");
    _isDark = isDarkTheme(theme);
    // notifyListeners();
  }
}
