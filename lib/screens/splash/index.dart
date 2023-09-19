import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/onboarding/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void flagSwitch() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        /*------------------------------------------------
        Here we'll navigate been on authentication status
        -------------------------------------------------*/
        return const OnboardingScreen();
      }), (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    flagSwitch();
    return Scaffold(
      backgroundColor: ColorConfig.splash,
      body:
          Center(child: Lottie.asset("assets/lottie/animation_lmnnrah8.json")),
    );
  }
}
