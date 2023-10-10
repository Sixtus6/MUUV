import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:muuv/model/rider.dart';
import 'package:muuv/model/user.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:math' as math;

Future<void> saveUserToPrefs(UserModel model) async {
  final userJson = jsonEncode(model);

  await setValue("user", userJson);
  print("saved to shared preferences");
}

Future<void> saveRiderToPrefs(RiderModel model) async {
  final userJson = jsonEncode(model);

  await setValue("rider", userJson);
  print("saved to shared preferences");
}

Future<UserModel?> getUserFromPrefs() async {
  final userJson = getStringAsync("user");
  if (userJson != null) {
    print([userJson.runtimeType, jsonDecode(userJson)]);
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    final decoded = UserModel.fromJson(userMap);
    // // print(jsonEncode(decoded));
    // print([decoded.runtimeType]);
    // print([decoded]);
    return decoded;
  }

  return null;
}

Future<dynamic> receiveRequest(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  try {
    if (response.statusCode == 200) {
      String responseBody = response.body;
      var decodedResponse = jsonDecode(responseBody);
      return decodedResponse;
    } else {
      return null;
    }
  } catch (e) {
    print("error on http helper: ${e})");
    return null;
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // Calculate the distance between two points (in meters)
  // You can use a more accurate distance calculation method if needed
  const double radius = 6371000.0; // Earth radius in meters
  double dLat = (lat2 - lat1) * (3.14159265359 / 180.0);
  double dLon = (lon2 - lon1) * (3.14159265359 / 180.0);
  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1 * (3.14159265359 / 180.0)) *
          math.cos(lat2 * (3.14159265359 / 180.0)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  return radius * c;
}

double calculatePaddingBasedOnDistance(LatLngBounds bounds) {
  // Calculate the distance between the northeast and southwest points of the bounds
  double distance = calculateDistance(
    bounds.northeast.latitude,
    bounds.northeast.longitude,
    bounds.southwest.latitude,
    bounds.southwest.longitude,
  );

  // Adjust the padding based on the distance
  // You can adjust these values based on your requirements
  double padding = 80; // Default padding

  if (distance < 10000) {
    print(distance);

    if (distance < 1000) {
      padding = 150;
    } else if (distance > 4000) {
      padding = 65;
    } else if (distance > 2000) {
      padding = 90;
    }
    // padding =  ? 150 : 100;
    // // ? distance > 2500
    //     ? 70
    //     : 80
    // : 150; // Adjust for closer distances
  } else if (distance < 20000) {
    padding = 65; // Adjust for mid-range distances
  }

  return padding;
}


