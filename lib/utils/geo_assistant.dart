import 'package:flutter/material.dart';
import 'package:muuv/model/activeNearByDrivers.dart';

class GeoFireAssistant {
  static List<ActiveNearByDrivers> activeNearDriversList = [];
  
  static void deleteOfflineDriverFromList(String driverId) {
    int indexNumber = activeNearDriversList
        .indexWhere((element) => element.driverID == driverId);

    activeNearDriversList.removeAt(indexNumber);
  }

  static void updateActiveNearByDiver(ActiveNearByDrivers driverswhomove) {
    int indexNumber = activeNearDriversList
        .indexWhere((element) => element.driverID == driverswhomove.driverID);
   
    activeNearDriversList[indexNumber].locationLat = driverswhomove.locationLat;
    activeNearDriversList[indexNumber].locationLong = driverswhomove.locationLong;

  }
}
