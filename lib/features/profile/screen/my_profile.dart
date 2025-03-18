import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/constants/utils.dart';
import 'package:talent_app/features/auth/services/login_service.dart';
import 'package:talent_app/features/profile/services/profile_service.dart';
import 'package:talent_app/models/user_details_model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController passwordController = TextEditingController();
  UserDetailsModel? userDetails;
  bool isLoading = true;
  bool isUploading = false;
  bool isUpdatingPassword = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    if (userId != null) {
      UserDetailsModel? details = await AuthService().getUserDetails(
        userId: userId,
        context: context,
      );

      if (details != null) {
        setState(() {
          userDetails = details;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        isUploading = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString("userId");

      if (userId != null) {
        var response = await ProfileService().uploadImage(
          userId: userId,
          filePath: pickedFile.path,
          context: context,
        );

        if (response != null && response.imageUrl != null) {
          await prefs.setString("profileImage", response.imageUrl);

          setState(() {
            userDetails?.user?.image = 
                "${response.imageUrl}?timestamp=${DateTime.now().millisecondsSinceEpoch}";
          });
        }
      }
      setState(() {
        isUploading = false;
      });
    }
  }

  Future<void> updatePassword() async {
    setState(() => isUpdatingPassword = true);
    if (passwordController.text.isNotEmpty) {
      await ProfileService().updatePassword(
        password: passwordController.text,
        context: context,
      );
      showSnackbar(context, "Password updated successfully");
    } else {
      showSnackbar(context, "Password is empty");
    }
    setState(() {
      passwordController.clear();
      isUpdatingPassword = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        title: Text("My Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
        backgroundColor:Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchUserDetails,
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : (userDetails?.user?.image != null && userDetails!.user!.image!.isNotEmpty
                                ? NetworkImage(userDetails!.user!.image!)
                                : AssetImage('assets/images/default_profile.png')) as ImageProvider,
                      ),
                      if (isUploading)
                        Positioned.fill(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                    ],
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text("Upload Profile Picture", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Personal Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.person, color: AppConstant.primaryColor),
                            title: Text(userDetails?.user?.firstName ?? "Loading..."),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone, color: AppConstant.primaryColor),
                            title: Text(userDetails?.user?.phone ?? "Loading..."),
                          ),
                          ListTile(
                            leading: Icon(Icons.email, color: AppConstant.primaryColor),
                            title: Text(userDetails?.user?.email ?? "Loading..."),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Set New Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isUpdatingPassword ? null : updatePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstant.primaryColor2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: isUpdatingPassword
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Update Password", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
    );
  }
}

