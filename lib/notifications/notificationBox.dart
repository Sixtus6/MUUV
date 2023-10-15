import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/model/userRequestRideInfo.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NotificationDialogBox extends StatefulWidget {
  UserRequestRideInfo? userRideDetails;
  NotificationDialogBox({this.userRideDetails});

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
      child: Padding(
        padding: EdgeInsets.only(
            top: SizeConfigs.getPercentageWidth(38),
            bottom: SizeConfigs.getPercentageWidth(38)),
        child: Container(
          decoration: BoxDecoration(
            color: ColorConfig.white,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(7)),
          child: Column(
            children: [
              Lottie.asset(
                "assets/lottie/car2.json",
              ),
            ],
          ),
        ),
      ),
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
