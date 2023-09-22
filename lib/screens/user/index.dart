import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:muuv/widget/tab.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final screenState = Provider.of<UserScreenProvider>(context);

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: SizeConfigs.getPercentageWidth(0),
            left: SizeConfigs.getPercentageWidth(0),
            right: SizeConfigs.getPercentageWidth(0),
            child: Container(
                //   decoration: BoxDecoration(color: Colors.red),
                height: SizeConfigs.getPercentageWidth(40),
                child: Lottie.asset(
                  "assets/lottie/animation_lmnnodqr.json",
                )
                //width: 1,
                )),
        Positioned(
          top: SizeConfigs.getPercentageWidth(38),
          // left: SizeConfigs.getPercentageWidth(9),
          // right: SizeConfigs.getPercentageWidth(9),
          child: Container(
            padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
            decoration: BoxDecoration(color: ColorConfig.white),
            child: Column(children: [
              SizeConfigs.getPercentageWidth(2).toInt().height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTabBar(
                    text: 'LOGIN',
                    color: screenState.hasClickedLogin
                        ? ColorConfig.primary
                        : ColorConfig.primary.withOpacity(0.3),
                    tcolor: screenState.hasClickedLogin
                        ? ColorConfig.secondary
                        : ColorConfig.secondary.withOpacity(0.3),
                  ).onTap(() {
                    screenState.sethasClickedLogin(true);
                    screenState.sethasClickedSignup(false);
                  }),
                  CustomTabBar(
                    text: 'SIGNUP',
                    color: screenState.hasClickedSignup
                        ? ColorConfig.primary
                        : ColorConfig.primary.withOpacity(0.3),
                    tcolor: screenState.hasClickedSignup
                        ? ColorConfig.secondary
                        : ColorConfig.secondary.withOpacity(0.3),
                  ).onTap(() {
                    screenState.sethasClickedLogin(false);
                    screenState.sethasClickedSignup(true);
                  })
                ],
              )
            ]),
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
