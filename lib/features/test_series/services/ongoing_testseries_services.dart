import 'dart:convert';
import 'package:alpha/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alpha/models/ongoing_testseries_model.dart';
import 'package:alpha/constants/utils.dart';

class OngoingTestseriesServices {
  Future<OngoingTestsModel?> getOngoingTests({
    required String userId,
    required BuildContext context,
  }) async {
    try {
      var url = Uri.parse('$baseUrl$getOngoingTestsUrl');
      var body = {'userid': userId};

      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return OngoingTestsModel.fromJson(jsonResponse);
      } else {
        showSnackbar(context,
            "Failed to fetch ongoing test series: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error fetching ongoing test series: $e");
      return null;
    }
  }
}
