import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction_info.dart';
import 'package:muuv/model/driverdata.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/splash/index.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/progress.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RiderTripGoogleMapProvider with ChangeNotifier {
  RiderTripGoogleMapProvider() {
    _geolocator = Geolocator();
    _polylinePoints = PolylinePoints();
  }

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

  List<LatLng> _polyLinePositionCoordinate = [];
  List<LatLng> get polyLinePositionCoordinate => _polyLinePositionCoordinate;

  late PolylinePoints _polylinePoints;
  PolylinePoints get polylinePoints => _polylinePoints;

  late Geolocator _geolocator;
  Geolocator get geolocator => _geolocator;

  DriverData _onlineDriverData = DriverData();
  DriverData get onlineDriverData => _onlineDriverData;

  //  Position? _driverCurrentPosition;
  // Position? get driverCurrentPosition => _driverCurrentPosition;

  BitmapDescriptor? _iconAnimatedMarker;
  BitmapDescriptor? get iconAnimatedMarker => _iconAnimatedMarker;

  Position? _onlineDriverCurrentPosition;
  Position? get onlineDriverCurrentPosition => _onlineDriverCurrentPosition;

  String _rideRequeststatus = "accepted";
  String get rideRequeststatus => _rideRequeststatus;

  bool _isDirectionDetailsInfo = false;
  bool get isDirectionDetailsInfo => _isDirectionDetailsInfo;

  StreamSubscription<Position>? _streamSubscriptionPosition;
  StreamSubscription<Position>? _streamSubscriptionDriverLivePosition;

  Position? _driverCurrentPosition;
  Position? get driverCurrentPosition => _driverCurrentPosition;

  GoogleMapController? _newGoogleMapController;
  GoogleMapController? get newGoogleMapController => _newGoogleMapController;

  void setController(GoogleMapController controller) {
    _controllerCompleter.complete(controller);
    notifyListeners();
  }

  void setnewGoogleMapController(GoogleMapController? controller) {
    _newGoogleMapController = controller;
    notifyListeners(); // Notify listeners when the controller is set
  }

  Future<GoogleMapController> get controller => _controllerCompleter.future;

  Future<void> drawPolyLineFromOriginToDestination(
      LatLng originLatLng, LatLng destinationLatLng, context) async {
    createDriverIconMarker(context);
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Please wait.......",
            ));

    var directionDetailsInfo =
        await obtainDirectionDetails(originLatLng, destinationLatLng);

    Navigator.pop(context);
    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList =
        pPoints.decodePolyline(directionDetailsInfo.e_points!);
    _polyLinePositionCoordinate.clear();
    if (decodedPolyLinePointsResultList.isNotEmpty) {
      decodedPolyLinePointsResultList.forEach((PointLatLng pointLatLng) {
        polyLinePositionCoordinate
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    _polylineSet.clear();
    Polyline polyline = Polyline(
        polylineId: PolylineId("PolylineID"),
        color: ColorConfig.primary,
        jointType: JointType.round,
        points: polyLinePositionCoordinate,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        width: 4);

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
        // infoWindow:
        //     InfoWindow(title: originPosition.locationName, snippet: "Origin"),
        position: originLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));

    Marker destinationMarker = Marker(
        markerId: const MarkerId("destinationID"),
        // infoWindow: InfoWindow(
        //     title: destinationPosition.locationName, snippet: "Destination"),
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
    //saveAssignedDriverDetailsToUserRideRe(context);
    notifyListeners();
  }

  saveAssignedDriverDetailsToUserRideRe(var userRideRequestDetails, context) {
    final rider = Provider.of<RiderGoogleMapProvider>(context, listen: false);
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("All Ride Requests")
        .child(userRideRequestDetails!.rideRequestId!);
    Map driverLocationDataMap = {
      "latitude": rider.driverCurrentPosition!.latitude.toString(),
      "longitude": rider.driverCurrentPosition!.longitude.toString()
    };

    if (databaseReference.child("driverID") != "waiting") {
      databaseReference.child("driverLocation").set(driverLocationDataMap);
      databaseReference.child("status").set("accepted");
      databaseReference.child("driverID").set(_onlineDriverData.id);
      databaseReference.child("driverName").set(_onlineDriverData.name);
      databaseReference.child("driverPhone").set(_onlineDriverData.phone);
      databaseReference.child("car_details").set(
          "${_onlineDriverData.car_model} ${_onlineDriverData.car_color} ${_onlineDriverData.car_number}");
    } else {
      toast("This ride is already accepted by another driver");
      Navigator.pop(context);
      // SplashScreen().launch(context, isNewTask: true);
      //rid
    }
  }

  getDriverLocatonRealTime(context, var userRideRequestDetails) {
    LatLng oldLatLng = LatLng(0, 0);
    final rider = Provider.of<RiderGoogleMapProvider>(context, listen: false);
    _streamSubscriptionDriverLivePosition =
        Geolocator.getPositionStream().listen((Position position) {
      _driverCurrentPosition = position;
      _onlineDriverCurrentPosition = position;
      LatLng latLngLiveDriverPosition = LatLng(
          _onlineDriverCurrentPosition!.latitude,
          _onlineDriverCurrentPosition!.longitude);

      Marker animatingMarker = Marker(
          markerId: MarkerId("AnimatedMarker"),
          position: latLngLiveDriverPosition,
          icon: iconAnimatedMarker!,
          infoWindow: InfoWindow(title: "This is your position"));

      CameraPosition cameraPosition =
          CameraPosition(target: latLngLiveDriverPosition, zoom: 18);
      _newGoogleMapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      _markerSet
          .removeWhere((element) => element.markerId.value == "AnimatedMarker");
      _markerSet.add(animatingMarker);

      oldLatLng = latLngLiveDriverPosition;
      //  updateDurationTimeAtRealTime();
      Map driverLatLngDataMap = {
        "latitude": onlineDriverCurrentPosition!.latitude.toString(),
        "longitude": onlineDriverCurrentPosition!.longitude.toString()
      };
      FirebaseDatabase.instance
          .ref()
          .child("All Ride Request")
          .child(userRideRequestDetails!.rideRequestId)
          .child("driverLocation")
          .set(driverLatLngDataMap);
    });

    notifyListeners();
  }

  createDriverIconMarker(context) {
    if (_iconAnimatedMarker == null) {
      ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size(2, 2));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, "assets/icon/car2.png")
          .then((value) {
        _iconAnimatedMarker = value;
      });
    }
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
}
