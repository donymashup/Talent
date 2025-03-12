import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/auth/services/login_service.dart';
import 'package:talent_app/features/home/screen/home_screen.dart';
import 'package:talent_app/features/live/screen/live_courses.dart';
import 'package:talent_app/features/subscribed_courses/screen/my_courses.dart';
import 'package:talent_app/features/test_series/screens/test_series.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _selectedIndex = 0;

  bool isLoading = true;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MyCourses(),
    const LiveClassesScreen(),
    TestSeriesScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      await AuthService()
          .getUserDetails(userId: userId, context: context)
          .then((value) {
        if (value?.type == "success") {
          setState(() => isLoading = false);
        } else {
          AuthService().logout(context);
        }
      }).catchError((error) {
        AuthService().logout(context);
      });
    } else {
      AuthService().logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: isLoading
          ? null
          : CurvedNavigationBar(
              backgroundColor: AppConstant.backgroundColor,
              color: AppConstant.primaryColorLight,
              animationDuration: const Duration(milliseconds: 300),
              height: 60,
              index: _selectedIndex,
              onTap: _onItemTapped,
              items: <CurvedNavigationBarItem>[
                CurvedNavigationBarItem(
                  child: Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? AppConstant.secondaryColor : Colors.white),
                  label: 'Home',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == 0 ? AppConstant.cardBackground : AppConstant.secondaryColor,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.school_outlined, size: 30, color: _selectedIndex == 1 ? AppConstant.secondaryColor : Colors.white),
                  label: 'My Courses',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == 1 ? AppConstant.cardBackground : AppConstant.secondaryColor,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(Icons.live_tv, size: 30, color: _selectedIndex == 2 ? AppConstant.secondaryColor : Colors.white),
                  label: 'Live',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == 2 ? AppConstant.cardBackground : AppConstant.secondaryColor,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Icon(FluentIcons.clipboard_task_list_16_regular, size: 30, color: _selectedIndex == 3 ? AppConstant.secondaryColor : Colors.white),
                  label: 'Test Series',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _selectedIndex == 3 ? AppConstant.cardBackground : AppConstant.secondaryColor,
                  ),
                ),
              ],
            ),
    );
  }
}