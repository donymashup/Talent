import 'package:alpha/features/subscribed_courses/screen/chapterVideoPlayerScreen.dart';
import 'package:alpha/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class VideoSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Future<VideoModel?> fetchFunction;

  const VideoSectionWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.fetchFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(),
          FutureBuilder<VideoModel?>(
            future: fetchFunction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData ||
                  snapshot.data?.videos?.isEmpty == true) {
                return const Text("No Data Available",
                    style: TextStyle(color: Colors.grey));
              }

              return _buildVideoList(
                  snapshot.data!.videos!, context, snapshot.data);
            },
          ),
          const SizedBox(height: 12), // Space after section
        ],
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVideoList(
      List<Videos> videos, BuildContext context, videoModel) {
    return ListView.builder(
      shrinkWrap: true, // so that it takes minimal space
      physics:
          const NeverScrollableScrollPhysics(), // disable scrolling inside Column
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return GestureDetector(
          onTap: () {
            // Navigate to video player screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChapterVideoPlayerScreen(
                  selectedIndex: index,
                  videoList: videoModel,
                ),
              ),
            );
          },
          child: Padding(
            padding:
                const EdgeInsets.only(right: 2, top: 4, bottom: 4, left: 2),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: video.videoThumbnail ?? '',
                              placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 200, // Adjust height as needed
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, color: Colors.red),
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 6, left: 6, top: 1, bottom: 1),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      getDuration(
                                          minutesString: video.videoDuration),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.videoName ?? "Video",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            video.videoDescription ??
                                "No description available",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String getDuration({minutesString = String}) {
    int minutes = int.parse(minutesString);
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    String hoursString = hours.toString().padLeft(2, '0');
    String _minutesString = remainingMinutes.toString().padLeft(2, '0');

    return '$hoursString:$_minutesString';
  }
}
