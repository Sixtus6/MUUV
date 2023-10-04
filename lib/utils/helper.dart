import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:muuv/model/user.dart';
import 'package:nb_utils/nb_utils.dart';

Future<void> saveUserToPrefs(UserModel model) async {
  final userJson = jsonEncode(model);

  await setValue("user", userJson);
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
    return null;
    print("error on http helper: ${e})");
  }
}
