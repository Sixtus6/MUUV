import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:muuv/config/color.dart';
import 'package:muuv/key/key.dart';
import 'package:muuv/model/direction.dart';
import 'package:muuv/model/direction_info.dart';
import 'package:muuv/model/predictedPlaces.dart';
import 'package:muuv/model/user.dart';
import 'package:muuv/utils/helper.dart';
import 'package:muuv/widget/progress.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

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

  Direction? _userPickUpLocation;

  Direction? _userDropOffLocation;
  Direction? get userPickUpLocation => _userPickUpLocation;
  Direction? get userDropOffLocation => _userDropOffLocation;

  Direction _userPickupaddress = Direction();
  Direction get userPickupaddress => _userPickupaddress;

  int _countTotalTrialTrip = 0;

  List<PredictedPlaces> _placesPredictedList = [];
  List<PredictedPlaces> get placesPredictedList => _placesPredictedList;

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
      UserModel? userData = await getUserFromPrefs();

      _username = userData!.name;
      _email = userData.emailAddress;
      notifyListeners();
    } catch (e) {
      print('Error locating user position: $e');
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
        width: 5,
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
}
