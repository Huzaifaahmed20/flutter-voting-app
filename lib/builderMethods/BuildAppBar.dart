import 'package:flutter/material.dart';
import 'package:day_night_switch/day_night_switch.dart';

import '../models/ThemeModel.dart';

AppBar appBarWithThemeChanger(ThemeChanger theme, String title) {
  return AppBar(
    actions: <Widget>[
      Container(
        child: Transform.scale(
          scale: 0.3,
          child: DayNightSwitch(
            value: theme.isDarkMode,
            onChanged: (value) {
              value
                  ? theme.setTheme(ThemeData(
                      fontFamily: 'CabinRegular', brightness: Brightness.dark))
                  : theme.setTheme(ThemeData(
                      fontFamily: 'CabinRegular',
                      brightness: Brightness.light));
            },
          ),
        ),
      )
    ],
    centerTitle: true,
    title: Text(
      '$title',
    ),
  );
}
