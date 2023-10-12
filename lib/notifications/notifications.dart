// ignore_for_file: unused_local_variable

import 'dart:js_interop';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/model/userRequestRideInfo.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/utils/helper.dart';
import 'package:provider/provider.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  /* ------------------------------------ - ----------------------------------- */
  Future initializeCloudMessaging(BuildContext context) async {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) => {
              if (remoteMessage != null)
                {
                  readUserRequestInformation(
                      remoteMessage.data["rideRequestId"], context)
                }
            });

    FirebaseMessaging.onMessage.listen((
      RemoteMessage? remoteMessage,
    ) {
      readUserRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      readUserRequestInformation(remoteMessage!.data["rideRequestId"], context);
    });
  }

/* ------------------------------------ - ----------------------------------- */
  readUserRequestInformation(
    String userRideRequestId,
    BuildContext context,
  ) async {
    // UserModel? userData = await getUserFromPrefs();

    double? originLat;
    double? originLng;
    String originAddress;
    double? destinationOriginLat;
    double? destinationOriginLng;
    String destinationOriginAddress;
    String username;
    String rideRequestId;
    String userPhone;
    UserRequestRideInfo userRequest = UserRequestRideInfo();
    final provider = Provider.of<UserGoogleMapProvider>(context, listen: false);
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .child("driverId")
        .onValue
        .listen((event) {
      if (event.snapshot.value == "waiting" ||
          event.snapshot.value == "waiting" ||
          event.snapshot.value == provider.user!.uid) {
        FirebaseDatabase.instance
            .ref()
            .child("All Ride Requests")
            .child(userRideRequestId)
            .once()
            .then((snapshotData) => {
                  if (snapshotData.snapshot.value != null)
                    {
                      provider.audioPlayer
                          .open(Audio('assets/music/waterdrip.mp3')),
                      provider.audioPlayer.play(),
                      originLat = double.parse((snapshotData.snapshot.value!
                          as Map)["origin"]["latitude"]),
                      originLng = double.parse((snapshotData.snapshot.value!
                          as Map)["origin"]["longitude"]),
                      originAddress = (snapshotData.snapshot.value!
                          as Map)["originAddress"],
                      destinationOriginLat = double.parse(
                          (snapshotData.snapshot.value! as Map)["destination"]
                              ["latitude"]),
                      destinationOriginLng = double.parse(
                          (snapshotData.snapshot.value! as Map)["destination"]
                              ["longitude"]),
                      destinationOriginAddress = (snapshotData.snapshot.value!
                          as Map)["destinationAddress"],

                      username =
                          (snapshotData.snapshot.value as Map)["userName"],
                      userPhone =
                          (snapshotData.snapshot.value as Map)["userPhone"],
                      rideRequestId = snapshotData.snapshot.key!,
                      userRequest.originLatLng = LatLng(originLat!, originLng!),
                      userRequest.originAddress =originAddress,   
                      userRequest.destinationLatLng=  LatLng(destinationOriginLat!, destinationOriginLng!),
                      userRequest.userName =username,
userRequest.userPhone= userPhone
                      //double originLng =
                    }
                });
      }
    });
  }
}
