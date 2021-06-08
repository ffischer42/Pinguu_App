import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pinguu_bot/model/login_model.dart';
import 'package:pinguu_bot/services/shared_service.dart';

class APIServices {
  static var client = http.Client();
  static String apiURL = 'https://pinguu.tech/wp-json/jwt-auth/v1/token';

  static Future<bool> loginCustomer(String username, String password) async {
    Map<String, String> requestHeaders = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    log(requestHeaders.toString());
    var response = await client.post(
      Uri.parse(apiURL),
      headers: requestHeaders,
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      var jsonString = response.body;
      LoginResponseModel responseModel = loginResponseFromJson(jsonString);

      if (responseModel.statusCode == 200) {
        SharedService.setLoginDetails(responseModel);
      }

      return responseModel.statusCode == 200 ? true : false;
    }

    return false;
  }
}
