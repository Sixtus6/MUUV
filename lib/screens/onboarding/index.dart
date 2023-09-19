import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/screens/rider/index.dart';
import 'package:muuv/screens/user/index.dart';
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
              Text(
                "Select how you'd like to continue with our service.",
                style: TextStyle(
                  color: ColorConfig.secondary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizeConfigs.getPercentageWidth(8).toInt().height,
              GestureDetector(
                onTap: () {
                  const UserScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Scale);
                },
                child: const CustomButton(
                  pbottom: 10,
                  ptop: 10,
                  img: 'assets/icon/passenger1.png',
                  text: 'User',
                ),
              ),
              SizeConfigs.getPercentageWidth(6).toInt().height,
              
              GestureDetector(
                onTap: () {
                  RiderScreen().launch(context,
                      pageRouteAnimation: PageRouteAnimation.Scale);
                },
                child: const CustomButton(
                  img: 'assets/icon/driver.png',
                  text: 'Driver',
                ),
              ),
            ],
          ).center(),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.img,
    required this.text,
    this.ptop = 12,
    this.pbottom = 12,
  });
  final String img;
  final String text;
  final double? ptop;
  final double? pbottom;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorConfig.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: ColorConfig.secondary,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          Image.asset(
            img,
            color: ColorConfig.primary,
          ).paddingOnly(top: ptop!, bottom: pbottom!, left: 7),
        ],
      ),
    )
        .withSize(
            width: SizeConfigs.getPercentageWidth(30),
            height: SizeConfigs.getPercentageWidth(12))
        .cornerRadiusWithClipRRect(50);
  }
}
