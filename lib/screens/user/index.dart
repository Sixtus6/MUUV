import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/controllers/user/auth.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:muuv/widget/arrow.dart';
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
    final userState = Provider.of<UserAuthProvider>(context);
    final userInstance = userState.user;
/* ----------------------------------- KEY ---------------------------------- */
    final loginFormKey = GlobalKey<FormState>();
    final signuPFormKey = GlobalKey<FormState>();
    /* ----------------------------- TextController ----------------------------- */
    TextEditingController loginEmailController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();

    var loginWidget = [
      CustomTextField(
        icon: Icons.mail,
        isEmail: true,
        text: 'Email',
        controller: loginPasswordController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Email filed cant be empty';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.lock,
        isEmail: true,
        obscure: screenState.isPasswordVisible,
        text: 'Password',
        enableSuffixIcon: true,
        visible: screenState.isPasswordVisible,
        controller: loginPasswordController,
        validator: (p0) {},
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
                        ? SizeConfigs.getPercentageHeight(48)
                        : SizeConfigs.getPercentageHeight(63)),
                    //  .withWidth(SizeConfigs.getPercentageWidth(100)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizeConfigs.getPercentageWidth(11).toInt().width,
                            // 18.width,
                            Text(
                              screenState.hasClickedLogin
                                  ? "Welcome Back"
                                  : "Create an account and enjoy your ride",
                              style: TextStyle(
                                  color: ColorConfig.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizeConfigs.getPercentageWidth(1).toInt().width,

                            screenState.hasClickedLogin
                                ? Container(
                                    height: 25,
                                    width: 25,
                                    // padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/icon/passenger1.png",
                                      color: ColorConfig.primary,
                                    ),
                                  )
                                : Icon(
                                    Icons.location_on,
                                    color: ColorConfig.primary,
                                  )
                            // Text(
                            //   screenState.hasClickedLogin
                            //       ? "Welcome Back"
                            //       : "Create an account and enjoy your ride",
                            //   style: TextStyle(
                            //       color: ColorConfig.secondary,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold),
                            // )
                          ],
                        ),
                        SizeConfigs.getPercentageWidth(2).toInt().height,
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
                              child: Form(
                                key: screenState.hasClickedLogin
                                    ? loginFormKey
                                    : signuPFormKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                    children: screenState.hasClickedLogin
                                        ? loginWidget
                                        : signinWidget),
                              ),
                            )
                          ]),
                        )
                            .withSize(
                                width: SizeConfigs.getPercentageWidth(85),
                                height: screenState.hasClickedLogin
                                    ? SizeConfigs.getPercentageWidth(77)
                                    : SizeConfigs.getPercentageWidth(110))
                            .cornerRadiusWithClipRRect(15),
                      ],
                    ),
                    Positioned(
                      top: screenState.hasClickedLogin
                          ? SizeConfigs.getPercentageWidth(82)
                          : SizeConfigs.getPercentageWidth(114),
                      // right: 0,
                      // left: 0,white
                      child: SingleChildScrollView(
                        child: ArrowButton(
                          color: ColorConfig.primary,
                        ).onTap(() {
                          if (screenState.hasClickedLogin) {
                            final isformValid =
                                loginFormKey.currentState!.validate();

                            print(isformValid);
                          }

                          print("object");
                          // userState.signUpWithEmailAndPassword(
                          //     'testy@example.com',
                          //     'password',
                          //     'John Doe',
                          //     'No 4 utange lane',
                          //     '+1234567890');
                        }),
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
