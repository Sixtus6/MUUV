import 'dart:convert';

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
    print([userJson.runtimeType, jsonDecode(userJson).runtimeType]);
    final Map<String, dynamic> userMap = jsonDecode(userJson);
    final decoded = UserModel.fromJson(userMap);
    // print(jsonEncode(decoded));
    // print([decoded.runtimeType]);
    return decoded;
  }

  return null;
}
