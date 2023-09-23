import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: color,
                // Background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, // Top shadow color
                    offset: const Offset(-4, -4),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Colors.grey.shade100, // Bottom shadow color
                    offset: const Offset(4, 4),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_circle_right_sharp,
                  color:
                      Colors.white, // Adjust icon color to match the background
                  size: 31.0,
                ),
              ),
            ))).withSize(
      height: SizeConfigs.getPercentageWidth(23),
      width: SizeConfigs.getPercentageWidth(23),
    );
  }
}
