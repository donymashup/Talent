import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/controllers/is_subscribed_controller.dart';
import 'package:talent_app/features/course_detailed/services/course_details_services.dart';
import 'package:talent_app/features/course_detailed/widgets/classes_list.dart';
import 'package:talent_app/features/course_detailed/widgets/enroll_button.dart';
import 'package:talent_app/features/course_detailed/widgets/overview.dart';
import 'package:talent_app/features/course_detailed/widgets/reviews.dart';
import 'package:talent_app/models/course_details_model.dart';

class AnimatedTabBarScreen extends StatefulWidget {
  final bool isSubscribed;
  final String heroImage;
  final String heroImageTag;
  final String courseId;
  const AnimatedTabBarScreen({
    super.key,
    required this.isSubscribed,
    required this.heroImage,
    required this.heroImageTag,
    required this.courseId,
  });
  @override
  _AnimatedTabBarScreenState createState() => _AnimatedTabBarScreenState();
}

class _AnimatedTabBarScreenState extends State<AnimatedTabBarScreen>
    with SingleTickerProviderStateMixin {
  final IsSubscribedController controller = Get.find();
  late TabController _tabController;
  late Future<CourseDetailsModel?> _futureCourseDetails;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    controller.setVisibility(widget.isSubscribed);
    _futureCourseDetails = futureCourseDetails(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<CourseDetailsModel?> futureCourseDetails(BuildContext context) async {
    CourseDetailsService courseDetailsService = CourseDetailsService();
    return await courseDetailsService.getCourseDetails(
        context: context, courseId: widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CourseDetailsModel?>(
      future: _futureCourseDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('No data available')),
          );
        } else {
          final courseDetails = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Hero(
                    tag: widget.heroImageTag,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Image.network(
                        widget.heroImage,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(courseDetails?.details?.name ?? 'Course Name',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text(
                                'Duration: ${courseDetails?.details?.duration ?? 'N/A'} Days',
                                style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            (courseDetails?.details?.price == "0")
                                ? "Free"
                                : "\u{20B9} ${courseDetails?.details?.price} /-",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppConstant.primaryColor,
                      ),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.white,
                      tabs: const [
                        Tab(text: "Overview"),
                        Tab(text: "Modules"),
                        Tab(text: "Review"),
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        OverviewTab(
                          description: courseDetails?.description ??
                              "No description available",
                        ),
                        ClassesList(courseDetailsModel: courseDetails!),
                        ReviewTab(courseDetailsModel: courseDetails),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EnrollButton(courseDetailsModel: courseDetails),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
