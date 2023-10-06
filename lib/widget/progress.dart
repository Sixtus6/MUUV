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
      // child: Container(
      //   margin: EdgeInsets.all(16.0),
      //   decoration: BoxDecoration(
      //       color: ColorConfig.white, borderRadius: BorderRadius.circular(6)),
      //   child: Row(children: [
      //     SizeConfigs.getPercentageWidth(3).toInt().width,
      //     CircularProgressIndicator(
      //       valueColor: AlwaysStoppedAnimation<Color>(ColorConfig.green),
      //     ),
      //     SizeConfigs.getPercentageWidth(20).toInt().width,
      //     Text(
      //       message!,
      //       style: TextStyle(color: ColorConfig.secondary, fontSize: 12),
      //     )
      //   ]),
      // ),
    );
  }
}
