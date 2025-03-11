import 'package:alpha/common%20widgets/LargeLoading.dart';
import 'package:alpha/features/subscribed_courses/widgets/videoListCardWidget.dart';
import 'package:alpha/models/video_model.dart';
// import 'package:better_player/better_player.dart';
import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final VideoModel videoModel;
  final int selectedIndex;
  const VideoPlayer({
    super.key,
    required this.videoModel,
    required this.selectedIndex,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late int selectedIndex = widget.selectedIndex;
  late VideoModel videoList = widget.videoModel;
  bool isLoading = true;
  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    super.initState();
    setupData();
    // initializePlayer(videoList.videos![selectedIndex].videoLink!);
    initializePlayer(
        "https://d3sigpa2r6yn5i.cloudfront.net/transcoded/9hpnhJKAPpX/video.m3u8");
  }

  void setupData() async {
    setState(() {
      isLoading = false;
    });
  }

  void initializePlayer(String url) {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      url,
    );
    betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }

  Widget getBetterPlayer() {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(controller: betterPlayerController),
            ),
            titleHead(),
            playlist(),
          ],
        ),
      ),
    );
  }

  Widget titleHead() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        videoList.videos![selectedIndex].videoName!,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget playlist() {
    return Expanded(
      child: ListView.builder(
        itemCount: videoList.videos?.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // initializePlayer(videoList.videos![index].videoLink!);
              initializePlayer(
                  "https://media.istockphoto.com/id/2150949209/video/soccer-championship-game-at-an-outdoors-stadium-blue-team-football-forward-player-attacking.mp4?s=mp4-640x640-is&k=20&c=W9o__Elh8GghCBy0fMExIkHw96LjyVgoK9EW1Mg4I-Q=");
            },
            child: VideoListCardWidget(
              title: videoList.videos![index].videoName!,
              duration: videoList.videos![index].videoDuration!,
              source: videoList.videos![index].videoSource!,
              thumbnail: videoList.videos![index].videoThumbnail!,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
                child: LargeLoading(),
              )
            : getBetterPlayer(),
      ),
    );
  }
}
