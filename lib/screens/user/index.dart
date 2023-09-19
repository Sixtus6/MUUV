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
                )))
      ],
    ));
  }
}
