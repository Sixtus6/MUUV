import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/model/userRequestRideInfo.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/trip/rider/provider.dart';
import 'package:provider/provider.dart';

class RiderTripScreen extends StatefulWidget {
  RiderTripScreen({this.userRideDetails});

  UserRequestRideInfo? userRideDetails;
  @override
  State<RiderTripScreen> createState() => _RiderTripScreenState();
}

class _RiderTripScreenState extends State<RiderTripScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<RiderTripGoogleMapProvider>(
          builder: (BuildContext context, provider, _) {
            //    provider.createDriverIconMarker(context, widget.userRideDetails);
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: provider.kGooglePlex,
                  markers: provider.markerSet,
                  circles: provider.circleSet,
                  polylines: provider.polylineSet,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  onMapCreated: (controller) {
                    provider.setController(controller);
                    provider.setnewGoogleMapController(controller);
                    final rider = Provider.of<RiderGoogleMapProvider>(context,
                        listen: false);
                    var driverCurrentLatLng = LatLng(
                        rider.driverCurrentPosition!.latitude,
                        rider.driverCurrentPosition!.longitude);

                    var userPickUpLatLng = widget.userRideDetails!.originLatLng;
                    provider.drawPolyLineFromOriginToDestination(
                        driverCurrentLatLng, userPickUpLatLng!, context);
                    provider.getDriverLocatonRealTime(
                        context, widget.userRideDetails!);

                    //draw polyline
                  },
                )
              ],
            );
          },
        ),
      ),
    ));
  }
}
