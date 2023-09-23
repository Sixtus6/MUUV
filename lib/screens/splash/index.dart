import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/onboarding/index.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void flagSwitch() {
    Timer(const Duration(seconds: 4), () {
      OnboardingScreen().launch(context,
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    flagSwitch();
    return Scaffold(
      backgroundColor: ColorConfig.splash,
      body: Center(child: Lottie.asset("assets/lottie/splash.json")),
    );
  }
}
