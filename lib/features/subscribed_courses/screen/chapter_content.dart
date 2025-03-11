import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:alpha/features/subscribed_courses/widgets/materials_section.dart';
import 'package:alpha/features/subscribed_courses/widgets/practice_test_section.dart';
import 'package:alpha/features/subscribed_courses/widgets/video_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChapterContents extends StatefulWidget {
  final String chapterImage;
  final String chapterName;
  final String chapterId;
  final String batchId;
  final String packageId;

  const ChapterContents({
    super.key,
    required this.chapterId,
    required this.batchId,
    required this.packageId,
    required this.chapterName,
    required this.chapterImage,
  });

  @override
  State<ChapterContents> createState() => _ChapterContentsState();
}

class _ChapterContentsState extends State<ChapterContents>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,size: 16, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),


        title: Text(widget.chapterName,
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppConstant.backgroundColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppConstant.primaryColor,
          labelColor: AppConstant.primaryColor,
          unselectedLabelColor: AppConstant.titlecolor,
          tabs: const [
            Tab(text: "Videos"),
            Tab(text: "Materials"),
            Tab(text: "Practice Tests"),
          ],
        ),
      ),
      body: Column(
        children: [
          Hero(
            tag: "chapterImage-${widget.chapterId}",
            child: CachedNetworkImage(
              imageUrl: widget.chapterImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                VideoSectionWidget(
                  icon: Icons.video_library,
                  title: "Videos",
                  fetchFunction: UserSubscriptionsServices().getChapterVideos(
                    context: context,
                    chapterId: widget.chapterId,
                    batchId: widget.batchId,
                    packageId: widget.packageId,
                  ),
                ),
                MaterialsSectionWidget(
                  icon: Icons.book,
                  title: "Study Materials",
                  fetchFunction:
                      UserSubscriptionsServices().getChapterMaterials(
                    context: context,
                    chapterId: widget.chapterId,
                    batchId: widget.batchId,
                    packageId: widget.packageId,
                  ),
                ),
                PracticeTestSection(
                  icon: Icons.quiz,
                  title: "Practice tests",
                  fetchFunction:
                      UserSubscriptionsServices().getChapterPracticeTests(
                    context: context,
                    chapterId: widget.chapterId,
                    batchId: widget.batchId,
                    packageId: widget.packageId,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
