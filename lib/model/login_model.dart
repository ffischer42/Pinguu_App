import 'dart:convert';

LoginResponseModel loginResponseFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  late bool success;
  late int statusCode;
  late String code;
  late String message;
  late Data data;

  LoginResponseModel(
      {required this.success,
      required this.statusCode,
      required this.code,
      required this.message,
      required this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = json['data'].length > 0
        ? new Data.fromJson(json['data'])
        : new Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token = "";
  int id = 0;
  String email = "";
  String nicename = "";
  String firstName = "";
  String lastName = "";
  String displayName = "";

  Data({
    required this.token,
    required this.id,
    required this.email,
    required this.nicename,
    required this.firstName,
    required this.lastName,
    required this.displayName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? json['token'] : "";
    id = json['id'] != null ? json['id'] : 0;
    email = json['email'] != null ? json['email'] : "";
    nicename = json['nicename'] != null ? json['nicename'] : "";
    firstName = json['firstName'] != null ? json['firstName'] : "";
    lastName = json['lastName'] != null ? json['lastName'] : "";
    displayName = json['displayName'] != null ? json['displayName'] : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['nicename'] = this.nicename;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['displayName'] = this.displayName;
    return data;
  }
}
