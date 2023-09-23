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
        isEmail: false,
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
        isphone: true,
        text: 'Phone',
        isEmail: false,
      ),
      CustomTextField(
        icon: Icons.home,
        //isphone: true,
        text: 'Address',
        isEmail: false,
      ),
    ];

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                      //  decoration: BoxDecoration(color: Colors.red),
                      height: SizeConfigs.getPercentageWidth(50),
                      child: Lottie.asset("assets/lottie/new4.json")

                      //width: 1,
                      //  Lottie.asset(

                      //   "assets/lottie/animation_lmu4pcj2.json",
                      // )
                      ),
                ),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container().withHeight(screenState.hasClickedLogin
                        ? SizeConfigs.getPercentageHeight(45)
                        : SizeConfigs.getPercentageHeight(60)),
                    //  .withWidth(SizeConfigs.getPercentageWidth(100)),
                    Container(
                      // alignment: Alignment.center,
                      padding:
                          EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
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
                          margin: EdgeInsets.only(
                              top: SizeConfigs.getPercentageWidth(6)),
                          child: Column(
                              children: screenState.hasClickedLogin
                                  ? loginWidget
                                  : signinWidget),
                        )
                      ]),
                    )
                        .withSize(
                            width: SizeConfigs.getPercentageWidth(85),
                            height: screenState.hasClickedLogin
                                ? SizeConfigs.getPercentageWidth(77)
                                : SizeConfigs.getPercentageWidth(110))
                        .cornerRadiusWithClipRRect(15),
                    Positioned(
                      top: screenState.hasClickedLogin
                          ? SizeConfigs.getPercentageWidth(75)
                          : SizeConfigs.getPercentageWidth(108),
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
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConfig.primary,
                                    // Background color
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors
                                            .grey.shade300, // Top shadow color
                                        offset: const Offset(-4, -4),
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ),
                                      BoxShadow(
                                        color: Colors.grey
                                            .shade100, // Bottom shadow color
                                        offset: const Offset(4, 4),
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors
                                          .white, // Adjust icon color to match the background
                                      size: 31.0,
                                    ),
                                  ),
                                ))).withSize(
                          height: SizeConfigs.getPercentageWidth(23),
                          width: SizeConfigs.getPercentageWidth(23),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
