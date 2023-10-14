import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:muuv/config/color.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/activeNearByDrivers.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/direction_info.dart';
import 'package:muuv/model/predictedPlaces.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/utils/geo_assistant.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/progress.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:firebase_database/firebase_database.dart';

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

  String _userDropOffAddress = "";
  String get userDropOffAddress => _userDropOffAddress;

  DirectionDetailsInfo? _tripDirectionDetails;
  DirectionDetailsInfo? get tripDirectionDetails => _tripDirectionDetails;

  String _email = "";
  String get email => _email;

  bool _openNavigationDrawer = true;
  bool get openNavigationDrawer => _openNavigationDrawer;

  bool _requestPositionInfo = true;
  bool get requestPositionInfo => _requestPositionInfo;

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

  List _driverList = [];
  List get driverList => _driverList;

  Direction? _userPickUpLocation;

  Direction? _userDropOffLocation;
  Direction? get userPickUpLocation => _userPickUpLocation;
  Direction? get userDropOffLocation => _userDropOffLocation;

  Direction _userPickupaddress = Direction();
  Direction get userPickupaddress => _userPickupaddress;

  UserModel? _user;
  UserModel? get user => _user;

  String _driverRideStatus = "Driver is coming";
  String get driverRideStatus => _driverRideStatus;

  StreamSubscription<DatabaseEvent>? _tripRidesRequestStream;
  StreamSubscription<DatabaseEvent>? get tripRidesRequestStream =>
      _tripRidesRequestStream;

  StreamSubscription<Position>? _streamSubscriptionPosition;
  StreamSubscription<Position>? get streamSubscriptionPosition =>
      _streamSubscriptionPosition;

  DatabaseReference? _referenceRideRequest;
  DatabaseReference? get referenceRideRequest => _referenceRideRequest;

  int _countTotalTrialTrip = 0;

  List<PredictedPlaces> _placesPredictedList = [];
  List<PredictedPlaces> get placesPredictedList => _placesPredictedList;

  String _driverCarDetails = "";
  String get driverCarDetails => _driverCarDetails;

  String _driverName = "";
  String get driverName => _driverName;

  String _driverPhone = "";
  String get driverPhone => _driverPhone;

  String _userRideRequestStatus = "";
  String get userRideRequestStatus => _userRideRequestStatus;

  late AssetsAudioPlayer _audioPlayer;
  AssetsAudioPlayer get audioPlayer => _audioPlayer;

  List<ActiveNearByDrivers> _onlineNearbyAvailableDriverList = [];
  List<ActiveNearByDrivers>? get onlineNearbyAvailableDriverList =>
      _onlineNearbyAvailableDriverList;

  resetAudioPlayer() {
    _audioPlayer = AssetsAudioPlayer();
  }

  findPlaceAutoCompleSearch(String inputText) async {
    if (inputText.length > 1) {
      String urlSearch =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${inputText}&key=${KeyConfig.googleApiKey}&components=country:NG";

      var response = await receiveRequest(urlSearch);
      print(["this is for auto complete search", urlSearch]);
      if (response != null) {
        var predictedPlaces = response["predictions"];
        var predictedPlacesList = (predictedPlaces as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();
        _placesPredictedList = predictedPlacesList;
      }
    }
    notifyListeners();
  }

  UserGoogleMapProvider() {
    _location = loc.Location();
    _geolocator = Geolocator();
    _audioPlayer = AssetsAudioPlayer();
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

  void _updatePickuplocationAddress(Direction userPickupaddress) {
    _userPickUpLocation = userPickupaddress;
    notifyListeners();
  }

  void _updateDropOffLocation(Direction userDropOffaddress) {
    _userDropOffLocation = userDropOffaddress;
    notifyListeners();
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
  }

  Future<void> locateUserPosition() async {
    dev.log("locate");
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
      print(["this is user curren position", userAddress]);
      UserModel? userData = await getUserFromPrefs();
      // _user = userData;
      _username = userData!.name;
      _email = userData.emailAddress;
      _user = userData;
      dev.log("initiLze");

      _userCurrentPosition != null
          ? initializeGeofireListiner()
          : print("this is null so waiting");

      notifyListeners();
    } catch (e) {
      print('Error locating user position: $e');
    }
  }

  initializeGeofireListiner() {
    print("geolocator starter");
    Geofire.initialize("activeDrivers");
    Geofire.queryAtLocation(
            _userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!
        .listen((event) {
      print(event);
      if (event != null) {
        var callback = event["callBack"];
        //  print(callback);
        switch (callback) {
          case Geofire.onKeyEntered:
            ActiveNearByDrivers activeNearByDrivers = ActiveNearByDrivers();
            activeNearByDrivers.locationLat = event["latitude"];
            activeNearByDrivers.locationLong = event["longitude"];
            activeNearByDrivers.driverID = event["key"];
            GeoFireAssistant.activeNearDriversList.add(activeNearByDrivers);
            if (_activeNearbyDriverKeysLoaded == true) {
              displayActiveDriversOnUserMap();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.deleteOfflineDriverFromList(event["key"]);
            displayActiveDriversOnUserMap();
            break;

          case Geofire.onKeyMoved:
            ActiveNearByDrivers activeNearByDrivers = ActiveNearByDrivers();
            activeNearByDrivers.locationLat = event["latitude"];
            activeNearByDrivers.locationLong = event["longitude"];
            activeNearByDrivers.driverID = event["key"];
            GeoFireAssistant.updateActiveNearByDiver(activeNearByDrivers);
            displayActiveDriversOnUserMap();
            break;

          case Geofire.onGeoQueryReady:
            _activeNearbyDriverKeysLoaded = true;
            displayActiveDriversOnUserMap();
            break;
        }
      }

      notifyListeners();
    });
  }

  displayActiveDriversOnUserMap() {
    _markerSet.clear();
    _circleSet.clear();
    Set<Marker> driversMarkerSet = Set<Marker>();
    for (ActiveNearByDrivers eachDriver
        in GeoFireAssistant.activeNearDriversList) {
      LatLng eachDriverActivePosition =
          LatLng(eachDriver.locationLat!, eachDriver.locationLong!);

      Marker marker = Marker(
          markerId: MarkerId(eachDriver.driverID!),
          position: eachDriverActivePosition,
          icon: _activeNearbyIcon!,
          rotation: 360);

      driversMarkerSet.add(marker);
    }

    _markerSet = driversMarkerSet;
    notifyListeners();
  }

  createActiveNearbyIconMarker(context) {
    print(["This image processsing", _activeNearbyIcon]);
    if (_activeNearbyIcon == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(5, 5));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "assets/icon/car.png")
          .then((value) {
        _activeNearbyIcon = value;
      });
    } else {
      print("therer is an issue with the image loader");
    }
  }

  Future<void> drawerPolyLineFromOriginToDestination(context) async {
    var originPosition = _userPickUpLocation!;
    var destinationPosition = _userDropOffLocation!;

    // print([originPosition, destinationPosition]);

    var originLatLng = LatLng(double.parse(originPosition.locationLat!),
        double.parse(originPosition.locationLong!));

    print("here");
    var destinationLatLng = LatLng(
        double.parse(destinationPosition.locationLat!),
        double.parse(destinationPosition.locationLong!));

    print([originPosition.locationLong, destinationPosition.locationLat]);
    var directionInfo =
        await obtainDirectionDetails(originLatLng, destinationLatLng);
    _tripDirectionDetails = directionInfo;
    // Navigator.pop(context);
    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodePolyLinePointsResultList =
        pPoints.decodePolyline(directionInfo.e_points!);
    _pLineCoordinateList.clear();
    if (decodePolyLinePointsResultList.isNotEmpty) {
      decodePolyLinePointsResultList.forEach((PointLatLng pointLatLng) {
        _pLineCoordinateList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    _polylineSet.clear();
    Polyline polyline = Polyline(
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: _pLineCoordinateList,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        width: 4,
        color: ColorConfig.primary);

    _polylineSet.add(polyline);

    LatLngBounds boundsLatLag;
    if (originLatLng.latitude > destinationLatLng.latitude &&
        originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLag =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLag = LatLngBounds(
          southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, originLatLng.longitude));
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLag = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
          northeast:
              LatLng(originLatLng.latitude, destinationLatLng.longitude));
    } else {
      boundsLatLag =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }
    double padding = calculatePaddingBasedOnDistance(boundsLatLag);

    print(padding);

    _newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLag, padding));

    Marker originMarker = Marker(
        markerId: MarkerId("originID"),
        infoWindow:
            InfoWindow(title: originPosition.locationName, snippet: "Origin"),
        position: originLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

    Marker destinationMarker = Marker(
        markerId: MarkerId("destinationID"),
        infoWindow: InfoWindow(
            title: destinationPosition.locationName, snippet: "Destination"),
        position: destinationLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    _markerSet.add(originMarker);
    _markerSet.add(destinationMarker);

    Circle originCircle = Circle(
        circleId: CircleId("originID"),
        fillColor: Colors.green,
        radius: 12,
        strokeWidth: 3,
        strokeColor: ColorConfig.white,
        center: originLatLng);

    Circle destinationCircle = Circle(
        circleId: CircleId("destinationID"),
        fillColor: Colors.red,
        radius: 12,
        strokeWidth: 3,
        strokeColor: ColorConfig.white,
        center: destinationLatLng);

    _circleSet.add(originCircle);
    _circleSet.add(destinationCircle);
    notifyListeners();
  }

  getAddressFromLatLng() async {
    try {
      //  print(_pickLocation!.latitude);
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: _pickLocation!.latitude,
          longitude: _pickLocation!.longitude,
          googleMapApiKey: KeyConfig.googleApiKey);

      ///_address = data.address;

      _userPickupaddress.locationLat = _pickLocation!.latitude.toString();
      _userPickupaddress.locationLong = _pickLocation!.longitude.toString();
      _userPickupaddress.locationName = data.address.toString();
      print([
        "from getaddress",
        _userPickupaddress.locationLat,
        _userPickupaddress.locationLong
      ]);

      _updatePickuplocationAddress(_userPickupaddress);

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
      userPickupaddress.locationLong = position.longitude.toString();
      userPickupaddress.locationName = addressCordinate.toString();
      _updatePickuplocationAddress(userPickupaddress);

      // final screenState = Provider.of<UserRideInfo>(context,listen: false);
    }
    return addressCordinate;
  }

  Future<DirectionDetailsInfo> obtainDirectionDetails(
      LatLng originPosition, LatLng destinationPosition) async {
    var directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${originPosition.latitude},${originPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=${KeyConfig.googleApiKey}";
    var response = await receiveRequest(directionUrl);
    DirectionDetailsInfo directionDetailsInfo = DirectionDetailsInfo();
    if (response != null) {
      directionDetailsInfo.e_points =
          response["routes"][0]["overview_polyline"]["points"].toString();

      directionDetailsInfo.distance_text =
          response["routes"][0]["legs"][0]["distance"]["text"].toString();

      directionDetailsInfo.distance_value =
          response["routes"][0]["legs"][0]["distance"]["value"];

      directionDetailsInfo.duration_text =
          response["routes"][0]["legs"][0]["duration"]["text"].toString();

      directionDetailsInfo.duration_value =
          response["routes"][0]["legs"][0]["duration"]["value"];
    } else {
      print("error Occured");
    }
    return directionDetailsInfo;
  }

  getPlaceDirectionDetails(String? placeid, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Setting  up Drop-off, Please wait",
            ));
    String apiUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeid}&key=${KeyConfig.googleApiKey}";
    var responseApi = await receiveRequest(apiUrl);
    print(responseApi);
    Navigator.pop(context);
    if (responseApi != null) {
      Direction direction = Direction();
      direction.locationName = responseApi["result"]["name"].toString();
      direction.locationID = placeid.toString();
      direction.locationLat =
          responseApi["result"]["geometry"]["location"]["lat"].toString();
      direction.locationLong =
          responseApi["result"]["geometry"]["location"]["lng"].toString();

      _updateDropOffLocation(direction);
      _userDropOffAddress = direction.locationName!;
      Navigator.pop(context, "obatainedDropOff");
      _openNavigationDrawer = false;
//TODO: await drawerPolyLineFromOriginToDEstination()

      await drawerPolyLineFromOriginToDestination(context);
      // final screenState = Provider.of<UserRideInfo>(context,listen: false);
    } else {
      print("error at titile");
      return;
    }
    notifyListeners();
  }

  saveRideRequest() {
    _referenceRideRequest =
        FirebaseDatabase.instance.ref().child("All Ride Request").push();
    var originLocation = _userPickUpLocation;
    var destinationLocation = _userDropOffLocation;

    Map originLocationMap = {
      "latitude": originLocation!.locationLat.toString(),
      "longitude": originLocation.locationLong.toString()
    };

    Map destibationLocationMap = {
      "latitude": destinationLocation!.locationLat.toString(),
      "longitude": destinationLocation.locationLong.toString()
    };

    Map userInfomationMap = {
      "origin": originLocationMap,
      "destination": destibationLocationMap,
      "time": DateTime.now().toString(),
      "userName": _user!.name,
      "userPhone": _user!.phoneNumber,
      "originAddress": originLocation.locationName,
      "destinationAddress": destinationLocation.locationName,
      "driverID": "waiting"
    };

    _referenceRideRequest!.set(userInfomationMap);

    _tripRidesRequestStream =
        _referenceRideRequest!.onValue.listen((event) async {
      if (event.snapshot.value == null) {
        return;
      }
      if ((event.snapshot.value as Map)["car_details"] != null) {
        _driverCarDetails =
            (event.snapshot.value as Map)["car_details"].toString();
      }

      if ((event.snapshot.value as Map)["driverPhone"] != null) {
        _driverCarDetails =
            (event.snapshot.value as Map)["driverPhone  "].toString();
      }

      if ((event.snapshot.value as Map)["driverName"] != null) {
        _driverCarDetails =
            (event.snapshot.value as Map)["driverName"].toString();
      }

      if ((event.snapshot.value as Map)["status"] != null) {
        _userRideRequestStatus =
            (event.snapshot.value as Map)["status"].toString();
      }

      if ((event.snapshot.value as Map)["driverLocation"] != null) {
        double driverCurrentPositionLat = double.parse(
            (event.snapshot.value as Map)["driverLocation"]["latitude"]
                .toString());

        double driverCurrentPositionLng = double.parse(
            (event.snapshot.value as Map)["driverLocation"]["longitude"]
                .toString());

        LatLng driverCurrentPositionLatLng =
            LatLng(driverCurrentPositionLat, driverCurrentPositionLng);

        if (_userRideRequestStatus == "accepted") {
          updateDiverArrivalTime(driverCurrentPositionLatLng);
        }

        if (_userRideRequestStatus == "arrived") {
          _driverRideStatus = "Driver has arrived";
          //            updateDiverArrivalTime(driverCurrentPositionLatLng);
        }

        if (_userRideRequestStatus == "ontrip") {
          updateReachingTime(driverCurrentPositionLatLng);
          //updateDiverArrivalTime(driverCurrentPositionLatLng);
        }

        if (_userRideRequestStatus == "ended") {
          _referenceRideRequest!.onDisconnect();
          tripRidesRequestStream!.cancel();
          //Tode: for payment system
          // if ((event.snapshot.value as Map)["fareAmount"] != null) {
          //   double fareAmount = double.parse(
          //       (event.snapshot.value as Map)['fareAmount'].toString());
          // }
          //   updateDiverArrivalTime(driverCurrentPositionLatLng);
        }
      }
    });

    _onlineNearbyAvailableDriverList = GeoFireAssistant.activeNearDriversList;
    //searchNearestOnlineDrivers()
    notifyListeners();
  }

  searchNearestOnlineDrivers(String selectedVehicleType, context) async {
    if (_onlineNearbyAvailableDriverList.length == 0) {
      _referenceRideRequest!.remove();
      _polylineSet.clear();
      _markerSet.clear();
      _circleSet.clear();
      _pLineCoordinateList.clear();
      toast("No Avaialable Driver, Try Again");
      Future.delayed(Duration(milliseconds: 4000), () {
        //Write the funtion to naviagate to splash screen
      });

      return;
    }

    await retriveOnlineDriverInfo(_onlineNearbyAvailableDriverList);
    print("DriverList" + _driverList.toString());

    for (var i = 0; i < driverList.length; i++) {
      //SendNotification to drivers
      sendNotificationToDriverNow(_driverList[i]["token"],
          _referenceRideRequest!.key!, _userDropOffAddress, context);
    }
    toast("Ride Request Sent");
    //Show searcing for drivers container

    FirebaseDatabase.instance
        .ref()
        .child("All Ride Request")
        .child(referenceRideRequest!.key!)
        .child("driverId")
        .onValue
        .listen((event) {
      print("EventSnapshot:  ${event.snapshot.value}");
      if (event.snapshot.value != null) {
        if (event.snapshot.value != "waiting") {
          print("show waiting screen");
        }
      }
    });

    notifyListeners();
  }

  updateReachingTime(driverCurrentPositionLatLng) async {
    if (_requestPositionInfo == true) {
      _requestPositionInfo = false;
      var dropOffLocation = _userDropOffLocation;

      LatLng userDestinationPosition = LatLng(
          double.parse(dropOffLocation!.locationLat!),
          double.parse(dropOffLocation.locationLong!));

      var directionDetailsInfo = await obtainDirectionDetails(
          driverCurrentPositionLatLng, userDestinationPosition);

      if (directionDetailsInfo == null) {
        return;
      }

      _driverRideStatus =
          "Going Towards Destination: ${directionDetailsInfo.duration_text}";
      _requestPositionInfo = true;
    }
    notifyListeners();
  }

  retriveOnlineDriverInfo(List onlineNearbyAvailableDriverList) async {
    _driverList.clear();
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("drivers");
    for (var i = 0; i < onlineNearbyAvailableDriverList.length; i++) {
      await ref
          .child(onlineNearbyAvailableDriverList[i].driverId.toString())
          .once()
          .then((dataSnapShot) {
        var driverKeyInfo = dataSnapShot.snapshot.value;
        _driverList.add(driverKeyInfo);
        print("driver key information" + _driverList.toString());
      });
    }
    notifyListeners();
  }

  updateDiverArrivalTime(driverCurrentPositionLatLng) async {
    if (_requestPositionInfo == true) {
      _requestPositionInfo = false;
      LatLng userPickUpPosition = LatLng(
          _userCurrentPosition!.latitude, _userCurrentPosition!.longitude);

      var directionDetailsInfo = await obtainDirectionDetails(
          driverCurrentPositionLatLng, userPickUpPosition);

      if (directionDetailsInfo == null) {
        return;
      }
      _driverRideStatus =
          "Driver is Coming" + directionDetailsInfo.distance_text.toString();
      _requestPositionInfo = true;
    }
    notifyListeners();
  }

  pauseLiveLocationUpdates() {
    _streamSubscriptionPosition!.pause();
    Geofire.removeLocation(_user!.uid);
  }

  acceptRideRequest() {
    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(_user!.uid)
        .child("newRideStatus")
        .once()
        .then((snap) {
      if (snap.snapshot.value == "Idle") {
        FirebaseDatabase.instance
            .ref()
            .child("drivers")
            .child(_user!.uid)
            .child("newRidestatus")
            .set("accepted");
        pauseLiveLocationUpdates();

        //TODO: Lauch new screnn
        toast("launch new screen");
      } else {
        toast("This ride request dosnt exist again");
      }
    });

    notifyListeners();
  }
}
