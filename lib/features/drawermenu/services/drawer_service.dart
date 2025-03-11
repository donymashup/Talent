import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/models/timeLine_model.dart';

class DrawerService {
  Future<TimeLineModel?> getTimeLine({
    required String userId,
    required String date,
  }) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$getTimeLineUrl'));
      request.fields.addAll({'userid': userId, 'date': date});

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        debugPrint('Response: $date');
      //  print("Data fetched");
        return TimeLineModel.fromJson(json.decode(responseBody));
      } else {
        print('Failed to fetch timeline: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
