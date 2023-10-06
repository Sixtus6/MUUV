import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:muuv/config/color.dart';
import 'package:muuv/config/size.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:muuv/widget/constant.dart';
import 'package:muuv/widget/loader.dart';
import 'package:muuv/widget/modal.dart';
import 'package:muuv/widget/placetitle.dart';
import 'package:muuv/widget/textfield.dart';
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
                    //  fortyFiveDegreeImageryEnabled: true,
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
                  padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(3)),
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
                    padding: EdgeInsets.all(SizeConfigs.getPercentageWidth(4)),
                    decoration: BoxDecoration(
                      color: ColorConfig.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      children: [
                        Consumer<UserGoogleMapProvider>(
                          builder: (BuildContext context, provider, _) {
                            print([
                              provider.userPickUpLocation,
                              provider.userDropOffLocation
                            ]);
                            if (provider.userPickUpLocation == null) {
                              return Container();
                            } else {
                              return Column(
                                children: [
                                  CustomModalContainer(
                                    address: provider.userPickUpLocation!
                                                .locationName!
                                                .toString()
                                                .length <
                                            40
                                        ? "Loading......"
                                        : provider.userPickUpLocation!
                                                .locationName!
                                                .substring(0, 40) +
                                            ".....",
                                    header: 'From',
                                    image: "assets/icon/fromloc.png",
                                  ),
                                  SizeConfigs.getPercentageWidth(2)
                                      .toInt()
                                      .height,
                                  Divider(
                                    height: SizeConfigs.getPercentageWidth(1),
                                    thickness: 2,
                                    color: ColorConfig.primary,
                                  ),
                                  SizeConfigs.getPercentageWidth(2)
                                      .toInt()
                                      .height,
                                  GestureDetector(
                                    onTap: () {
                                      provider.userPickUpLocation!.locationName!
                                                  .toString()
                                                  .length <
                                              40
                                          ? toast("Choose your from location")
                                          : BottomModal(context, provider);
                                    },
                                    child: CustomModalContainer(
                                      address:
                                          provider.userDropOffLocation != null
                                              ? provider.userDropOffLocation!
                                                          .locationName!
                                                          .toString()
                                                          .length <
                                                      40
                                                  ? provider
                                                      .userDropOffLocation!
                                                      .locationName!
                                                  : provider
                                                          .userDropOffLocation!
                                                          .locationName!
                                                          .substring(0, 40) +
                                                      "....."
                                              : 'What is your destination?',
                                      header: 'To',
                                      image: "assets/icon/toloc.png",
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}

class CustomModalContainer extends StatelessWidget {
  const CustomModalContainer({
    super.key,
    required this.image,
    required this.address,
    required this.header,
  });

  final String image;
  final String address;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          // padding: EdgeInsets.all(10),
          child: Image.asset(
            image,
            color: ColorConfig.primary,
          ),
        ),
        SizeConfigs.getPercentageWidth(2).toInt().width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: ColorConfig.primary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              address,
              style: TextStyle(
                color: ColorConfig.secondary,
                fontSize: 13,
              ),
            ),
          ],
        )
      ],
    );
  }
}
