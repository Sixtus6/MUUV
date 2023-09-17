import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



TextStyle titleStyle(BuildContext context, bool bold,
    {double size = 25.0, Color color = Colors.white}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: color);
}

TextStyle coloredTitleStyle(BuildContext context, bool bold,
    {double size = 25.0}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: Colors.white
      // color: Color.fromARGB(31, 255, 0, 0)
      );
}

TextStyle darkPrimaryStyle(BuildContext context, double size, bool bold,
    {double opacity = 1.0}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      color: themeData.primaryColorDark.withOpacity(opacity),
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

TextStyle lightPrimaryStyle(BuildContext context, double size, bool bold,
    {double opacity = 1.0}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      color: Colors.grey.withOpacity(opacity),
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

SystemUiOverlayStyle customOverlay(ThemeData themedata) {
  return SystemUiOverlayStyle(
      statusBarColor: themedata.scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark);
}

SystemUiOverlayStyle customColoredOverlay(Color color) {
  return SystemUiOverlayStyle(
      statusBarColor: color, statusBarIconBrightness: Brightness.dark);
}
