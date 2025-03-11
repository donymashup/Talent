import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/constants/utils.dart';
import 'package:talent_app/models/notification_model.dart';

class NotificationServices {
  Future<NotificationModel?> getNotifications({
   // required String userId,
    required BuildContext context,
  }) async {
    String userId = userData.userid;
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + getNotificationsUrl),
      );

      request.fields['userid'] = userId;

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        return NotificationModel.fromJson(json.decode(responseBody));
      } else {
        showSnackbar(
            context, "Failed to fetch notifications: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error fetching notifications: $e");
      return null;
    }
  }
}
