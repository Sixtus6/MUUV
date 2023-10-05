import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/widget/loader.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<UserGoogleMapProvider>(context);
    // UserGoogleMapProvider userGoogleMapProvider = UserGoogleMapProvider();
    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Consumer<UserGoogleMapProvider>(
              builder: (context, provider, _) {
                print(provider);

                // ignore: unnecessary_null_comparison
                if (provider.controller != null) {
                  return GoogleMap(
                    onMapCreated: (controller) {
                      provider.setController(controller);
                      provider.setnewGoogleMapController(controller);

                      provider.locateUserPosition();
                    },
                    onCameraMove: (CameraPosition? position) {
                      if (provider.pickLocation != position!.target) {
                        provider.setpickLocation(position.target);
                      }
                    },
                    onCameraIdle: () {
                      provider.getAddressFromLatLng();
                    },
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.7749, -122.4194),
                      zoom: 11.0,
                    ),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    polylines: provider.polylineSet,
                    markers: provider.markerSet,
                    circles: provider.circleSet,
                  );
                } else {
                  return Center(child: ShimmerLoader());
                }
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(155),
                child: Lottie.asset(
                  "assets/lottie/locpin.json",
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  child: Container(
                    //padding: edg,
                    padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(11)),
                    decoration: BoxDecoration(
                      color: ColorConfig.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    // Background color of the container
                    shadows: [
                      BoxShadow(
                        color: ColorConfig.primary, // Border color
                        blurRadius: 1.0, // Border width
                        spreadRadius: 2.0, // Border width
                        offset: Offset(0, 2), // Offset of the border
                      ),
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
