import 'package:flutter/material.dart';

class SizeConfigs {
  static late MediaQueryData _mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
  }

  static double getPercentageHeight(int percentage) {
    return SizeConfigs.screenHeight * percentage * 0.01;
  }

  static double getPercentageWidth(int percentage) {
    return SizeConfigs.screenWidth * percentage * 0.01;
  }
}
