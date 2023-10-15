import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/model/userRequestRideInfo.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/widget/customModal.dart';
import 'package:muuv/widget/shimmer%20button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NotificationDialogBox extends StatefulWidget {
  NotificationDialogBox({this.userRideDetails, required this.provider});
  RiderGoogleMapProvider provider;
  UserRequestRideInfo? userRideDetails;
  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<RiderGoogleMapProvider>(context, listen: false);
    return Dialog(
      // shape: RoundedRectangleBorder(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.only(
              top: SizeConfigs.getPercentageWidth(38),
              bottom: SizeConfigs.getPercentageWidth(47)),
          child: Container(
            ///width: 1,
            decoration: BoxDecoration(
              color: ColorConfig.scaffold,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(4)),
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                ).withSize(
                    height: SizeConfigs.getPercentageWidth(40),
                    width: double.infinity),
                SizeConfigs.getPercentageWidth(2).toInt().height,
                Text("New Ride Request",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConfig.secondary,
                    )),
                SizeConfigs.getPercentageWidth(5).toInt().height,
                Divider(
                  height: SizeConfigs.getPercentageWidth(1),
                  thickness: 2,
                  color: ColorConfig.primary,
                ),
                SizeConfigs.getPercentageWidth(5).toInt().height,
                CustomModalContainer(
                    image: "assets/icon/fromloc.png",
                    address: widget.userRideDetails!.originAddress!.length > 35
                        ? "${widget.userRideDetails!.originAddress!.substring(0, 35)}...."
                        : widget.userRideDetails!.originAddress.toString(),
                    header: "From"),
                SizeConfigs.getPercentageWidth(3).toInt().height,
                CustomModalContainer(
                    image: "assets/icon/toloc.png",
                    address: widget
                                .userRideDetails!.destinationAddress!.length >
                            35
                        ? "${widget.userRideDetails!.destinationAddress!.substring(0, 35)}...."
                        : widget.userRideDetails!.destinationAddress.toString(),
                    header: "To"),
                SizeConfigs.getPercentageWidth(5).toInt().height,
                Divider(
                  height: SizeConfigs.getPercentageWidth(1),
                  thickness: 2,
                  color: ColorConfig.primary,
                ),
                SizeConfigs.getPercentageWidth(5).toInt().height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () {},
                      child: Text(
                        "Decline",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green)),
                      onPressed: () {},
                      child: Text(
                        "Accept",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: SizeConfigs.getPercentageWidth(90),
          child: Padding(
            padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(10)),
            child: Lottie.asset(
              "assets/lottie/car2.json",
            ),
          ),
        ),
      ]),
    );
  }

  Container oldcontainer(
      RiderGoogleMapProvider provider, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: ColorConfig.white),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Image.asset("assets/icon/driver.png"),
        SizedBox(
          height: 10,
        ),
        Text("New Ride Request",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
        SizedBox(
          height: 80,
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: ColorConfig.primary,
        ),
        Row(
          children: [
            Image.asset(
              "assets/icon/driver.png",
              width: 30,
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.userRideDetails!.originAddress!,
              style: TextStyle(color: ColorConfig.secondary),
            ),
            SizedBox(
              width: 10,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/icon/driver.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    widget.userRideDetails!.originAddress!,
                    style: TextStyle(color: ColorConfig.secondary),
                  ),
                ).expand()
              ],
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: ColorConfig.primary,
            ),
            ElevatedButton(
                onPressed: () {
                  provider.audioPlayer.pause();
                  provider.audioPlayer.stop();
                  provider.resetAudioPlayer();
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () {
                  provider.audioPlayer.pause();
                  provider.audioPlayer.stop();
                  provider.resetAudioPlayer();
                  Navigator.pop(context);
                },
                child: Text("Accept")),
          ],
        )
      ]),
    );
  }
}
