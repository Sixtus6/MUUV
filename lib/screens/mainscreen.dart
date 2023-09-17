import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/splash/index.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const SplashScreen();
  }
}
