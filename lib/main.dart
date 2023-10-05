import 'package:flutter/material.dart';
import 'package:muuv/controllers/user/auth.dart';
import 'package:muuv/provider/theme.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/screens/mainscreen.dart';
//import 'package:muuv/screens/rider/index.dart';
import 'package:muuv/screens/rider/provider.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//ChangeNotifierProvider<UserScreenStateProvider>(
//     create: (_) => UserScreenStateProvider())import 'provider/userscreen.provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserScreenProvider>(
            create: (_) => UserScreenProvider()),
        ChangeNotifierProvider<RiderScreenProvider>(
            create: (_) => RiderScreenProvider()),
        ChangeNotifierProvider<UserAuthProvider>(
            create: (_) => UserAuthProvider()),
        ChangeNotifierProvider<UserGoogleMapProvider>(
            create: (_) => UserGoogleMapProvider()),
    //    ChangeNotifierProvider<UserRideInfo>(create: (_) => UserRideInfo())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.mainTheme,
      home: MainScreen(),
    );
  }
}



            // Positioned(
            //     top: SizeConfigs.getPercentageWidth(0),
            //     left: SizeConfigs.getPercentageWidth(0),
            //     right: SizeConfigs.getPercentageWidth(0),
            //     child: Container(
            //         //   decoration: BoxDecoration(color: Colors.red),
            //         height: SizeConfigs.getPercentageWidth(63),
            //         child: Lottie.asset(
            //           "assets/lottie/animation_lmnnodqr.json",
            //         )
            //         //width: 1,
            //         //  Lottie.asset(

            //         //   "assets/lottie/animation_lmu4pcj2.json",
            //         // )
            //         )),


// import 'package:lottie/lottie.dart';
// import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
// import 'package:muuv/config/color.dart';
// import 'package:muuv/config/size.dart';
// import 'package:muuv/screens/user/provider.dart';
// import 'package:muuv/widget/tab.dart';
// import 'package:muuv/widget/textfield.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:provider/provider.dart';

// class UserScreen extends StatefulWidget {
//   const UserScreen({super.key});

//   @override
//   State<UserScreen> createState() => _UserScreenState();
// }

// class _UserScreenState extends State<UserScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final screenState = Provider.of<UserScreenProvider>(context);

//     return Scaffold(
//         body: Stack(
//       alignment: Alignment.center,
//       children: [
//         Positioned(
//             top: SizeConfigs.getPercentageWidth(0),
//             left: SizeConfigs.getPercentageWidth(0),
//             right: SizeConfigs.getPercentageWidth(0),
//             child: Container(
//                 //   decoration: BoxDecoration(color: Colors.red),
//                 height: SizeConfigs.getPercentageWidth(40),
//                 child: Lottie.asset(
//                   "assets/lottie/animation_lmnnodqr.json",
//                 )
//                 //width: 1,
//                 //  Lottie.asset(

//                 //   "assets/lottie/animation_lmu4pcj2.json",
//                 // )
//                 )),
//         Positioned(
//           top: screenState.hasClickedLogin
//               ? SizeConfigs.getPercentageWidth(45)
//               : SizeConfigs.getPercentageWidth(38),
//           // left: SizeConfigs.getPercentageWidth(9),
//           // right: SizeConfigs.getPercentageWidth(9),
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
//               decoration: BoxDecoration(color: ColorConfig.white),
//               child: Column(children: [
//                 SizeConfigs.getPercentageWidth(2).toInt().height,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     CustomTabBar(
//                       text: 'LOGIN',
//                       color: screenState.hasClickedLogin
//                           ? ColorConfig.primary
//                           : ColorConfig.primary.withOpacity(0.3),
//                       tcolor: screenState.hasClickedLogin
//                           ? ColorConfig.secondary
//                           : ColorConfig.secondary.withOpacity(0.3),
//                     ).onTap(() {
//                       screenState.sethasClickedLogin(true);
//                       screenState.sethasClickedSignup(false);
//                     }),
//                     CustomTabBar(
//                       text: 'SIGNUP',
//                       color: screenState.hasClickedSignup
//                           ? ColorConfig.primary
//                           : ColorConfig.primary.withOpacity(0.3),
//                       tcolor: screenState.hasClickedSignup
//                           ? ColorConfig.secondary
//                           : ColorConfig.secondary.withOpacity(0.3),
//                     ).onTap(() {
//                       screenState.sethasClickedLogin(false);
//                       screenState.sethasClickedSignup(true);
//                     }),
//                   ],
//                 ),
//                 Container(
//                   margin:
//                       EdgeInsets.only(top: SizeConfigs.getPercentageWidth(6)),
//                   child: Column(children: [
//                     CustomTextField(
//                       icon: Icons.mail,
//                       isEmail: true,
//                       text: 'Email',
//                     ),
//                     CustomTextField(
//                       icon: Icons.lock,
//                       isEmail: true,
//                       obscure: screenState.isPasswordVisible,
//                       text: 'Password',
//                       enableSuffixIcon: true,
//                       visible: screenState.isPasswordVisible,
//                       onTap: () {
//                         screenState
//                             .setPasswordVisible(!screenState.isPasswordVisible);
//                       },
//                     ),

//                     Row(
//                       children: [
//                         Checkbox(
//                             activeColor: ColorConfig.primary,
//                             checkColor: ColorConfig.scaffold,
//                             value: screenState.rememberMe,
//                             side: BorderSide(
//                                 color: ColorConfig.primary, width: 1),
//                             onChanged: (value) {
//                               screenState
//                                   .setRememberMe(!screenState.rememberMe);
//                             }),
//                         Text("Remember Me",
//                             style: TextStyle(
//                                 color: ColorConfig.secondary, fontSize: 13)),
//                         Expanded(child: Container()),
//                         Text("Forgot Password?",
//                             style: TextStyle(
//                                 color: ColorConfig.primary, fontSize: 13))
//                       ],
//                     )
//                     //    CustomTextField(
//                     //   icon: Icons.mail,
//                     //   isEmail: true,
//                     //   text: 'Email',
//                     // ),
//                   ]),
//                 )
//               ]),
//             )
//                 .withSize(
//                     width: SizeConfigs.getPercentageWidth(85),
//                     height: screenState.hasClickedLogin
//                         ? SizeConfigs.getPercentageWidth(75)
//                         : SizeConfigs.getPercentageWidth(100))
//                 .cornerRadiusWithClipRRect(15),
//           ),
//         ),
//         Positioned(
//           top: screenState.hasClickedLogin
//               ? SizeConfigs.getPercentageWidth(105)
//               : SizeConfigs.getPercentageWidth(120),
//           // right: 0,
//           // left: 0,white
//           child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(80),
//                 color: ColorConfig.white,
//               ),
//               padding: EdgeInsets.all(14),
//               child: Container(
//                   decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(80),
//                 color: ColorConfig.scaffold,
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(-28, -28),
//                     blurRadius: 30,
//                     color: ColorConfig.white,
//                     inset: true,
//                   ),
//                   BoxShadow(
//                     offset: Offset(28, 28),
//                     blurRadius: 50,
//                     color: ColorConfig.scaffold,
//                     // inset: true,
//                   ),
//                 ],
//               ))).withSize(
//             height: SizeConfigs.getPercentageWidth(25),
//             width: SizeConfigs.getPercentageWidth(25),
//           ),
//         )
//       ],
//     ));
//   }
// }
