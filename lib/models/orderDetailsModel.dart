// To parse this JSON data, do
//
//     final orderIdDetails = orderIdDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderIdDetails orderIdDetailsFromJson(String str) =>
    OrderIdDetails.fromJson(json.decode(str));

String orderIdDetailsToJson(OrderIdDetails data) => json.encode(data.toJson());

class OrderIdDetails {
  final String type;
  final String orderid;
  final String message;

  OrderIdDetails({
    required this.type,
    required this.orderid,
    required this.message,
  });

  factory OrderIdDetails.fromJson(Map<String, dynamic> json) => OrderIdDetails(
        type: json["type"],
        orderid: json["orderid"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "orderid": orderid,
        "message": message,
      };
}
