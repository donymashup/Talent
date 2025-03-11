
import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/test_series/screens/completed_testseries.dart';
import 'package:talent_app/features/test_series/screens/ongoing_testseries.dart';
import 'package:talent_app/features/test_series/screens/upcoming_testseries.dart';

class TestSeriesTabBarView extends StatefulWidget {
  @override
  _TestSeriesTabBarViewState createState() => _TestSeriesTabBarViewState();
}

class _TestSeriesTabBarViewState extends State<TestSeriesTabBarView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Add listener to update UI while swiping
    _tabController.animation!.addListener(() {
      setState(() {});
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
              _buildTabItem(title: 'Attended', index: 2),
            ],
          ),
        ),
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              OngoingTestSeries(),
              UpcomingTestSeriesScreen(),
              CompletedTestSeriesScreen(),
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
          duration: const Duration(milliseconds: 100),
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
