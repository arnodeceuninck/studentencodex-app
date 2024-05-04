import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const THEME_KEY = "theme_is_dark";

  setTheme(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(THEME_KEY) ?? "Light";
  }
}