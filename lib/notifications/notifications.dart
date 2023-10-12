import 'dart:js_interop';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/utils/helper.dart';

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
    UserModel? userData = await getUserFromPrefs();
    FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestId)
        .child("driverId")
        .onValue
        .listen((event) {
      if (event.snapshot.value == "waiting" ||
          event.snapshot.value == "waiting" ||
          event.snapshot.value == userData!.uid) {
        FirebaseDatabase.instance
            .ref()
            .child("All Ride Requests")
            .child(userRideRequestId)
            .once()
            .then((snapshotData) =>
                {if (snapshotData.snapshot.value != null) {}});
      }
    });
  }
}
