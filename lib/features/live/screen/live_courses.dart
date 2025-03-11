import 'package:flutter/material.dart';
import 'package:talent_app/common%20widgets/customappbar.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/drawermenu/screens/drawer.dart';
import 'package:talent_app/features/live/widgets/live_custom_tabar.dart';

class LiveClassesScreen extends StatelessWidget {
  const LiveClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: "Live Classes"),
      drawer: DrawerScreen(),
      body: Container(
        color: AppConstant.backgroundColor, // Set the desired background color here
        child: Column(
          children: [
            Expanded(
              child: CustomTabBarView(), // Includes the TabBar and TabBarView
            ),
          ],
        ),
      ),
    );
  }
}
