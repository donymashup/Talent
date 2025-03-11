import 'package:alpha/common%20widgets/customappbar.dart';
import 'package:alpha/features/drawermenu/screens/drawer.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/live/widgets/live_custom_tabar.dart';
import 'package:flutter/material.dart';

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
