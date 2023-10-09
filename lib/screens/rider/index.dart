import 'package:email_validator/email_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/rider/provider.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:muuv/widget/arrow.dart';
import 'package:muuv/widget/constant.dart';
import 'package:muuv/widget/tab.dart';
import 'package:muuv/widget/textfield.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({super.key});

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  @override
  Widget build(BuildContext context) {
    final screenState = Provider.of<RiderScreenProvider>(context);
    /* ----------------------------------- KEY ---------------------------------- */
    final loginFormKey = GlobalKey<FormState>();
    final signupFormKey = GlobalKey<FormState>();
    /* ----------------------------- TextController ----------------------------- */

    var loginWidget = [
      CustomTextField(
        icon: Icons.mail,
        isEmail: true,
        text: 'Email',
        myController: driverLoginEmailController,
        validator: (value) {
          if (value!.isEmpty || !EmailValidator.validate(value)) {
            return 'Enter a valid email ';
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
        onTap: () {
          screenState.setPasswordVisible(!screenState.isPasswordVisible);
        },
        myController: driverLoginPasswordController,
        validator: (value) {
          if (value!.isEmpty || value.length < 8) {
            return 'Minimum password length is 8';
          }
          return null;
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
        myController: driverSignupNameController,
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
        myController: driverSignupEmailController,
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
        onTap: () {
          screenState.setPasswordVisible(!screenState.isPasswordVisible);
        },
        myController: driverSignupPasswordController,
        validator: (value) {
          if (value!.isEmpty || value.length < 8) {
            return 'Minimum password length is 8';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.phone,
        isphone: true,
        text: 'Phone',
        isEmail: false,
        myController: driverSignupPhoneController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.home,
        //isphone: true,
        text: 'Address',
        isEmail: false, myController: driverSignupAddressController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
    ];
    var carWidget = [
      Row(
        children: [
          SizeConfigs.getPercentageWidth(1).toInt().width,
          GestureDetector(
            onTap: () {
              screenState.setFilledSignupForm(false);
            },
            child: Icon(
              Icons.arrow_circle_left_sharp,
              color: ColorConfig
                  .primary, // Adjust icon color to match the background
              size: 25,
            ),
          ),
          SizeConfigs.getPercentageWidth(19).toInt().width,
          Text("Add Car Details",
              style: TextStyle(
                  color: ColorConfig.secondary, fontWeight: FontWeight.bold)),
        ],
      ),
      SizeConfigs.getPercentageWidth(2).toInt().height,
      CustomTextField(
        icon: Icons.car_rental,
        isEmail: false,
        text: 'Model',
        myController: driverModelController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.car_rental,
        isEmail: false,
        text: 'Color',
        myController: driverColorController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
      ),
      CustomTextField(
        icon: Icons.car_rental,
        isEmail: false,
        text: 'Plate Number',
        myController: driverPlateNumberController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field cannot be empty';
          }
          return null;
        },
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
                      child: Lottie.asset(screenState.hasClickedLogin
                              ? "assets/lottie/new5.json"
                              : "assets/lottie/new3.json"
                          //repeat: false
                          )

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
                        : screenState.filledSignupForm
                            ? SizeConfigs.getPercentageHeight(51)
                            : SizeConfigs.getPercentageHeight(63)),
                    //  .withWidth(SizeConfigs.getPercentageWidth(100)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizeConfigs.getPercentageWidth(11).toInt().width,
                            // 18.width,
                            Text(
                              screenState.hasClickedLogin
                                  ? "Welcome Back"
                                  : "Create an account and become a rider",
                              style: TextStyle(
                                  color: ColorConfig.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),

                            SizeConfigs.getPercentageWidth(2).toInt().width,

                            screenState.hasClickedLogin
                                ? Container(
                                    height: 28,
                                    width: 28,
                                    // padding: EdgeInsets.all(10),
                                    child: Image.asset(
                                      "assets/icon/driver.png",
                                      color: ColorConfig.primary,
                                    ),
                                  )
                                : Icon(
                                    Icons.directions_car,
                                    color: ColorConfig.primary,
                                    size: 30,
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
                              Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfigs.getPercentageWidth(6)),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: screenState.hasClickedLogin
                                        ? loginFormKey
                                        : signupFormKey,
                                    child: Column(
                                        children: screenState.hasClickedLogin
                                            ? loginWidget
                                            : screenState.filledSignupForm
                                                ? carWidget
                                                : signinWidget),
                                  ),
                                ),
                              ),
                              SizeConfigs.getPercentageWidth(10).toInt().height,
                            ]),
                          ),
                        )
                            .withSize(
                                width: SizeConfigs.getPercentageWidth(85),
                                height: screenState.hasClickedLogin
                                    ? SizeConfigs.getPercentageWidth(77)
                                    : screenState.filledSignupForm
                                        ? SizeConfigs.getPercentageWidth(90)
                                        : SizeConfigs.getPercentageWidth(110))
                            .cornerRadiusWithClipRRect(15),
                      ],
                    ),
                    Positioned(
                      top: screenState.hasClickedLogin
                          ? SizeConfigs.getPercentageWidth(75)
                          : screenState.filledSignupForm
                              ? SizeConfigs.getPercentageWidth(88)
                              : SizeConfigs.getPercentageWidth(115),
                      // right: 0,
                      // left: 0,white
                      child: SingleChildScrollView(
                          child: ArrowButton(
                        color: ColorConfig.primary,
                      ).onTap(() {
                        if (screenState.hasClickedSignup &&
                            screenState.filledSignupForm) {
                          print("1st blockt");
                        } else if (screenState.hasClickedSignup) {
                          final isformValid =
                              signupFormKey.currentState!.validate();
                          if (isformValid) {
                            screenState.setFilledSignupForm(true);
                          }

                          print("2nd block");
                        } else {}
                        print("else");
                      })),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
