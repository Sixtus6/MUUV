import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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

    var loginWidget = [
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
          screenState.setPasswordVisible(!screenState.isPasswordVisible);
        },
      ),

      Row(
        children: [
          Checkbox(
              activeColor: ColorConfig.primary,
              checkColor: ColorConfig.scaffold,
              value: screenState.rememberMe,
              side: BorderSide(color: ColorConfig.primary, width: 1),
              onChanged: (value) {
                screenState.setRememberMe(!screenState.rememberMe);
              }),
          Text("Remember Me",
              style: TextStyle(color: ColorConfig.secondary, fontSize: 13)),
          Expanded(child: Container()),
          Text("Forgot Password?",
              style: TextStyle(color: ColorConfig.primary, fontSize: 13))
        ],
      )
      //    CustomTextField(
      //   icon: Icons.mail,
      //   isEmail: true,
      //   text: 'Email',
      // ),
    ];

    var signinWidget = [
      CustomTextField(
        icon: Icons.person,
        isEmail: false,
        text: 'Name',
      ),
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
          screenState.setPasswordVisible(!screenState.isPasswordVisible);
        },
      ),
      CustomTextField(
        icon: Icons.phone,
        isEmail: false,
        text: 'Phone',
      ),
    ];
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: SizeConfigs.getPercentageWidth(0),
                left: SizeConfigs.getPercentageWidth(0),
                right: SizeConfigs.getPercentageWidth(0),
                child: Container(
                    //   decoration: BoxDecoration(color: Colors.red),
                    height: SizeConfigs.getPercentageWidth(63),
                    child: Lottie.asset(
                      "assets/lottie/animation_lmnnodqr.json",
                    )
                    //width: 1,
                    //  Lottie.asset(

                    //   "assets/lottie/animation_lmu4pcj2.json",
                    // )
                    )),
            Positioned(
              top: screenState.hasClickedLogin
                  ? SizeConfigs.getPercentageWidth(60)
                  : SizeConfigs.getPercentageWidth(60),
              // left: SizeConfigs.getPercentageWidth(9),
              // right: SizeConfigs.getPercentageWidth(9),
              child: Container(
                padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
                decoration: BoxDecoration(color: ColorConfig.white),
                child: SingleChildScrollView(
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
                      margin: EdgeInsets.only(
                          top: SizeConfigs.getPercentageWidth(6)),
                      child: Column(
                          children: screenState.hasClickedLogin
                              ? loginWidget
                              : signinWidget),
                    )
                  ]),
                ),
              )
                  .withSize(
                      width: SizeConfigs.getPercentageWidth(85),
                      height: screenState.hasClickedLogin
                          ? SizeConfigs.getPercentageWidth(75)
                          : SizeConfigs.getPercentageWidth(95))
                  .cornerRadiusWithClipRRect(15),
            ),
            Positioned(
              top: screenState.hasClickedLogin
                  ? SizeConfigs.getPercentageWidth(122)
                  : SizeConfigs.getPercentageWidth(140),
              // right: 0,
              // left: 0,white
              child: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: ColorConfig.white,
                    ),
                    padding: EdgeInsets.all(9),
                    child: Container(
                        padding: EdgeInsets.all(11),
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors
                                  .white, // Adjust icon color to match the background
                              size: 31.0,
                            ),
                          ),
                          // width: 50.0,
                          // height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConfig.primary,
                            // Background color
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300, // Top shadow color
                                offset: Offset(-4, -4),
                                blurRadius: 8.0,
                                spreadRadius: 1.0,
                              ),
                              BoxShadow(
                                color:
                                    Colors.grey.shade100, // Bottom shadow color
                                offset: Offset(4, 4),
                                blurRadius: 8.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                        ),
                        // child: Lottie.asset(
                        //   "assets/lottie/animation_lmu4pcj2.json",
                        // ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: ColorConfig.scaffold,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-28, -28),
                              blurRadius: 30,
                              color: ColorConfig.white,
                              inset: true,
                            ),
                            BoxShadow(
                              offset: Offset(28, 28),
                              blurRadius: 50,
                              color: ColorConfig.scaffold,
                              // inset: true,
                            ),
                          ],
                        ))).withSize(
                  height: SizeConfigs.getPercentageWidth(23),
                  width: SizeConfigs.getPercentageWidth(23),
                ),
              ),
            )
          ],
        ));
  }
}
