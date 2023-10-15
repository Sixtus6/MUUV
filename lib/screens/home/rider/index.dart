import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/home/rider/provider.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/screens/onboarding/index.dart';
import 'package:muuv/widget/loader.dart';
import 'package:muuv/widget/modal.dart';
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
        child: Consumer<RiderGoogleMapProvider>(
          builder: (BuildContext context, provider, _) {
            return Stack(children: [
              provider.controller != null
                  ? GoogleMap(
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
                        zoom: 11.5,
                      ),
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      // polylines: provider.polylineSet,
                      // markers: provider.markerSet,
                      // circles: provider.circleSet,
                    )
                  : Center(child: ShimmerLoader()),
              provider.status != "Online"
                  ? Container(
                      color: Colors.black87.withOpacity(0.7),
                    )
                      .withHeight(MediaQuery.of(context).size.height)
                      .withWidth(double.infinity)
                  : Container(),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(155),
                  child: provider.status == "Online"
                      ? Lottie.asset(
                          "assets/lottie/locpin.json",
                        )
                      : Transform.scale(
                          scale: 2,
                          child: Switch.adaptive(
                              activeColor: ColorConfig.primary,
                              value: provider.status == "Online",
                              onChanged: (value) {
                                if (provider.rider != null) {
                                  provider.driverIsOnline();
                                  provider.updateDriversLocationAtRealTime();
                                  provider.setStatus("Online");
                                  toast("You are Online");
                                } else {
                                  toast("Please wait");
                                }
                              }),
                        ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Consumer<RiderGoogleMapProvider>(
                  builder: (BuildContext context, provider, _) {
                    return GestureDetector(
                      onTap: () {
                        print("object");
                        provider.rider != null
                            ? BottomModalRider(context, provider, false)
                            : toast("Please wait");
                      },
                      child: Container(
                                           decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12, // Border color
                              blurRadius: 1.0, // Border width
                              spreadRadius: 1, // Border width
                              // Offset of the border
                            ),
                          ],
                        ),
                        height: SizeConfigs.getPercentageWidth(11),
                        width: SizeConfigs.getPercentageWidth(11),
                        margin: EdgeInsets.only(
                            left: SizeConfigs.getPercentageWidth(4),
                            top: SizeConfigs.getPercentageWidth(4)),
                        padding:
                            EdgeInsets.all(SizeConfigs.getPercentageWidth(2)),
                        child: Image.asset('assets/icon/user.png',
                            color: Colors.black54),
                      ),
                    );
                  },
                ),
              )
            ]);
          },
        ),
      ),
    ));
  }
}
