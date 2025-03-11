import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/live/screen/recordings_courses.dart';
import 'package:talent_app/features/live/screen/upcoming_courses.dart';
import '../screen/ongoing_courses.dart';

class CustomTabBarView extends StatefulWidget {
  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to update UI while swiping
    _tabController.animation!.addListener(() {
      setState(() {}); // Rebuild UI when tab animation progresses
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom TabBar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabItem(title: 'Ongoing', index: 0),
              _buildTabItem(title: 'Upcoming', index: 1),
              _buildTabItem(title: 'Recording', index: 2),
            ],
          ),
        ),
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              OngoingClasses(),
              UpcomingCourses(),
              RecordingsCourses(),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget for tab item
  Widget _buildTabItem({required String title, required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100), // Smooth transition
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _tabController.index == index ? AppConstant.primaryColor2 : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: _tabController.index == index ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
