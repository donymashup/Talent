import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/constants/utils.dart';
import 'package:talent_app/models/course_details_model.dart';
import 'package:talent_app/models/orderDetailsModel.dart';
import 'package:talent_app/models/paymentEnrollmentModel.dart';
import 'package:talent_app/models/promoCodeModel.dart';

class CourseDetailsService {
  Future<CourseDetailsModel?> getCourseDetails({
    required BuildContext context,
    required String courseId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      final response = await _sendPostRequest(
        url: '$baseUrl$courseDetailsUrl',
        fields: {
          'userid': userId!,
          'courseid': courseId,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        final courseDetailsModel = CourseDetailsModel.fromJson(jsonResponse);

        if (courseDetailsModel.type == 'success') {
          //showSnackbar(context, 'Course details fetch success');
          return courseDetailsModel;
        } else {
          showSnackbar(context, 'Course details fetch failed');
          return null;
        }
      } else {
        print("Failed to fetch course details: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error fetching course details: $e");
      print("Exception: $e");
      return null;
    }
  }

  // Helper method to send POST request
  Future<http.StreamedResponse> _sendPostRequest({
    required String url,
    required Map<String, String> fields,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(fields);
    return await request.send();
  }

  Future<PromoCodeDetails?> verifyPromoCode({
    required BuildContext context,
    required String promoCode,
    required String courseId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      final response = await _sendPostRequest(
        url: '$baseUrl$verifyPromoCodeUrl',
        fields: {
          'userid': userId!,
          'courseid': courseId,
          'promo_code': promoCode,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        if (jsonResponse['type'] == 'success') {
         // showSnackbar(context, 'Promo code verified successfully');
          return PromoCodeDetails.fromJson(jsonResponse);
        } else {
          showSnackbar(context, 'Promo code verification failed');
          return null;
        }
      } else {
        print("Failed to verify promo code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error verifying promo code: $e");
      print("Exception: $e");
      return null;
    }
  }

  Future<PaymentErollmentDetails?> freeEnrollment({
    required BuildContext context,
    required String courseId,
    required String promo,
    required String userId,
    required String amount,
  }) async {
    try {
      final response = await _sendPostRequest(
        url: '$baseUrl$freeEnrollStudent',
        fields: {
          'courseid': courseId,
          'promo': promo,
          'userid': userId,
          'amount': amount,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        if (jsonResponse['type'] == 'success') {
          showSnackbar(context, jsonResponse['message']);
          return PaymentErollmentDetails.fromJson(jsonResponse);
        } else {
          showSnackbar(context, jsonResponse['message']);
          return null;
        }
      } else {
        print("Failed to enroll: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error during enrollment: $e");
      print("Exception: $e");
      return null;
    }
  }

  Future<OrderIdDetails?> createOrderId({
    required BuildContext context,
    required String courseId,
    required String promoCode,
    required String amount,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      final response = await _sendPostRequest(
        url: '$baseUrl$createOrderIdUrl',
        fields: {
          'courseid': courseId,
          'promo_code': promoCode,
          'userid': userId!,
          'amount': amount,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }
        debugPrint(jsonResponse.toString());
        if (jsonResponse['type'] == 'success') {
          //showSnackbar(context, jsonResponse['message']);
          return OrderIdDetails.fromJson(jsonResponse);
        } else {
          showSnackbar(context, jsonResponse['message']);
          return null;
        }
      } else {
        print("Failed to create order ID: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error creating order ID: $e");
      print("Exception: $e");
      return null;
    }
  }

  Future<PaymentErollmentDetails?> enrollStudent({
    required BuildContext context,
    required String courseid,
    required String promo_code,
    required String userid,
    required String paymentid,
    required String amount,
    required String orderid,
    required String signature,
  }) async {
    try {
      Map<String, dynamic> request = {
        "courseid": courseid,
        "promo": promo_code,
        "userid": userid,
        "paymentid": paymentid,
        "amount": amount,
        "orderid": orderid,
        "signature": signature
      };

      final response = await _sendPostRequest(
        url: '$baseUrl$enrollStudentUrl',
        fields: request.map((key, value) => MapEntry(key, value.toString())),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        if (jsonResponse['type'] == 'success') {
          showSnackbar(context, 'Enrollment successful');
          return PaymentErollmentDetails.fromJson(jsonResponse);
        } else {
          showSnackbar(context, 'Enrollment failed');
          return null;
        }
      } else {
        print("Failed to enroll: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error during enrollment: $e");
      print("Exception: $e");
      return null;
    }
  }
}
