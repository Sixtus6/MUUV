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
                      onPressed: () async {},
                      child: Text(
                        "Decline",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green)),
                      onPressed: () {
                        try {
                          print(provider.audioPlayer);
                          provider.audioPlayer.open(
                            Audio('assets/music/waterdrip.mp3'),
                          );
                          provider.audioPlayer.play();
                        } catch (e) {
                          print(e);
                        }
                      },
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

}
