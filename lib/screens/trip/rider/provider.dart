import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderTripGoogleMapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controllerCompleter = Completer();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 11.0);
  CameraPosition get kGooglePlex => _kGooglePlex;
}
