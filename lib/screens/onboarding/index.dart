import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/screens/rider/index.dart';
import 'package:muuv/screens/user/index.dart';
import 'package:muuv/widget/button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:muuv/config/size.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  //animation_lmpc1c60.json
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizeConfigs.getPercentageWidth(10).toInt().height,
              Lottie.asset("assets/lottie/animation_lmpc2y4t.json"),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: ColorConfig.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Welcome To",
                      //  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                    TextSpan(
                      text: " MUUV.",
                      style: TextStyle(color: ColorConfig.primary),
                    ),
                  ],
                ),
              ),
              SizeConfigs.getPercentageWidth(5).toInt().height,
              Text(
                "Select who you'd like to continue as.",
                style: TextStyle(
                  color: ColorConfig.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizeConfigs.getPercentageWidth(8).toInt().height,
              CustomButton(
                  pbottom: 10,
                  ptop: 10,
                  img: 'assets/icon/passenger1.png',
                  text: 'User',
                  ontap: () {
                    UserScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  }),
              SizeConfigs.getPercentageWidth(6).toInt().height,
              CustomButton(
                  img: 'assets/icon/driver.png',
                  text: 'Driver',
                  ontap: () {
                    RiderScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  }),
            ],
          ).center(),
        ),
      ),
    );
  }
}
