import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/controllers/user/auth.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/screens/home/user/index.dart';
import 'package:muuv/screens/onboarding/index.dart';
import 'package:muuv/utils/helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void flagSwitch(context) {
    Timer(const Duration(seconds: 4), () {
      String user = getStringAsync("user");
      String rider = getStringAsync("rider");
      if (!user.isEmptyOrNull) {
        UserHomePage().launch(context,
            pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
      } else if (!rider.isEmptyOrNull) {
        print("rider screen");
      } else {
        OnboardingScreen().launch(context,
            pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    flagSwitch(context);
    return Scaffold(
      backgroundColor: ColorConfig.splash,
      body:
          Center(child: Lottie.asset("assets/lottie/animation_lmnnrah8.json")),
    );
  }
}
