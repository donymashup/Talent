// To parse this JSON data, do
//
//     final paymentErollmentDetails = paymentErollmentDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentErollmentDetails paymentErollmentDetailsFromJson(String str) => PaymentErollmentDetails.fromJson(json.decode(str));

String paymentErollmentDetailsToJson(PaymentErollmentDetails data) => json.encode(data.toJson());

class PaymentErollmentDetails {
  final String type;
  final String message;

  PaymentErollmentDetails({
    required this.type,
    required this.message,
  });

  factory PaymentErollmentDetails.fromJson(Map<String, dynamic> json) => PaymentErollmentDetails(
    type: json["type"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "message": message,
  };
}
