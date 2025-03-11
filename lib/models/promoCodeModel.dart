// To parse this JSON data, do
//
//     final promoCodeDetails = promoCodeDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PromoCodeDetails promoCodeDetailsFromJson(String str) => PromoCodeDetails.fromJson(json.decode(str));

String promoCodeDetailsToJson(PromoCodeDetails data) => json.encode(data.toJson());

class PromoCodeDetails {
  final String type;
  final String message;
  final int finalAmount;

  PromoCodeDetails({
    required this.type,
    required this.message,
    required this.finalAmount,
  });

  factory PromoCodeDetails.fromJson(Map<String, dynamic> json) => PromoCodeDetails(
    type: json["type"],
    message: json["message"],
    finalAmount: json["final_amount"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
    "final_amount": finalAmount,
  };
}
