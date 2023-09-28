import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/controllers/user/auth.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:muuv/widget/arrow.dart';
import 'package:muuv/widget/constant.dart';
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
    final signupFormKey = GlobalKey<FormState>();
    /* ----------------------------- TextController ----------------------------- */

    var loginWidget = [
      CustomTextField(
        icon: Icons.mail,
        isEmail: true,
        text: 'Email', myController: loginEmailController,
        //   controller: loginEmailController,
        validator: (value) {
          if (value!.isEmpty || !EmailValidator.validate(value)) {
            return 'Enter a valid email ';
          }
          return null;
        },
      ),

      CustomTextField(
        myController: loginPasswordController,
        icon: Icons.lock,
        isEmail: false,
        obscure: screenState.isPasswordVisible,
        text: 'Password',
        enableSuffixIcon: true,
        visible: screenState.isPasswordVisible,
        //   controller: loginPasswordController,
        validator: (value) {
          if (value!.isEmpty || value.length < 8) {
            return 'Minimum password length is 8';
          }
          return null;
        },
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
        myController: signupNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.mail,
        isEmail: true,
        text: 'Email',
        myController: signupEmailController,
        validator: (value) {
          if (value!.isEmpty || !EmailValidator.validate(value)) {
            return 'Enter a valid email ';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.lock,
        isEmail: false,
        obscure: screenState.isPasswordVisible,
        text: 'Password',
        enableSuffixIcon: true,
        visible: screenState.isPasswordVisible,
        validator: (value) {
          if (value!.isEmpty || value.length < 8) {
            return 'Minimum password length is 8';
          }
          return null;
        },
        onTap: () {
          screenState.setPasswordVisible(!screenState.isPasswordVisible);
        },
        myController: signupPasswordController,
      ),
      CustomTextField(
        icon: Icons.phone,
        isphone: true,
        text: 'Phone',
        isEmail: false,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
        myController: signupPhoneController,
      ),
      CustomTextField(
        icon: Icons.home,
        //isphone: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
        text: 'Address',
        isEmail: false, myController: signupAddressController,
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
                        ? SizeConfigs.getPercentageHeight(50)
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

                            SizeConfigs.getPercentageWidth(2).toInt().width,

                            screenState.hasClickedLogin
                                ? Container(
                                    height: 45,
                                    width: 45,
                                    // padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/icon/loginuser.png",
                                      color: ColorConfig.primary,
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: 40,
                                    // padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/icon/ride.png",
                                      color: ColorConfig.primary,
                                    ),
                                  ),
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
                          constraints: BoxConstraints.expand(),
                          // alignment: Alignment.center,
                          padding:
                              EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
                          decoration: BoxDecoration(color: ColorConfig.white),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SizeConfigs.getPercentageWidth(2).toInt().height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomTabBar(
                                    text: 'LOGIN',
                                    color: screenState.hasClickedLogin
                                        ? ColorConfig.primary
                                        : ColorConfig.primary.withOpacity(0.3),
                                    tcolor: screenState.hasClickedLogin
                                        ? ColorConfig.secondary
                                        : ColorConfig.secondary
                                            .withOpacity(0.3),
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
                                        : ColorConfig.secondary
                                            .withOpacity(0.3),
                                  ).onTap(() {
                                    screenState.sethasClickedLogin(false);
                                    screenState.sethasClickedSignup(true);
                                  }),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfigs.getPercentageWidth(6)),
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: screenState.hasClickedLogin
                                            ? loginFormKey
                                            : signupFormKey,
                                        child: Column(
                                            children:
                                                screenState.hasClickedLogin
                                                    ? loginWidget
                                                    : signinWidget),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizeConfigs.getPercentageWidth(10).toInt().height,
                            ]),
                          ),
                        )
                            .withSize(
                                width: SizeConfigs.getPercentageWidth(85),
                                height: screenState.hasClickedLogin
                                    ? SizeConfigs.getPercentageWidth(85)
                                    : SizeConfigs.getPercentageWidth(110))
                            .cornerRadiusWithClipRRect(15),
                      ],
                    ),
                    Positioned(
                      top: screenState.hasClickedLogin
                          ? SizeConfigs.getPercentageWidth(86)
                          : SizeConfigs.getPercentageWidth(114),
                      // right: 0,
                      // left: 0,white
                      child: SingleChildScrollView(
                        child: screenState.isLoadingLogin
                            ? ArrowButton(color: ColorConfig.primaryLight)
                                .onTap(() {
                                // screenState.setLoading(false);
                              })
                            : ArrowButton(
                                color: ColorConfig.primary,
                              ).onTap(() async {
                                //toast('Login Successfully');
                                if (screenState.hasClickedLogin) {
                                  final isformValid =
                                      loginFormKey.currentState!.validate();
                                  if (isformValid) {
                                    screenState.setLoading(true);
                                    print([
                                      loginEmailController.text,
                                      loginPasswordController.text
                                    ]);
                                    try {
                                      await userState
                                          .signUpWithEmailAndPassword(
                                              'testy@exampwle.com',
                                              'password',
                                              'John Doe',
                                              'No 4 utange lane',
                                              '+1234567890');
                                    } finally {
                                      screenState.setLoading(false);
                                    }
                                  }

                                  // !isformValid
                                  //     ? screenState.setError(true)
                                  //     : screenState.setError(false);
                                  print(isformValid);
                                } else {
                                  final isformValid =
                                      signupFormKey.currentState!.validate();
                                  if (isformValid) {
                                    screenState.setLoading(true);
                                    try {
                                      await userState
                                          .signUpWithEmailAndPassword(
                                              signupEmailController.text
                                                  .toString(),
                                              signupPasswordController.text
                                                  .toString(),
                                              signupNameController.text
                                                  .toString(),
                                              signupAddressController.text
                                                  .toString(),
                                              signupPhoneController.text
                                                  .toString());
                                    } finally {
                                      screenState.setLoading(false);
                                    }
                                    // print([
                                    //   signupEmailController.text,
                                    //   signupAddressController.text,
                                    //   signupNameController.text,
                                    //   signupPasswordController.text,
                                    //   signupPhoneController.text,
                                    //   signupAddressController.text,
                                    // ]);
                                  }
                                }

                                // var response =
                                //     await userState.signUpWithEmailAndPassword(
                                //         'testy@exampwle.com',
                                //         'password',
                                //         'John Doe',
                                //         'No 4 utange lane',
                                //         '+1234567890');
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
