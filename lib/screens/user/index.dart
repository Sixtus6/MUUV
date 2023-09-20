import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: SizeConfigs.getPercentageWidth(0),
            left: SizeConfigs.getPercentageWidth(0),
            right: SizeConfigs.getPercentageWidth(0),
            child: Container(
                //  decoration: BoxDecoration(color: Colors.red),
                height: SizeConfigs.getPercentageWidth(40),
                // width: 100,
                child: Lottie.asset(
                  "assets/lottie/animation_lmnnuyie.json",
                ))),
        Positioned(
          top: SizeConfigs.getPercentageWidth(35),
          // left: SizeConfigs.getPercentageWidth(9),
          // right: SizeConfigs.getPercentageWidth(9),
          child: Container(
            padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
            child: Column(children: [
              SizeConfigs.getPercentageWidth(2).toInt().height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTabBar(
                    text: 'LOGIN',
                    color: ColorConfig.primary,
                  ),
                  CustomTabBar(
                    text: 'SIGNUP',
                    color: ColorConfig.primary.withOpacity(0.3),
                  )
                ],
              )
            ]),
            decoration: BoxDecoration(color: ColorConfig.white),
          )
              .withSize(
                  width: SizeConfigs.getPercentageWidth(85),
                  height: SizeConfigs.getPercentageWidth(100))
              .cornerRadiusWithClipRRect(15),
        )
      ],
    ));
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.text,
    this.color = const Color(0xFF8572e8),
  });
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConfig.secondary,
              fontSize: 15),
        ),
        Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
          margin: EdgeInsets.only(top: SizeConfigs.getPercentageWidth(1)),
          height: SizeConfigs.getPercentageWidth(1),
          width: SizeConfigs.getPercentageWidth(12),
        )
      ],
    );
  }
}
