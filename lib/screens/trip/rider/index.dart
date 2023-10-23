import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/model/userRequestRideInfo.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/screens/trip/rider/provider.dart';
import 'package:muuv/widget/customModal.dart';
import 'package:muuv/widget/modal.dart';
import 'package:muuv/widget/profile.dart';
import 'package:nb_utils/nb_utils.dart';
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
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding:
                          EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
                      decoration: ShapeDecoration(
                        color: Colors.grey.shade100,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        // Background color of the container
                        shadows: [
                          BoxShadow(
                            color: ColorConfig.secondary, // Border color
                            blurRadius: 1.0, // Border width
                            spreadRadius: 2.0, // Border width
                            offset: Offset(0, 2), // Offset of the border
                          ),
                        ],
                      ),
                      child: Container(
                        //padding: edg,
                        padding:
                            EdgeInsets.all(SizeConfigs.getPercentageWidth(4)),
                        decoration: BoxDecoration(
                          color: ColorConfig.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Passenger Details",
                              style: TextStyle(
                                color: ColorConfig.secondary,
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            // ProfileContainer(
                            //   data: widget.userRideDetails!.userName!,
                            //   image: 'assets/icon/user.png',
                            //   title: 'Passenger Name',
                            // ),
                            CustomModalContainer(
                                image: 'assets/icon/user.png',
                                address: widget.userRideDetails!.userName!,
                                header: "Name"),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            Divider(
                              height: SizeConfigs.getPercentageWidth(1),
                              thickness: 2,
                              color: ColorConfig.primary,
                            ),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            CustomModalContainer(
                                ontap: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      widget.userRideDetails!.userPhone!
                                          .toString());
                                  print("kkd");
                                },
                                call: true,
                                image: 'assets/icon/user.png',
                                address: widget.userRideDetails!.userPhone!,
                                header: "Phone.no"),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            Divider(
                              height: SizeConfigs.getPercentageWidth(1),
                              thickness: 2,
                              color: ColorConfig.primary,
                            ),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            CustomModalContainer(
                              address: widget.userRideDetails!.originAddress !=
                                      null
                                  ? widget.userRideDetails!.originAddress!
                                              .toString()
                                              .length <
                                          40
                                      ? widget.userRideDetails!.originAddress!
                                      : "${widget.userRideDetails!.originAddress!.substring(0, 40)}....."
                                  : 'Pickup Location',
                              header: 'Pickup Location',
                              image: "assets/icon/fromloc.png",
                            ),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            Divider(
                              height: SizeConfigs.getPercentageWidth(1),
                              thickness: 2,
                              color: ColorConfig.primary,
                            ),
                            SizeConfigs.getPercentageWidth(2).toInt().height,
                            CustomModalContainer(
                              address: widget.userRideDetails!
                                          .destinationAddress !=
                                      null
                                  ? widget.userRideDetails!.destinationAddress!
                                              .toString()
                                              .length <
                                          40
                                      ? widget
                                          .userRideDetails!.destinationAddress!
                                      : "${widget.userRideDetails!.destinationAddress!.substring(0, 40)}....."
                                  : 'Destination',
                              header: 'Destination',
                              image: "assets/icon/toloc.png",
                            ),

                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              onPressed: () async {},
                              child: Text(
                                "End Trip",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            );
          },
        ),
      ),
    ));
  }
}
