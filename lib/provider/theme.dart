import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muuv/config/color.dart';

class ThemeClass {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static ThemeData mainTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: ColorConfig.scaffold,
    secondaryHeaderColor: Colors.white,
    //primaryColor: Colors.lightBlue[800],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black.withOpacity(0.5)),
      headline6: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
