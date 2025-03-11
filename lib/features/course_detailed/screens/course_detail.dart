import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/controllers/is_subscribed_controller.dart';
import 'package:alpha/features/course_detailed/services/course_details_services.dart';
import 'package:alpha/features/course_detailed/widgets/classes_list.dart';
import 'package:alpha/features/course_detailed/widgets/enroll_button.dart';
import 'package:alpha/features/course_detailed/widgets/overview.dart';
import 'package:alpha/features/course_detailed/widgets/reviews.dart';
import 'package:alpha/models/course_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    child: Image.network(
                      widget.heroImage,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(courseDetails?.details?.name ?? 'Course Name',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            Text(
                                'Duration: ${courseDetails?.details?.duration ?? 'N/A'} Days',
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                        (courseDetails?.details?.price == "0")
                            ? const Text(
                                "Free..",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  height: 1.2,
                                ),
                              )
                            : Text(
                                "\u{20B9} ${courseDetails?.details?.price} /-",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  height: 1.2,
                                ),
                              ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppConstant.primaryColor,
                    ),
                    unselectedLabelColor: AppConstant.titlecolor,
                    labelColor: AppConstant.cardBackground,
                    tabs: const [
                      Tab(text: "Overview"),
                      Tab(text: "Modules"),
                      Tab(text: "Review"),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
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
