import 'dart:convert';
import 'package:alpha/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:alpha/models/upload_image_model.dart';
import 'package:alpha/constants/config.dart';
import 'package:alpha/constants/utils.dart';
import 'package:alpha/models/update_password_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final UserController userController = Get.put(UserController());
  Future<UploadImageModel?> uploadImage({
    required String userId,
    required String filePath,
    required BuildContext context,
  }) async {
    try {
      var headers = {
        'Cookie': 'etcpro_ci_session=p40kq6rqnph1qao8s1k91pj8hubeqc9n'
      };

      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$updateImageUrl'));

      request.fields.addAll({'userid': userId});
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = jsonDecode(responseData);
        var uploadImageModel = UploadImageModel.fromJson(jsonResponse);
        if (uploadImageModel.status == 'success') {
          showSnackbar(context,
              uploadImageModel.message ?? 'Image uploaded successfully');
          String newImageUrl = uploadImageModel.imageUrl;
          userController.updateProfilePicture(newImageUrl);
        } else {
          showSnackbar(
              context, uploadImageModel.message ?? 'Failed to upload image');
        }
        return uploadImageModel;
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<UpdatePassword?> updatePassword({
    required String password,
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      var headers = {
        'Cookie': 'etcpro_ci_session=0icu4nas18rvknq5ah5rg8kfkrjdigvs'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl$updatePasswordUrl'));
      request.fields.addAll({
        'userid': userId ?? '',
        'password': password,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        var updatePassword = UpdatePassword.fromJson(jsonResponse);

        if (updatePassword.type == 'success') {
          showSnackbar(context,
              updatePassword.message ?? 'Password updated successfully');
        } else {
          showSnackbar(
              context, updatePassword.message ?? 'Failed to update password');
        }

        return updatePassword;
      } else {
        print("Failed to update password: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
