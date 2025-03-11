import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/constants/config.dart';
import 'package:talent_app/controllers/user_controller.dart';
import 'package:talent_app/features/auth/screen/login.dart';
import 'package:talent_app/models/common_model.dart';
import 'package:talent_app/models/login_model.dart';
import 'package:talent_app/models/otp_model.dart';
import 'package:talent_app/models/registerUserModel.dart';
import 'package:talent_app/models/user_details_model.dart';

class AuthService {
  // Login user
  Future<LoginModel?> loginUser({
    required String phone,
    required String code,
    required String password,
    required BuildContext context,
  }) async {
    try {
     // print('Phone: $phone, Code: $code, Password: $password');
      final response = await _sendPostRequest(
        url: "$baseUrl$loginUrl",
        fields: {'phone': phone, 'code': code, 'password': password},
      );

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        final loginModel = LoginModel.fromJson(jsonResponse);

        if (loginModel.type == 'success') {
          await _handleLoginSuccess(context, loginModel);
        } else {
          _showSnackbar(context, loginModel.message!);
        }

        return loginModel;
      } else {
        _handleError(context, 'Failed to login: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _handleError(context, e.toString());
      return null;
    }
  }

  // Get user details
  Future<UserDetailsModel?> getUserDetails({
    required String userId,
    required BuildContext context,
  }) async {
    try {
      final response = await _sendPostRequest(
        url: '$baseUrl$userDetailsUrl',
        fields: {'userid': userId},
      );

      debugPrint('response.statusCode: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        debugPrint('User Details: $jsonResponse');
        final userDetailsModel = UserDetailsModel.fromJson(jsonResponse);
        if (userDetailsModel.type == 'success') {
          debugPrint('User Details: ${userDetailsModel.type}');
          await _saveUserDetailsToPrefs(userDetailsModel);
         // _showSnackbar(context, 'Data fetched');
        } else {
          debugPrint('User Details: ${userDetailsModel.type}');
          _showSnackbar(context, 'Data fetching failed');
        }

        return userDetailsModel;
      } else {
        _handleError(context, 'Failed to fetch data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _handleError(context, e.toString());
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

  // Handle login success
  Future<void> _handleLoginSuccess(
      BuildContext context, LoginModel loginModel) async {
    _showSnackbar(context, 'Login success');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', loginModel.userid!);
    await prefs.setBool('isLoggedIn', true);
    final userId = prefs.getString('userId');
    userData.userid = loginModel.userid!;

    if (userId != null) {
      final userDetails =
          await getUserDetails(userId: userId, context: context);
      if (userDetails != null) {
        // Update UserController with the fetched user details
        final userController = Get.find<UserController>();
        userController.updateUserDetails(userDetails);
      }
    }
  }

  // Handle error
  void _handleError(BuildContext context, String message) {
    _showSnackbar(context, message);
   // print(message);
  }

  // Show snackbar
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Save user details to shared preferences
  Future<void> _saveUserDetailsToPrefs(
      UserDetailsModel userDetailsModel) async {
    final prefs = await SharedPreferences.getInstance();
    final user = userDetailsModel.user!;
    await prefs.setString("firstName", user.firstName!);
    await prefs.setString("lastName", user.lastName!);
    await prefs.setString("email", user.email!);
    await prefs.setString("phone", user.phone!);
    await prefs.setString("country", user.country!);
    await prefs.setString("dob", user.dob!);
    await prefs.setString("image", user.image!);
    await prefs.setString("address", user.address!);
    await prefs.setString("gender", user.gender!);
    await prefs.setString("school", user.school!);
    await prefs.setString("qualification", user.qualification!);

    userData.userid = userDetailsModel.user!.id.toString();
    userData.firstName = userDetailsModel.user!.firstName.toString();
    userData.lastName = userDetailsModel.user!.lastName.toString();
    userData.image = userDetailsModel.user!.image.toString();
    userData.email = userDetailsModel.user!.email.toString();
    userData.phone = userDetailsModel.user!.phone.toString();
    userData.country = userDetailsModel.user!.country.toString();
    debugPrint('User Data: ${userData.userid}');
  }

  // Logout User and Clear Session
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    userData.userid = '';
    userData.firstName = '';
    userData.lastName = '';
    userData.image = '';
    userData.email = '';
    userData.phone = '';
    userData.country = '';
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  // Check if User is Logged In
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<CommonModel> isRegistrationEnabled() async {
    try {
      final response = await _sendPostRequest(
        url: '$baseUrl$isRegistrationEnabledUrl',
        fields: {},
      );

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        final commonModel = CommonModel.fromJson(jsonResponse);
        return commonModel;
      } else {
        return CommonModel(type: 'error', message: 'Failed to fetch data');
      }
    } catch (e) {
      return CommonModel(type: 'error', message: e.toString());
    }
  }

  Future<OtpModel> sendOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _sendPostRequest(
        url: '$baseUrl$sendOtpUrl',
        fields: {'phone': phone, 'code': code},
      );
      debugPrint('Phone: $phone, Code: $code');
      debugPrint('response: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        debugPrint('response.stream: $responseBody');
        final jsonResponse = json.decode(responseBody);
        debugPrint('jsonResponse: $jsonResponse');
        final otpModel = OtpModel.fromJson(jsonResponse);
        return otpModel;
      } else {
        return OtpModel(type: 'error1', otp: 'Failed to fetch data');
      }
    } catch (e) {
      return OtpModel(type: 'error2', otp: e.toString());
    }
  }

  Future<RegisterUser> registerUser({
    required BuildContext context,
    mobileNumber = String,
    countryCode = String,
    firstName = String,
    lastName = String,
    emailId = String,
    school = String,
    password = String,
    classIDName = String,
  }) async {
    Map<String, dynamic> request = {
      "phone": mobileNumber,
      "code": countryCode,
      "firstname": firstName,
      "lastname": lastName,
      "email": emailId,
      "school": school,
      "password": password,
      "class": classIDName,
    };
    final uri = Uri.parse(baseUrl + registerUserUrl);
    debugPrint("registerUser: $request");

    try {
      final response = await http.post(uri, body: request);
      debugPrint("$response");
      debugPrint(response.statusCode.toString());
      if (200 == response.statusCode) {
        final RegisterUser registerUser =
            RegisterUser.fromRawJson(response.body);

        debugPrint("registerUser: $registerUser");
        if (registerUser.type == 'success') {
          await _handleRegisterSuccess(context, registerUser);
        } else {
          _showSnackbar(context, registerUser.message);
        }

        return registerUser;
      } else {
        throw Exception("Cannot Load... try after Sometimes");
      }
    } catch (e) {
      throw Exception("$e");
    }
  }

  // Handle login success
  Future<void> _handleRegisterSuccess(
      BuildContext context, RegisterUser registerUser) async {
    _showSnackbar(context, 'Login success');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', registerUser.userid);
    await prefs.setBool('isLoggedIn', true);
    final userId = prefs.getString('userId');
    userData.userid = registerUser.userid;

    if (userId != null) {
      final userDetails =
          await getUserDetails(userId: userId, context: context);
      if (userDetails != null) {
        // Update UserController with the fetched user details
        final userController = Get.find<UserController>();
        userController.updateUserDetails(userDetails);
      }
    }
  }
}
