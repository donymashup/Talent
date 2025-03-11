import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:talent_app/bindings/app_bindings.dart';
import 'package:talent_app/common%20widgets/bottom_navigation_bar.dart';
import 'package:talent_app/common%20widgets/splash_screen.dart';
import 'package:talent_app/constants/app_constants.dart';
// import 'package:tpstreams_player_sdk/tpstreams_player_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TPStreamsSDK.initialize(provider: PROVIDER.tpstreams, orgCode: "85xd8j");

  // Check if user is logged in
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  debugPrint("isLoggedIn: $isLoggedIn");

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstant.primaryColor),
        useMaterial3: true,
      ),
      initialBinding: AppBindings(),
      home: isLoggedIn ? CustomBottomNavigation() : SplashScreen(),
      // home: CheckoutScreen(),
    );
  }
}
