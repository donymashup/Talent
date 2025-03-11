import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/quiz/screen/quiz_info.dart';
import 'package:talent_app/models/course_details_model.dart';

class ClassesList extends StatelessWidget {
  final CourseDetailsModel courseDetailsModel;

  ClassesList({super.key, required this.courseDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListView.builder(
          itemCount: courseDetailsModel.chapters?.length ?? 0,
          itemBuilder: (context, index) {
            final chapter = courseDetailsModel.chapters![index];

            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                color: AppConstant.cardBackground,
                elevation: 4,
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(LucideIcons.bookOpen, color: Colors.teal),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          chapter.chapName ?? "No Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Row(
                      children: [
                        Text(chapter.className ?? "No Class",
                            style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 10),
                        Text(chapter.subjectName ?? "No Subject",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  children: [
                    _buildListSection('Videos', chapter.contents?.videos ?? [],
                        LucideIcons.video, Colors.redAccent),
                    Divider(),
                    _buildListSection('PDFs', chapter.contents?.pdf ?? [],
                        LucideIcons.file, Colors.blueAccent),
                    Divider(),
                    _buildListSection('Tests', chapter.contents?.test ?? [],
                        LucideIcons.checkSquare, Colors.green),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListSection(
      String title, List<ContentItem> items, IconData icon, Color iconColor) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon, color: iconColor),
          SizedBox(width: 8),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        if (title == "Tests") {
                          // Navigate only for Tests
                          Get.to(() => QuizInfo());
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(item.contentName ?? "No Name")),
                          item.status == 'free'
                              ? Icon(Icons.play_circle_outline,
                                  size: 20, color: Colors.green)
                              : Icon(Icons.lock_outline,
                                  size: 20, color: Colors.grey),
                          // item.status =='free' ? 'free' : 'paid',
                          // Obx(() {
                          // final controller =
                          //   Get.find<IsSubscribedController>();
                          // return controller.isSubscribed.value
                          //   ? (item.isPaid
                          //     ? Icon(Icons.lock_outline,
                          //       size: 20, color: Colors.grey)
                          //     : Icon(Icons.play_circle_outline,
                          //       size: 20, color: Colors.green))
                          //   : Icon(Icons.lock_outline,
                          //     size: 20, color: Colors.grey);
                          // }),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
