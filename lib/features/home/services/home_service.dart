import 'dart:convert';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/constants/config.dart';
import 'package:alpha/constants/utils.dart';
import 'package:alpha/models/available_courses_model.dart';
import 'package:alpha/models/slider_images_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeService {
  // Get available courses
  Future<AvailableCoursesModel?> getAvailableCourses({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      debugPrint('userid ${userData.userid}');
      final response = await _sendPostRequest(
        url: '$baseUrl$availableCourseUrl',
        fields: {'userid': userId!},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());

        debugPrint("jsonResponse: $jsonResponse");
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        final availableCoursesModel =
            AvailableCoursesModel.fromJson(jsonResponse);

        if (availableCoursesModel.type == 'success') {
        // showSnackbar(context, 'Course fetch success');

          if (availableCoursesModel.data != null &&
              availableCoursesModel.data!.isNotEmpty) {
          //  print("Data received: ${availableCoursesModel.data![0].name}");
          } else {
          //  print("No courses available.");
          }

          return availableCoursesModel;
        } else {
          showSnackbar(context, 'Course fetch failed');
          return null;
        }
      } else {
       // print("Failed to fetch courses: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error fetching courses: $e");
      //print("Exception: $e");
      return null;
    }
  }

  // Get slider images
  Future<SliderImagesModel?> getSliderImages({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      final response = await _sendPostRequest(
        url: '$baseUrl$sliderImagesUrl',
        fields: {'userid': userId!},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());

        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        }

        final sliderImagesModel = SliderImagesModel.fromJson(jsonResponse);

        if (sliderImagesModel.type == 'success') {
         // showSnackbar(context, 'Slider images fetch success');

          if (sliderImagesModel.sliders != null &&
              sliderImagesModel.sliders!.isNotEmpty) {
          //  print("Data received: ${sliderImagesModel.sliders![0].title}");
          } else {
          //  print("No slider images available.");
          }

          return sliderImagesModel;
        } else {
          showSnackbar(context, 'Slider images fetch failed');
          return null;
        }
      } else {
     //   print("Failed to fetch slider images: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error fetching slider images: $e");
    //  print("Exception: $e");
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
}
