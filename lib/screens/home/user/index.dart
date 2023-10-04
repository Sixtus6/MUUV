import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/widget/loader.dart';
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
                    onCameraIdle: () {},
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.7749, -122.4194),
                      zoom: 11.0,
                    ),
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
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
                padding: const EdgeInsets.all(90),
                child: Lottie.asset(
                  "assets/lottie/locpin.json",
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
