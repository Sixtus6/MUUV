import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.img,
      required this.text,
      this.ptop = 12,
      this.pbottom = 12,
      required this.ontap,
      this.w = 30,
      this.h = 12});
  final String img;
  final String text;
  final double? ptop;
  final double? pbottom;
  final int? w;
  final int? h;
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
                      color: img != ""
                          ? ColorConfig.secondary
                          : ColorConfig.primary,
                      fontSize: img != "" ? 17 : 16,
                      fontWeight: FontWeight.bold),
                ),
                img != ""
                    ? Image.asset(
                        img,
                        color: ColorConfig.primary,
                      ).paddingOnly(top: ptop!, bottom: pbottom!, left: 7)
                    : Container(),
              ],
            ),
          ).withSize(
              width: SizeConfigs.getPercentageWidth(w!),
              height: SizeConfigs.getPercentageWidth(h!))),
    ).cornerRadiusWithClipRRect(70);
  }
}
