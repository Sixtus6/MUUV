import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/onboarding/index.dart';
import 'package:muuv/widget/loader.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(children: [
          Consumer<RiderGoogleMapProvider>(builder: (context, provider, _) {
            if (provider.controller != null) {
              return GoogleMap(
                onMapCreated: (controller) {
                  provider.setController(controller);
                  provider.setnewGoogleMapController(controller);

                  provider.locateDriverPosition();
                },
                // onCameraMove: (CameraPosition? position) {
                //   //    print("moving ${provider.pickLocation}");
                //   if (provider.pickLocation != position!.target) {
                //     provider.setpickLocation(position.target);
                //   }
                // },
                // onCameraIdle: () {
                //   provider.getAddressFromLatLng();
                // },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 11.0,
                ),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                // polylines: provider.polylineSet,
                // markers: provider.markerSet,
                // circles: provider.circleSet,
              );
            } else {
              return Center(child: ShimmerLoader());
            }
          })
        ]),
      ),
    ));
  }
}
