import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class UserGoogleMapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controllerCompleter = Completer();
  LatLng? picklocation;
  loc.Location location = loc.Location();
  String? address;
  Position? userCurrentPosition;
  var geolocation = Geolocator();
  LocationPermission? _locationPermission;
  List<LatLng> pLineCordinateList = [];
  Set<Polyline> polylineset = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleset = {};
  String username = "";
  String email = "";
  bool openNavigationDraer = true;
  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;

  Future<GoogleMapController> get controller => _controllerCompleter.future;

  void setController(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    notifyListeners();
  }
}
