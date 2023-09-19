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
                    UserScreen().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  }),
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
    required this.ontap,
  });
  final String img;
  final String text;
  final double? ptop;
  final double? pbottom;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () {
            ontap();
          },
          child: Ink(
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
          ).withSize(
              width: SizeConfigs.getPercentageWidth(30),
              height: SizeConfigs.getPercentageWidth(12))),
    ).cornerRadiusWithClipRRect(70);
  }
}
