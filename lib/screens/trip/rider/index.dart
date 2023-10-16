import 'package:flutter/material.dart';
import 'package:muuv/model/userRequestRideInfo.dart';

class RiderTripScreen extends StatefulWidget {
  RiderTripScreen({this.userRideDetails});

  UserRequestRideInfo? userRideDetails;
  @override
  State<RiderTripScreen> createState() => _RiderTripScreenState();
}

class _RiderTripScreenState extends State<RiderTripScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
