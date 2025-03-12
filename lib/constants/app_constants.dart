import 'package:flutter/material.dart';

class AppConstant {
  static const appName = "Alpha Entrance Academy";
  static const backgroundColor2 = Color.fromARGB(255, 250, 246, 247);
  //static const primaryColor = Color(0xFFD70000);
  static const primaryColor = Color(0xFFEF7B00); // Orange
  static final primaryColorLight = Color(0xFFEF7B00).withOpacity(0.8 ); // Light Orange

  static const secondaryColor = Color(0xFF2F2484); //dart blue
  static final secondaryColorLight = Color(0xFF2F2484).withOpacity(0.7); // Light dart blue

  static const lightGradient = Color.fromARGB(255, 214, 63, 69);
  static const darkGradient = Color.fromARGB(255, 138, 3, 3);
  static const cardBackground = Colors.white;
  static const strokeColor = Color.fromARGB(255, 207, 207, 207);
  static const hindColor = Color.fromARGB(255, 112, 112, 112);
  static const primaryColor2 = Color.fromARGB(255, 239, 32, 40);
  static const primaryColor3 = Color(0xFF323592);
  static const titlecolor = Color(0xFF000000); // Correct black color
  static const subtitlecolor = Color(0xFF989EA7);
  static const shadowColor = Color.fromARGB(255, 202, 188, 188);
  static const buttonupdate = Color(0xFFF6921E);
  static const backgroundColor = Colors.white;
  static const notificationbackground = Color.fromARGB(255, 230, 225, 225);

  // Dots colors
  static const reddot = Color.fromARGB(255, 239, 32, 40);
  static const orangedot = Color(0xFFFFA500);
  static const bluedot = Color(0xFF005DA3);
  static const yellowdot = Color(0xFFFFD700);

  static const OPENAI_API_KEY = " ";

  // Razorpay Api

  static const String RazorPay_key_id = "rzp_live_crfFcS32Hjr52m";
  //

  static const Gradient redWhiteGradient = LinearGradient(
    colors: [AppConstant.cardBackground,AppConstant.cardBackground],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient redDarkeGradient = LinearGradient(
    colors: [primaryColor, darkGradient],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );

  static const Gradient blueDarkeGradient = LinearGradient(
    colors: [Color.fromARGB(255, 0, 68, 215), Color.fromARGB(255, 83, 2, 154)],
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  );
}

class userData {
  static String userid = "";
  static String firstName = "";
  static String lastName = "";
  static String image = "";
  static String email = "";
  static String phone = "";
  static String country = "";
  static String firebase_token = "";
  static String onesignal_token = "";
}
