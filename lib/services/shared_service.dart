import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pinguu_bot/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("login_details") != "null" ? true : false;
  }

  static Future<LoginResponseModel?> loginDetails() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("login_details") != "null"
        ? LoginResponseModel.fromJson(
            jsonDecode(
              prefs.getString("login_details") as String,
            ),
          )
        : null;
  }

  static Future<void> setLoginDetails(LoginResponseModel? responseModel) async {
    final prefs = await SharedPreferences.getInstance();
    var tmp;
    if (responseModel != null) {
      tmp = jsonEncode(
        responseModel.toJson(),
      );
    } else {
      tmp = "null";
    }

    prefs.setString(
      "login_details",
      tmp,
    );
  }

  static Future<void> logout(BuildContext context) async {
    await setLoginDetails(null);
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
