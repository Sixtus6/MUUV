import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:muuv/screens/home/user/provider.dart';
import 'package:provider/provider.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<UserGoogleMapProvider>(context);
    return FutureBuilder(
        future: mapProvider.controller,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GoogleMap(
              onMapCreated: (controller) {
                mapProvider.setController(controller);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 11.0,
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
