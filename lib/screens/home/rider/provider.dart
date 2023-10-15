import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/driverdata.dart';
import 'package:muuv/model/rider.dart';
import 'package:muuv/notifications/notifications.dart';
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

  String _status = "Offline";
  String get status => _status;

  RiderModel? _rider;
  RiderModel? get rider => _rider;

  final bool _isDriverActive = true;
  bool get isDriverActive => _isDriverActive;

  bool _serviceEnabled = false;
  loc.PermissionStatus _permissionGranted = loc.PermissionStatus.denied;

  GoogleMapController? _newGoogleMapController;
  GoogleMapController? get newGoogleMapController => _newGoogleMapController;

  PushNotificationSystem? _pnotification;
  PushNotificationSystem? get pnotification => _pnotification;

  void setController(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    notifyListeners();
  }

  void setnewGoogleMapController(GoogleMapController? controller) {
    _newGoogleMapController = controller;
    notifyListeners(); // Notify listeners when the controller is set
  }

  void setStatus(String data) {
    _status = data;
    notifyListeners(); // Notify listeners when the controller is set
  }

  Future<GoogleMapController> get controller => _controllerCompleter.future;

  DriverData _onlineDriverData = DriverData();
  DriverData get onlineDriverData => _onlineDriverData;

  Position? _driverCurrentPosition;
  Position? get driverCurrentPosition => _driverCurrentPosition;

  Direction? _driverPickUpLocation;

  StreamSubscription<Position>? _streamSubscriptionPosition;
  StreamSubscription<Position>? _streamSubscriptionDriverLivePosition;

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
      RiderModel? riderData = await getRiderFromPrefs();
      _rider = riderData;
      _readCurrentDriverInformation();
      notifyListeners();
    } catch (e) {
      print('Error locating user position: $e');
    }
  }

  _readCurrentDriverInformation() async {
    RiderModel? riderData = await getRiderFromPrefs();
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(riderData!.uid)
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        print(["this is the snapshot data", snap.snapshot.value]);
        _onlineDriverData.id = (snap.snapshot.value as Map)["id"];
        _onlineDriverData.name = (snap.snapshot.value as Map)["name"];
        _onlineDriverData.phone = (snap.snapshot.value as Map)["phone"];
        _onlineDriverData.email = (snap.snapshot.value as Map)["email"];
        _onlineDriverData.address = (snap.snapshot.value as Map)["address"];
        _onlineDriverData.car_color = (snap.snapshot.value as Map)["carColor"];
        _onlineDriverData.car_model = (snap.snapshot.value as Map)["carModel"];
        _onlineDriverData.car_number =
            (snap.snapshot.value as Map)["carPlateNum"];
      } else {
        print("its null");
      }
    });
    notifyListeners();
  }

  driverIsOnline() async {
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _driverCurrentPosition = pos;
    Geofire.initialize("activeDrivers");
    Geofire.setLocation(_rider!.uid, _driverCurrentPosition!.latitude,
        _driverCurrentPosition!.longitude);

    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(_rider!.uid)
        .child("newRideStatus");

    ref.set("idle");
    ref.onValue.listen((event) {});
  }

  updateDriversLocationAtRealTime() { 
    _streamSubscriptionPosition =
        Geolocator.getPositionStream().listen((Position position) {
      //_isDriverActive == true;
      if (_status == "Online") {
        Geofire.setLocation(_rider!.uid, _driverCurrentPosition!.latitude,
            _driverCurrentPosition!.longitude);
      }

      LatLng latLng = LatLng(
          _driverCurrentPosition!.latitude, _driverCurrentPosition!.longitude);

      _newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  driverIsOffline() {
    Geofire.removeLocation(_rider!.uid);
    DatabaseReference? ref = FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(_rider!.uid)
        .child("newRideStatus");

    ref.onDisconnect();
    ref.remove();
    ref = null;
    // Future.delayed(Duration(milliseconds: 2000), () {
    //   SystemChannels.platform.invokeListMethod("SystemNavigator.pop");
    // });
  }

  RiderGoogleMapProvider() {
    _location = loc.Location();
    _geolocator = Geolocator();
    _pnotification = PushNotificationSystem();
    _checkAndRequestPermissions();
  }
}
