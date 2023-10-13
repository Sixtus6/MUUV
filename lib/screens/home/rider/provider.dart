import 'dart:async';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderGoogleMapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controllerCompleter = Completer();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 11.0);
  CameraPosition get kGooglePlex => _kGooglePlex;

  late Geolocator _geolocator;
  Geolocator get geolocator => _geolocator;

  LocationPermission? _locationPermission;
  LocationPermission? get locationPermission => _locationPermission;

  late loc.Location _location;
  loc.Location get location => _location;

  final String _status = "Offline";
  String get status => _status;

  final bool _isDriverActive = true;
  bool get isDriverActive => _isDriverActive;

  RiderGoogleMapProvider() {
    _location = loc.Location();
    _geolocator = Geolocator();

    _checkAndRequestPermissions();
  }
}
