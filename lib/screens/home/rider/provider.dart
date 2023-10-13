import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/rider.dart';
import 'package:muuv/utils/helper.dart';

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

  bool _serviceEnabled = false;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.denied;

  GoogleMapController? _newGoogleMapController;
  GoogleMapController? get newGoogleMapController => _newGoogleMapController;

  Position? _driverCurrentPosition;
  Position? get driverCurrentPosition => _driverCurrentPosition;

  Direction? _driverPickUpLocation;

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
  }

  void _updatePickuplocationAddress(Direction userPickupaddress) {
    _driverPickUpLocation = userPickupaddress;
    notifyListeners();
  }

  Future<String> searchAddressViaCordinates(Position position) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.latitude}&key=${KeyConfig.googleApiKey}";

    print(apiUrl);
    String addressCordinate = "";
    var responseRequest = await receiveRequest(apiUrl);

    if (responseRequest != null) {
      addressCordinate = responseRequest["results"][0]["formatted_address"];

      Direction driverPickupaddress = Direction();
      driverPickupaddress.locationLat = position.latitude.toString();
      driverPickupaddress.locationLong = position.longitude.toString();
      driverPickupaddress.locationName = addressCordinate.toString();
      _updatePickuplocationAddress(driverPickupaddress);

      // final screenState = Provider.of<UserRideInfo>(context,listen: false);
    }
    return addressCordinate;
  }

  Future<void> locateDriverPosition() async {
    try {
      Position cPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _driverCurrentPosition = cPosition;

      LatLng latLngPosition = LatLng(
          _driverCurrentPosition!.latitude, _driverCurrentPosition!.longitude);
      CameraPosition cameraPosition =
          CameraPosition(target: latLngPosition, zoom: 15);

      _newGoogleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      String driverAddress =
          await searchAddressViaCordinates(_driverCurrentPosition!);
      print(["this is user curren position", driverAddress]);

      notifyListeners();
    } catch (e) {
      print('Error locating user position: $e');
    }
  }

  readCurrentDriverInformation() async {
    RiderModel? riderData = await getRiderFromPrefs();
    
  }

  RiderGoogleMapProvider() {
    _location = loc.Location();
    _geolocator = Geolocator();

    _checkAndRequestPermissions();
  }
}
