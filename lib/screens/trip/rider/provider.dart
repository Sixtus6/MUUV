import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderTripGoogleMapProvider with ChangeNotifier {

  
  Completer<GoogleMapController> _controllerCompleter = Completer();

  final CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 11.0);
  CameraPosition get kGooglePlex => _kGooglePlex;

  Set<Marker> _markerSet = {};
  Set<Marker> get markerSet => _markerSet;

  Set<Circle> _circleSet = {};
  Set<Circle> get circleSet => _circleSet;

  Set<Polyline> _polylineSet = {};
  Set<Polyline> get polylineSet => _polylineSet;

  List<LatLng> _pLinePositionCoordinateList = [];
  List<LatLng> get pLinePositionCoordinateList => _pLinePositionCoordinateList;

  PolylinePoints _polylinePoints = PolylinePoints();
    PolylinePoints get polylinePoints => _polylinePoints;

  late Geolocator _geolocator;
  Geolocator get geolocator => _geolocator;

     BitmapDescriptor? _iconAnimatedMarker;
  BitmapDescriptor? get iconAnimatedMarker => _iconAnimatedMarker;
}
