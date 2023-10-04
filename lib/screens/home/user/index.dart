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
    return SafeArea(
      child: Scaffold(
          body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<UserGoogleMapProvider>(
          builder: (context, provider, _) {
            print(provider);
            // ignore: unnecessary_null_comparison

            if (provider.controller != null) {
              return GoogleMap(
                onMapCreated: (controller) {
                  provider.setController(controller);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 11.0,
                ),
              );
            } else {
              return Center(child: ShimmerLoader());
            }
          },
        ),
      )),
    );
  }
}
