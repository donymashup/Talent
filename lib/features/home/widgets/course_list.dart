// import 'package:alpha/constants/app_constants.dart';
// import 'package:alpha/controllers/selected_course_controller.dart';
// import 'package:alpha/features/course_detailed/screens/course_detail.dart';
// import 'package:alpha/features/home/services/home_service.dart';
// import 'package:alpha/models/available_courses_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../common widgets/loadingIndicator.dart';

// class CourseLists extends StatefulWidget {
//   const CourseLists({super.key});

//   @override
//   _CourseListsState createState() => _CourseListsState();
// }

// class _CourseListsState extends State<CourseLists> {
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
//     return FutureBuilder<AvailableCoursesModel?>(
//       future: _futureCourses,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: LoadingIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('Error fetching categories'));
//         } else if (!snapshot.hasData ||
//             snapshot.data == null ||
//             snapshot.data!.data == null ||
//             snapshot.data!.data!.isEmpty) {
//           return const Center(child: Text('No categories available'));
//         } else {
//           final categories = snapshot.data!.data!;

//           return CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _selectedCategoryIndex = index;
//                             });
//                           },
//                           child: Chip(
//                             label: Text(categories[index].name ?? "No Name"),
//                             backgroundColor: _selectedCategoryIndex == index
//                                 ? Colors.blue
//                                 : Colors.grey[300],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     var course =
//                         categories[_selectedCategoryIndex].courses![index];
//                     return GestureDetector(
//                       onTap: () {
//                         if (course.courseDetails != null) {
//                           Get.find<CourseController>()
//                               .setCourse(course.courseDetails!);
//                           Get.to(() => AnimatedTabBarScreen(
//                                 isSubscribed: false,
//                                 heroImage: course!.courseDetails!.image!,
//                                 heroImageTag: '',
//                               ));
//                         }
//                       },
//                       child: Card(
//                         margin: const EdgeInsets.all(8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         color: AppConstant.cardBackground,
//                         elevation: 5,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               flex: 4,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(10),
//                                 child: Hero(
//                                   tag: "imageCourse",
//                                   child: course.courseDetails?.image != null
//                                       ? Image.network(
//                                           course.courseDetails!.image!,
//                                           width: double.infinity,
//                                           height: 100,
//                                           fit: BoxFit.cover,
//                                           errorBuilder: (context, error,
//                                                   stackTrace) =>
//                                               const Icon(Icons.broken_image),
//                                         )
//                                       : const Icon(Icons.image, size: 80),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Expanded(
//                               flex: 5,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       course.courseDetails?.name ?? "No Name",
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 5),
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.star,
//                                           color: Colors.amber,
//                                           size: 18,
//                                         ),
//                                         SizedBox(width: 5),
//                                         Text(
//                                           course.avgStars.toString(),
//                                           style: TextStyle(fontSize: 16),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   childCount:
//                       categories[_selectedCategoryIndex].courses?.length ?? 0,
//                 ),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }
