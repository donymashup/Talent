import 'dart:io';
import 'package:alpha/constants/utils.dart';
import 'package:alpha/features/auth/services/login_service.dart';
import 'package:alpha/features/profile/services/profile_service.dart';
import 'package:alpha/models/user_details_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alpha/common%20widgets/customappbar.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  /// Fetch user details from API and update UI
  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");

    if (userId != null) {
      UserDetailsModel? details = await AuthService().getUserDetails(
        userId: userId,
        context: context,
      );

      if (details != null) {
        print("Fetched Image URL from API: ${details.user?.image}");

        setState(() {
          userDetails = details;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } else {
      print("User ID not found in SharedPreferences");
    }
  }

  /// Pick an image from the gallery and upload it
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

  /// Update user password
  Future<void> updatePassword() async {
    setState(() {
      isUpdatingPassword = true;
    });

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

  /// Show enlarged profile image in a popup
  void _showFullImage() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: _image != null
                  ? FileImage(_image!)
                  : (userDetails?.user?.image != null &&
                          userDetails!.user!.image!.isNotEmpty
                      ? NetworkImage(userDetails!.user!.image!)
                      : AssetImage('assets/images/default_profile.png')) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppConstant.backgroundColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchUserDetails, // Refresh profile data
          ),
        ],
      ),
      backgroundColor: AppConstant.backgroundColor,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: AppConstant.cardBackground,
                          shadowColor: AppConstant.shadowColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 120,
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                        Positioned(
                          top: -60,
                          child: GestureDetector(
                            onTap: _showFullImage, // Tap to enlarge instead of changing
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundImage: _image != null
                                      ? FileImage(_image!)
                                      : (userDetails?.user?.image != null &&
                                              userDetails!.user!.image!.isNotEmpty
                                          ? NetworkImage(userDetails!.user!.image!)
                                          : AssetImage('assets/images/default_profile.png')) as ImageProvider,
                                ),
                                if (isUploading)
                                  Positioned.fill(
                                    child: CircularProgressIndicator(color: Colors.white),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    /// Upload Image Button
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.primaryColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Upload A Profile Picture',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 40),

                    /// Password Input Field
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Set New Password For Web Portal',
                        labelStyle: TextStyle(color: AppConstant.titlecolor),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstant.strokeColor),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppConstant.primaryColor2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// Update Password Button
                    ElevatedButton(
                      onPressed: isUpdatingPassword ? null : updatePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstant.buttonupdate,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: isUpdatingPassword
                          ? CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Update Password',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
