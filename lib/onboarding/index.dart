import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muuv/config/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:muuv/config/size.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
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
              SizeConfigs.getPercentageWidth(100).toInt().height,
              CustomButton(
                pbottom: 10,
                ptop: 10,
                img: 'assets/icon/passenger1.png',
                text: 'User',
              ),
              SizeConfigs.getPercentageWidth(4).toInt().height,
              CustomButton(
                img: 'assets/icon/driver.png',
                text: 'Driver',
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
          Image.asset(img).paddingOnly(top: ptop!, bottom: pbottom!, left: 7),
        ],
      ),
    )
        .withSize(
            width: SizeConfigs.getPercentageWidth(30),
            height: SizeConfigs.getPercentageWidth(12))
        .cornerRadiusWithClipRRect(50);
  }
}
