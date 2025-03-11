import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
     // print("User ID not found in SharedPreferences");
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
          : SafeArea(
              child: Container(
                color: AppConstant.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: GNav(
                  gap: 8,
                  activeColor: AppConstant.primaryColor2,
                  color: Colors.grey,
                  backgroundColor: AppConstant.backgroundColor,
                  tabBackgroundColor: AppConstant.primaryColor2.withAlpha(50),
                  padding: const EdgeInsets.all(16),
                  onTabChange: _onItemTapped,
                  selectedIndex: _selectedIndex,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.school_outlined,
                      text: 'My Courses',
                    ),
                    GButton(
                      icon: Icons.live_tv,
                      text: 'Live',
                    ),
                    GButton(
                      icon: FluentIcons.clipboard_task_list_16_regular,
                      text: 'Test Series',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
