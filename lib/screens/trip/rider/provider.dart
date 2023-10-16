import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RiderTripGoogleMapProvider with ChangeNotifier {
    Completer<GoogleMapController> _controllerCompleter = Completer();
    
}
