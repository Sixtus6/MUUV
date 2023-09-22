import 'package:flutter/material.dart';
import 'package:muuv/provider/theme.dart';
import 'package:muuv/screens/mainscreen.dart';
import 'package:muuv/screens/user/provider.dart';
import 'package:provider/provider.dart';
//ChangeNotifierProvider<UserScreenStateProvider>(
//     create: (_) => UserScreenStateProvider())import 'provider/userscreen.provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserScreenProvider>(
            create: (_) => UserScreenProvider()),
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
      theme: ThemeClass.mainTheme,
      home: MainScreen(),
    );
  }
}

   // ChangeNotifierProvider<UserScreenStateProvider>(
        //     create: (_) => UserScreenStateProvider())
        //    ChangeNotifierProvider<SecondProvider>(create: (_) => SecondProvider()),