import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer(
      {required this.image, required this.data, required this.title});
  final String image;
  final String data;
  final String title;
  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            //  color: ColorConfig.red,
            borderRadius: const BorderRadius.all(
          Radius.circular(10),
        )),
        //  padding: EdgeInsets.only(left: SizeConfigs.getPercentageWidth(2)),
        // margin: EdgeInsets.only(
        //     left: SizeConfigs.getPercentageWidth(4),
        //     right: SizeConfigs.getPercentageWidth(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //   color: Colors.grey.shade100,
              height: 30,
              width: 30,
              // padding: EdgeInsets.all(10),
              child: Image.asset(
                widget.image,
                color: ColorConfig.primary,
              ),
            ),
            SizeConfigs.getPercentageWidth(3).toInt().width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ColorConfig.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.data,
                  style: TextStyle(
                    color: ColorConfig.secondary,
                    fontSize: 13,
                  ),
                ),
                SizeConfigs.getPercentageWidth(2).toInt().height,
              ],
            )
          ],
        ));
  }
}
