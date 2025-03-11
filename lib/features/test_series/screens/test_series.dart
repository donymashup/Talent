import 'package:alpha/common%20widgets/customappbar.dart';
import 'package:alpha/features/drawermenu/screens/drawer.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/test_series/widgets/testseries_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class TestSeriesScreen extends StatelessWidget {
  const TestSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: "Test Series"),
      drawer: const DrawerScreen(),
      backgroundColor: AppConstant.backgroundColor,
      body: Container(
        color: AppConstant.backgroundColor, // Set the desired background color here
        child: Column(
          children: [
            Expanded(
              child: TestSeriesTabBarView(), // Includes the TabBar and TabBarView
            ),
          ],
        ),
      ),
    );
  }
}


