import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/subscribed_courses/screen/chapter_list.dart';
import 'package:alpha/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:alpha/models/subject_list_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SubjectList extends StatefulWidget {
  final String classId;
  final String packageId;
  final String batchId;
  final String className;
  final String classImage;
  const SubjectList({
    required this.classId,
    required this.packageId,
    required this.batchId,
    required this.className,
    super.key,
    required this.classImage,
  });

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  late Future<SubjectListModel?> _subjectList;

  @override
  void initState() {
    super.initState();
    _subjectList = UserSubscriptionsServices().getCourseSubjectList(
      context: context,
      classId: widget.classId,
      packageId: widget.packageId,
      batchId: widget.batchId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  bool isCollapsed = constraints.maxHeight <= kToolbarHeight;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background Image
                      Hero(
                        tag:"classImage-${widget.classId}",
                        child: CachedNetworkImage(
                          imageUrl: widget.classImage,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/onboarding1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Gradient Overlay (Dark at Bottom)
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black
                                  .withOpacity(0.9), // Dark at the bottom
                              Colors.transparent, // Clear at the top
                            ],
                          ),
                        ),
                      ),
                      // Title positioned at the bottom left
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 45, bottom: 10),
                          child: Text(
                            widget.className,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isCollapsed ? 18 : 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    size: 16, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ];
        },
        body: FutureBuilder<SubjectListModel?>(
          future: _subjectList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData ||
                snapshot.data!.subjects == null ||
                snapshot.data!.subjects!.isEmpty) {
              return const Center(child: Text("No subjects found"));
            }

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final subject = snapshot.data!.subjects![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChapterList(
                                sublectImage: subject.subjectImage!,
                                subjectName: subject.subjectName!,
                                classId: widget.classId,
                                packageId: subject.packageid!,
                                batchId: widget.batchId,
                                subjectId: subject.subjectId!,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Hero(
                                    tag: "subjectImage-${subject.subjectId}",
                                    child: CachedNetworkImage(
                                      imageUrl: subject.subjectImage ?? "",
                                      width: 110,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          width: 110,
                                          height: 80,
                                          color: Colors.white,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/onboarding1.jpg',
                                        width: 110,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    subject.subjectName ?? "Subject",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: snapshot.data!.subjects!.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
