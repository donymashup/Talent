import 'package:flutter/material.dart';
import 'package:talent_app/features/home/services/home_service.dart';
import 'package:talent_app/models/available_courses_model.dart';
import '../../../common widgets/loadingIndicator.dart';

class HeaderList extends StatefulWidget {
  const HeaderList({super.key});

  @override
  _HeaderListState createState() => _HeaderListState();
}

class _HeaderListState extends State<HeaderList> {
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
    return FutureBuilder<AvailableCoursesModel?>(
      future: _futureCourses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching categories'));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.data == null ||
            snapshot.data!.data!.isEmpty) {
          return const Center(child: Text('No categories available'));
        } else {
          final categories = snapshot.data!.data!;

          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(categories[index].name ?? "No Name"),
                        selected: _selectedCategoryIndex == index,
                        onSelected: (selected) {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                        selectedColor: Colors.blue,
                        backgroundColor: Colors.grey[300],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Text('Number of categories: ${categories.length}'),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount:
              //         categories[_selectedCategoryIndex].courses?.length ?? 0,
              //     itemBuilder: (context, courseIndex) {
              //       final course = categories[_selectedCategoryIndex]
              //           .courses![courseIndex];
              //       return ListTile(
              //         title: Text(course.courseDetails?.name ?? "No Name"),
              //         // subtitle: Text(course.description ?? "No Description"),
              //       );
              //     },
              //   ),
              // ),
            ],
          );
        }
      },
    );
  }
}
