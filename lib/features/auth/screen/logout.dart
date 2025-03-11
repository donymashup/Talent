import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/features/auth/screen/login.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await logout(); // Call logout function
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
  
// Logout function that clears session and navigates to login
Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // Clear session data

  // Navigate back to login screen (GetX handles multiple pops)
  Get.offAll(() => Login());
}
 