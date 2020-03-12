import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ThemeChanger extends Model {
  ThemeData _themeData;

  bool isDarkMode = false;
  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    isDarkMode = !isDarkMode;
    _themeData = theme;
    notifyListeners();
  }
}
