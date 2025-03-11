import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talent_app/features/subscribed_courses/screen/chapter_content.dart';
import 'package:talent_app/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:talent_app/models/chapter_list_model.dart';

class ChapterList extends StatefulWidget {
  final String sublectImage;
  final String subjectName;
  final String classId;
  final String packageId;
  final String batchId;
  final String subjectId;

  const ChapterList({
    required this.sublectImage,
    required this.subjectName,
    required this.classId,
    required this.packageId,
    required this.batchId,
    required this.subjectId,
    super.key,
  });

  @override
  State<ChapterList> createState() => _ChapterListState();
}

class _ChapterListState extends State<ChapterList> {
  late Future<ChapterListModel?> _chapterList;

  @override
  void initState() {
    super.initState();
    _loadChapters();
  }

  void _loadChapters() async {
    _chapterList = UserSubscriptionsServices().getSubjectChapterList(
      context: context,
      classId: widget.classId,
      packageId: widget.packageId,
      batchId: widget.batchId,
      subjectId: widget.subjectId,
    );
    setState(() {}); // Ensure UI updates when data is available
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
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
                    Hero(
                      tag: "subjectImage-${widget.subjectId}",
                      child: CachedNetworkImage(
                        imageUrl: widget.sublectImage,
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
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 45, bottom: 10),
                        child: Text(
                          widget.subjectName,
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
          SliverToBoxAdapter(
            child: FutureBuilder<ChapterListModel?>(
              future: _chapterList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.chapters == null ||
                    snapshot.data!.chapters!.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No chapters found"),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true, // Important for SliverToBoxAdapter
                  physics:
                      NeverScrollableScrollPhysics(), // Avoid nested scrolling issues
                  padding: const EdgeInsets.all(3),
                  itemCount: snapshot.data!.chapters!.length,
                  itemBuilder: (context, index) {
                    final list = snapshot.data!.chapters![index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: ListTile(
                          title: Text(
                            list.chaptersName ?? "Chapter",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Hero(
                              tag: "chapterImage-${list.chaptersId}",
                              child: CachedNetworkImage(
                                imageUrl: list.chaptersImage ?? "",
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 50, // Set fixed width and height
                                    height: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/course1.png",
                                        fit: BoxFit.cover),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChapterContents(
                                  chapterImage: list.chaptersImage!,
                                  chapterName: list.chaptersName!,
                                  chapterId: list.chaptersId!,
                                  batchId: widget.batchId,
                                  packageId: widget.packageId,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
