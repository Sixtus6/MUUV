import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class ProgressDialog extends StatelessWidget {
  String? message;

  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Lottie.asset(
            "assets/lottie/loader1.json",
          ),
        ),
      ),

    );
  }
}
