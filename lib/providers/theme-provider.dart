import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade800,
        colorScheme: ColorScheme.dark(),
    primaryColor: Colors.white,
    // cardColor: Colors.
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      // colorScheme: ColorScheme.light(),
      // primaryColor: Colors.white
    primarySwatch: Colors.brown
  );
}