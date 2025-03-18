
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
      child: ListView.builder(
        itemCount: courseDetailsModel.chapters?.length ?? 0,
        itemBuilder: (context, index) {
          final chapter = courseDetailsModel.chapters![index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              elevation: 5,
              child: ExpansionTile(
                leading: Icon(LucideIcons.book, color: Colors.orangeAccent),
                title: Text(
                  chapter.chapName ?? "No Name",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                subtitle: Text(
                  '${chapter.className ?? "No Class"} | ${chapter.subjectName ?? "No Subject"}',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                children: [
                  Container(
                    color: Colors.deepPurple.shade50,
                    child: _buildListSection('Videos', chapter.contents?.videos ?? [],
                        LucideIcons.playCircle, Colors.deepPurpleAccent),
                  ),
                  Divider(),
                  Container(
                    color: Colors.blue.shade50,
                    child: _buildListSection('PDFs', chapter.contents?.pdf ?? [],
                        LucideIcons.fileText, Colors.blue),
                  ),
                  Divider(),
                  Container(
                    color: Colors.green.shade50,
                    child: _buildListSection('Tests', chapter.contents?.test ?? [],
                        LucideIcons.checkCircle, Colors.green),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListSection(
      String title, List<ContentItem> items, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87)),
            ],
          ),
          SizedBox(height: 6),
          Column(
            children: items
                .map((item) => Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        tileColor: iconColor.withOpacity(0.1),
                        title: Text(
                          item.contentName ?? "No Name",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: item.status == 'free'
                            ? Icon(Icons.play_circle_fill,
                                size: 24, color: Colors.green)
                            : Icon(Icons.lock, size: 24, color: Colors.red),
                        onTap: () {
                          if (title == "Tests") {
                            Get.to(() => QuizInfo());
                          }
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}