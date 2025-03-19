import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talent_app/common%20widgets/customappbar.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/drawermenu/screens/drawer.dart';
import 'package:talent_app/features/subscribed_courses/screen/class_list.dart';
import 'package:talent_app/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:talent_app/models/user_subscriptions_model.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  late Future<UserSubscriptionsModel?> _futureSubscriptions;

  @override
  void initState() {
    super.initState();
    _futureSubscriptions =
        UserSubscriptionsServices().getUserSubscriptions(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: "My Subscribed Courses"),
      drawer: const DrawerScreen(),
      backgroundColor: AppConstant.backgroundColor,
      body: SafeArea(
        child: FutureBuilder<UserSubscriptionsModel?>(
          future: _futureSubscriptions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData ||
                snapshot.data!.courses == null ||
                snapshot.data!.courses!.isEmpty) {
              return const Center(child: Text("No courses found"));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.courses!.length,
              itemBuilder: (context, index) {
                final course = snapshot.data!.courses![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassList(
                          courseId: course.courseDetails!.courseListId!,
                          courseName: course.courseDetails?.courseListName ??
                              "Course Name",
                          batchId: course.courseDetails!.batchListId!,
                          courseImage: course.courseDetails?.courseListImage ??
                              "assets/images/course1.png",
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 6,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Course Image
                          Hero(
                            tag:
                                "courseImage-${course.courseDetails!.courseListId!}",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    course.courseDetails?.courseListImage ??
                                        "",
                                width: 140, // Increased width
                                height: 100, // Adjusted height
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 140,
                                    height: 100,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/course1.png",
                                  width: 140,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Course Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.courseDetails?.courseListName ??
                                      "Course Name",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),

                                // Rating & Button Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 18),
                                        const SizedBox(width: 5),
                                        Text(
                                          course.avgStars?.toString() ?? "0.0",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ClassList(
                                              courseId: course.courseDetails!
                                                  .courseListId!,
                                              courseName: course.courseDetails
                                                      ?.courseListName ??
                                                  "Course Name",
                                              batchId: course.courseDetails!
                                                  .batchListId!,
                                              courseImage: course.courseDetails
                                                      ?.courseListImage ??
                                                  "assets/images/course1.png",
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppConstant.secondaryColorLight,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        "Explore",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
