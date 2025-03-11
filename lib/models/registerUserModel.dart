// To parse this JSON data, do
//
// final registerUser = registerUserFromJson(jsonString);

import 'dart:convert';
// import 'dart:ffi';

class RegisterUser {
  final String type;
  final String message;
  final String userid;

  RegisterUser({
    required this.type,
    required this.userid,
    required this.message,
  });

  factory RegisterUser.fromRawJson(String str) => RegisterUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
        type: json["type"],
        message: json["message"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "userid": userid,
      };
}
