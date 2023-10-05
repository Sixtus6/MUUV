import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/utils/helper.dart';

class UserGoogleMapProvider with ChangeNotifier {
  Completer<GoogleMapController> _controllerCompleter = Completer();

  late loc.Location _location;
  loc.Location get location => _location;

  late Geolocator _geolocator;
  Geolocator get geolocator => _geolocator;

  LocationPermission? _locationPermission;
  LocationPermission? get locationPermission => _locationPermission;

  Set<Polyline> _polylineSet = {};
  Set<Polyline> get polylineSet => _polylineSet;

  Set<Marker> _markerSet = {};
  Set<Marker> get markerSet => _markerSet;

  Set<Circle> _circleSet = {};
  Set<Circle> get circleSet => _circleSet;

  String _username = "";
  String get username => _username;

  String _email = "";
  String get email => _email;

  bool _openNavigationDrawer = true;
  bool get openNavigationDrawer => _openNavigationDrawer;

  bool _activeNearbyDriverKeysLoaded = false;
  bool get activeNearbyDriverKeysLoaded => _activeNearbyDriverKeysLoaded;

  BitmapDescriptor? _activeNearbyIcon;
  BitmapDescriptor? get activeNearbyIcon => _activeNearbyIcon;

  Future<GoogleMapController> get controller => _controllerCompleter.future;

  LatLng? _pickLocation;
  LatLng? get pickLocation => _pickLocation;

  GoogleMapController? _newGoogleMapController;
  GoogleMapController? get newGoogleMapController => _newGoogleMapController;

  String? _address;
  String? get address => _address;

  Position? _userCurrentPosition;
  Position? get userCurrentPosition => _userCurrentPosition;

  List<LatLng> _pLineCoordinateList = [];
  List<LatLng> get pLineCoordinateList => _pLineCoordinateList;

  UserGoogleMapProvider() {
    _location = loc.Location();
    _geolocator = Geolocator();
    _checkAndRequestPermissions();
  }

  setpickLocation(LatLng? newLocation) {
    _pickLocation = newLocation;
  }

  void setController(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    notifyListeners();
  }

  void setnewGoogleMapController(GoogleMapController? controller) {
    _newGoogleMapController = controller;
    notifyListeners(); // Notify listeners when the controller is set
  }

  bool _serviceEnabled = false;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.denied;

  Future<void> _checkAndRequestPermissions() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    // locationData = await _location.getLocation();
    // print([locationData]);
    // notifyListeners(); // Notify listeners about the location update
  }

  //     late loc.Location _new location;
  // bool _serviceEnabled = false;
  // PermissionStatus _permissionGranted = PermissionStatus.denied;
  // LocationData _locationData = LocationData.fromMap({
  //   'latitude': 0.0,
  //   'longitude': 0.0,
  // });

  Future<void> locateUserPosition() async {
    try {
      Position cPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _userCurrentPosition = cPosition;

      LatLng latLngPosition = LatLng(
          _userCurrentPosition!.latitude, _userCurrentPosition!.longitude);
      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 15);

      _newGoogleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      String userAddress =
          await searchAddressViaCordinates(_userCurrentPosition!);
      print([userAddress]);
      UserModel? data = await getUserFromPrefs();

      _username = data!.name;
      _email = data.emailAddress;
      notifyListeners();
    } catch (e) {
      print('Error locating user position: $e');
    }
  }

  getAddressFromLatLng() async {
    try {
      print(_pickLocation!.latitude);
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: _pickLocation!.latitude,
          longitude: _pickLocation!.longitude,
          googleMapApiKey: KeyConfig.googleApiKey);

      _address = data.address;
      print(_address);
      notifyListeners();
    } catch (e) {
      print("error at gettin user address ${e}");
    }
  }

  Future<String> searchAddressViaCordinates(Position position) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.latitude}&key=${KeyConfig.googleApiKey}";

    print(apiUrl);
    String addressCordinate = "";
    var responseRequest = await receiveRequest(apiUrl);

    if (responseRequest != null) {
      addressCordinate = responseRequest["results"][0]["formatted_address"];

      Direction userPickupaddress = Direction();
      userPickupaddress.locationLat = position.latitude.toString();
      userPickupaddress.locationLat = position.latitude.toString();
      userPickupaddress.locationName = addressCordinate.toString();
    }
    return addressCordinate;
  }
}

class userRideInfo with ChangeNotifier {
  Direction? userPickUpLocation, userDropOffLocation;
  int countTotalTrialTrip = 0;

  void updatePickupl
}

  // Completer<GoogleMapController> _controllerCompleter = Completer();
  // LatLng? picklocation;
  // loc.Location location = loc.Location();

  // String? address;
  // Position? userCurrentPosition;
  // var geolocation = Geolocator();
  // LocationPermission? _locationPermission;
  // List<LatLng> pLineCordinateList = [];
  // Set<Polyline> polylineset = {};
  // Set<Marker> markerSet = {};
  // Set<Circle> circleset = {};
  // String username = "";
  // String email = "";
  // bool openNavigationDraer = true;
  // bool activeNearbyDriverKeysLoaded = false;
  // BitmapDescriptor? activeNearbyIcon;

  // Future<GoogleMapController> get controller => _controllerCompleter.future;

  // void setController(GoogleMapController controller) {
  //   _controllerCompleter.complete(controller);
  //   notifyListeners();
  // }
