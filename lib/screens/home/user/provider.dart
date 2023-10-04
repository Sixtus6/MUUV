import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class UserGoogleMapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controllerCompleter = Completer();
  LatLng? picklocation;
  loc.Location location = loc.Location();
  String? address;

  Future<GoogleMapController> get controller => _controllerCompleter.future;

  void setController(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    notifyListeners();
  }
}
