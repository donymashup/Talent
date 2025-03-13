// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:lottie/lottie.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:talent_app/common%20widgets/customappbar.dart';
// import 'package:talent_app/constants/app_constants.dart';
// import 'package:talent_app/controllers/selected_course_controller.dart';
// import 'package:talent_app/controllers/user_controller.dart';
// import 'package:talent_app/features/course_detailed/screens/course_detail.dart';
// import 'package:talent_app/features/drawermenu/screens/drawer.dart';
// import 'package:talent_app/features/home/services/home_service.dart';
// import 'package:talent_app/features/home/widgets/carousel.dart';
// import 'package:talent_app/features/home/widgets/search_field.dart';
// import 'package:talent_app/features/subscribed_courses/screen/class_list.dart';
// import 'package:talent_app/models/available_courses_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final UserController userController = Get.put(UserController());
//   late Future<AvailableCoursesModel?> _futureCourses;
//   int _selectedCategoryIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _futureCourses = fetchCourses(context);
//   }

//   Future<AvailableCoursesModel?> fetchCourses(BuildContext context) async {
//     HomeService homeService = HomeService();
//     return await homeService.getAvailableCourses(context: context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Obx(() =>
//             CustomAppBar(appbarTitle: "Hello, ${userController.username}")),
//       ),
//       drawer: const DrawerScreen(),
//       body: Container(
//         color: AppConstant.backgroundColor,
//         child: CustomScrollView(
//           slivers: [
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     const SizedBox(height: 5),
//                     const SearchField(),
//                     const SizedBox(height: 10),
//                     const CarouselImage(),
//                     const SizedBox(height: 20),
//                     _categoryHeader(),
//                     const SizedBox(height: 10),
//                     _courseList()
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _categoryHeader() {
//     return FutureBuilder<AvailableCoursesModel?>(
//       future: _futureCourses,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData ||
//             snapshot.data == null ||
//             snapshot.data!.data == null ||
//             snapshot.data!.data!.isEmpty) {
//           return Center(child: Text('No categories available'));
//         } else {
//           final categories = snapshot.data!.data!;
//           return SizedBox(
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: ChoiceChip(
//                     label: Text(categories[index].name ?? "No Name"),
//                     selected: _selectedCategoryIndex == index,
//                     onSelected: (selected) {
//                       setState(() {
//                         _selectedCategoryIndex = index;
//                       });
//                     },
//                     selectedColor: Colors.blue,
//                     backgroundColor: Colors.grey[300],
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// Widget _courseList() {
//   return FutureBuilder<AvailableCoursesModel?>(
//     future: _futureCourses,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       } else if (!snapshot.hasData ||
//           snapshot.data == null ||
//           snapshot.data!.data == null ||
//           snapshot.data!.data!.isEmpty) {
//         return Center(child: Text('No courses available'));
//       } else {
//         final courses = snapshot.data!.data![_selectedCategoryIndex].courses;
//         if (courses == null || courses.isEmpty) {
//           return Center(child: Text('No courses available in this category'));
//         }
//         return GridView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//             childAspectRatio: 1.2,
//           ),
//           itemCount: courses.length,
//           itemBuilder: (context, index) {
//             final course = courses[index];
//             return GestureDetector(
//               onTap: () => _navigateToCourseDetail(context, course),
//               child: Card(
//                 margin: const EdgeInsets.all(8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 elevation: 5,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
//                       child: CachedNetworkImage(
//                         imageUrl: course.courseDetails?.image ?? '',
//                         height: 100,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Shimmer.fromColors(
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[100]!,
//                           child: Container(height: 100, width: double.infinity, color: Colors.white),
//                         ),
//                         errorWidget: (context, url, error) => const Icon(Icons.broken_image),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             course.courseDetails?.name ?? 'No Name',
//                             style: const TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             children: [
//                               const Icon(Icons.star, color: Colors.amber, size: 16),
//                               const SizedBox(width: 5),
//                               Text(
//                                 course.avgStars.toString(),
//                                 style: const TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }
//     },
//   );
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talent_app/common%20widgets/customappbar.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/controllers/selected_course_controller.dart';
import 'package:talent_app/controllers/user_controller.dart';
import 'package:talent_app/features/course_detailed/screens/course_detail.dart';
import 'package:talent_app/features/drawermenu/screens/drawer.dart';
import 'package:talent_app/features/home/services/home_service.dart';
import 'package:talent_app/features/home/widgets/carousel.dart';
import 'package:talent_app/features/home/widgets/search_field.dart';
import 'package:talent_app/features/subscribed_courses/screen/class_list.dart';
import 'package:talent_app/models/available_courses_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.put(UserController());
  late Future<AvailableCoursesModel?> _futureCourses;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _futureCourses = fetchCourses(context);
  }

  Future<AvailableCoursesModel?> fetchCourses(BuildContext context) async {
    HomeService homeService = HomeService();
    return await homeService.getAvailableCourses(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => CustomAppBar(appbarTitle: "Hello, ${userController.username}")),
      ),
      drawer: const DrawerScreen(),
      body: Container(
        color: AppConstant.backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 5),
                  const SearchField(),
                  const SizedBox(height: 10),
                  const CarouselImage(),
                  const SizedBox(height: 20),
                  _categoryHeader(),
                  const SizedBox(height: 10),
                  _courseList(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

 // ...existing code...
Widget _categoryHeader() {
  return FutureBuilder<AvailableCoursesModel?>(
    future: _futureCourses,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
        return Center(child: Text('No categories available'));
      } else {
        final categories = snapshot.data!.data!;
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ChoiceChip(
                  label: Text(
                    categories[index].name ?? "No Name",
                    style: TextStyle(
                      color: _selectedCategoryIndex == index ? Colors.white : Colors.black,
                    ),
                  ),
                  selected: _selectedCategoryIndex == index,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  selectedColor: AppConstant.secondaryColorLight,
                  backgroundColor: Colors.grey[300],
                  checkmarkColor: Colors.white, // Set tick color to white
                ),
              );
            },
          ),
        );
      }
    },
  );
}

// ...existing code...

Widget _courseList() {
  return FutureBuilder<AvailableCoursesModel?>(
    future: _futureCourses,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
        return Center(child: Text('No courses available'));
      } else {
        final courses = snapshot.data!.data![_selectedCategoryIndex].courses;
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1, // Fixed overflow by increasing card height
          ),
          itemCount: courses?.length,
          itemBuilder: (context, index) {
            final course = courses?[index];
            return GestureDetector(
              onTap: () => _navigateToCourseDetail(context, course),
              child: Card(
                color: Colors.white, // Add background color here
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: course?.courseDetails?.image ?? '',
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(height: 120, width: double.infinity, color: Colors.white),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course?.courseDetails?.name ?? 'No Name',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 5),
                              Text(course!.avgStars.toString(),
                                  style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    },
  );
}

// ...existing code...


void _navigateToCourseDetail(BuildContext context, dynamic course) {
  if (course.courseDetails != null) {
    if (course.subscribed! != true) {
      Get.find<CourseController>().setCourse(course.courseDetails!);
      Get.to(() => AnimatedTabBarScreen(
          isSubscribed: course.subscribed!,
          heroImage: course.courseDetails!.image!,
          courseId: course.courseDetails!.id!,
          heroImageTag: "imageCourse-${course.courseDetails?.id}"));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassList(
            courseId: course.courseDetails!.id!,
            courseName: course.courseDetails?.name ?? "Course Name",
            batchId: course.batchid!,
            courseImage: course.courseDetails?.image ?? "assets/images/course1.png",
          ),
        ),
      );
    }
  }
}
}