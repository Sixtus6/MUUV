import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserRequestRideInfo {
  LatLng? originLatLng;
  LatLng? destinationLatLng;
  String? originAddress;
  String? destinationAddress;
  String? rideRequestId;
  String? userName;
  String? userPhone;

  UserRequestRideInfo(
      {this.originAddress,
      this.destinationAddress,
      this.originLatLng,
      this.destinationLatLng,
      this.rideRequestId,
      this.userName,
      this.userPhone});
}
