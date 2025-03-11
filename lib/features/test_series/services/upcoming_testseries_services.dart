import 'dart:convert';
import 'package:alpha/constants/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:alpha/models/upcoming_testseries_model.dart';

class UpcomingTestseriesServices {
  Future<UpcomingTestsModel?> getUpcomingTests({
    required String userId,
    required BuildContext context,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl$getUpcomingTestsUrl'));

      request.fields.addAll({'userid': userId});

      var response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonData = json.decode(responseBody);
        return UpcomingTestsModel.fromJson(jsonData);
      } else {
        print("Error: ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }
}
