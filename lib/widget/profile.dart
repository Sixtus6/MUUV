import 'package:flutter/material.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer(
      {required this.image,
      required this.data,
      required this.title,
      this.carColor,
      this.carModel,
      this.carPlate});
  final String image;
  final String data;
  final String title;
  final String? carColor;
  final String? carPlate;
  final String? carModel;

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
              child: widget.data != ""
                  ? Image.asset(
                      widget.image,
                      color: ColorConfig.primary,
                    )
                  : Icon(
                      Icons.directions_car,
                      color: ColorConfig.primary,
                      size: 33,
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
                widget.data != ''
                    ? Text(
                        widget.data,
                        style: TextStyle(
                          color: ColorConfig.secondary,
                          fontSize: 13,
                        ),
                      )
                    : RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: ColorConfig.primary,
                            fontSize: 13,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "color: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //  color: ColorConfig.secondary,
                                // color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            TextSpan(
                              text: widget.carColor!,
                              style: TextStyle(color: ColorConfig.secondary),
                            ),
                            TextSpan(
                              text: " plate.no: ",
                              style: TextStyle(
                                color: ColorConfig.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.carPlate!,
                              style: TextStyle(color: ColorConfig.secondary),
                            ),
                            TextSpan(
                              text: " model: ",
                              style: TextStyle(
                                color: ColorConfig.primary,
                                fontWeight: FontWeight.bold,
                                // color: Colors.black.withOpacity(
                                //   0.6,
                                // ),
                              ),
                            ),
                            TextSpan(
                              text: widget.carModel!.length.toString().length <
                                      7
                                  ? "${widget.carModel!.substring(0, 7)}....."
                                  : widget.carModel!,
                              style: TextStyle(
                                // overflow: TextOverflow.ellipsis,
                                color: ColorConfig.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                SizeConfigs.getPercentageWidth(2).toInt().height,
              ],
            )
          ],
        ));
  }
}
