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
                  }),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfigs.getPercentageWidth(6)),
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
                  )
                ]),
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

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.icon,
    required this.text,
    this.obscure = false,
    required this.isEmail,
    this.enableSuffixIcon = false,
    this.visible = false,
    this.onTap,
  });
  final IconData icon;
  final String text;
  late bool? obscure;
  final bool isEmail;
  final bool? enableSuffixIcon;
  late bool? visible;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: TextField(
        style: TextStyle(color: ColorConfig.secondary),
        obscureText: obscure!,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        cursorColor: ColorConfig.primary,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorConfig.primary,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              child: Icon(
                enableSuffixIcon!
                    ? !visible!
                        ? Icons.visibility
                        : Icons.visibility_off
                    : null,
                color: ColorConfig.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.secondary.withOpacity(0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(35.0)),
              borderSide: BorderSide(
                color: ColorConfig.secondary.withOpacity(0.4),
              ),
            ),
            contentPadding: EdgeInsets.all(10),
            hintText: text,
            hintStyle: TextStyle(fontSize: 14, color: ColorConfig.secondary)),
      ),
    );
  }
}
