import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:muuv/widget/tab.dart';
import 'package:muuv/widget/textfield.dart';
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
          top: screenState.hasClickedLogin
              ? SizeConfigs.getPercentageWidth(45)
              : SizeConfigs.getPercentageWidth(38),
          // left: SizeConfigs.getPercentageWidth(9),
          // right: SizeConfigs.getPercentageWidth(9),
          child: SingleChildScrollView(
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
                    }),
                  ],
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: SizeConfigs.getPercentageWidth(6)),
                  child: Column(children: [
                    CustomTextField(
                      icon: Icons.mail,
                      isEmail: true,
                      text: 'Email',
                    ),
                    CustomTextField(
                      icon: Icons.lock,
                      isEmail: true,
                      obscure: screenState.isPasswordVisible,
                      text: 'Password',
                      enableSuffixIcon: true,
                      visible: screenState.isPasswordVisible,
                      onTap: () {
                        screenState
                            .setPasswordVisible(!screenState.isPasswordVisible);
                      },
                    ),

                    Row(
                      children: [
                        Checkbox(
                            activeColor: ColorConfig.primary,
                            checkColor: ColorConfig.scaffold,
                            value: screenState.rememberMe,
                            side: BorderSide(
                                color: ColorConfig.primary, width: 1),
                            onChanged: (value) {
                              screenState
                                  .setRememberMe(!screenState.rememberMe);
                            }),
                        Text("Remember Me",
                            style: TextStyle(
                                color: ColorConfig.secondary, fontSize: 13)),
                        Expanded(child: Container()),
                        Text("Forgot Password?",
                            style: TextStyle(
                                color: ColorConfig.primary, fontSize: 13))
                      ],
                    )
                    //    CustomTextField(
                    //   icon: Icons.mail,
                    //   isEmail: true,
                    //   text: 'Email',
                    // ),
                  ]),
                )
              ]),
            )
                .withSize(
                    width: SizeConfigs.getPercentageWidth(85),
                    height: screenState.hasClickedLogin
                        ? SizeConfigs.getPercentageWidth(75)
                        : SizeConfigs.getPercentageWidth(100))
                .cornerRadiusWithClipRRect(15),
          ),
        )
      ],
    ));
  }
}
