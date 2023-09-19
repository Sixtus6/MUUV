import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.img,
    required this.text,
    this.ptop = 12,
    this.pbottom = 12,
    required this.ontap,
  });
  final String img;
  final String text;
  final double? ptop;
  final double? pbottom;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
          onTap: () {
            ontap();
          },
          child: Ink(
            decoration: BoxDecoration(color: ColorConfig.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: ColorConfig.secondary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  img,
                  color: ColorConfig.primary,
                ).paddingOnly(top: ptop!, bottom: pbottom!, left: 7),
              ],
            ),
          ).withSize(
              width: SizeConfigs.getPercentageWidth(30),
              height: SizeConfigs.getPercentageWidth(12))),
    ).cornerRadiusWithClipRRect(70);
  }
}
