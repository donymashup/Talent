import 'dart:async';

import 'package:better_player/better_player.dart';
//import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talent_app/common%20widgets/LargeLoading.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:talent_app/features/subscribed_courses/widgets/videoListCardWidget.dart';
import 'package:talent_app/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ChapterVideoPlayerScreen extends StatefulWidget {
  final VideoModel videoList;
  final int selectedIndex;

  const ChapterVideoPlayerScreen(
      {Key? key, required this.selectedIndex, required this.videoList})
      : super(key: key);

  @override
  State<ChapterVideoPlayerScreen> createState() =>
      _ChapterVideoPlayerScreenState();
}

class _ChapterVideoPlayerScreenState extends State<ChapterVideoPlayerScreen> {
  int InitialIndex = 0;
  late int SelectedIndex = widget.selectedIndex;
  late VideoModel _videoList = widget.videoList;
  late String? current_video_url = _videoList.videos![SelectedIndex].videoHls;
  bool _isBookmarked = false;
  final GlobalKey<BetterPlayerPlaylistState> _betterPlayerPlaylistStateKey =
      GlobalKey();
  List<BetterPlayerDataSource> _dataSourceList = [];
  late BetterPlayerConfiguration _betterPlayerConfiguration;
  late BetterPlayerPlaylistConfiguration _betterPlayerPlaylistConfiguration;

  late String SelectedSource;
  bool _isloading = true;

  late YoutubePlayerController _controller;
  late BetterPlayerController _betterPlayerController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  _ChapterVideoPlayerScreenState() {
    _betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.cover,
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
      subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(fontSize: 10),
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    _betterPlayerPlaylistConfiguration = BetterPlayerPlaylistConfiguration(
      initialStartIndex: InitialIndex,
      loopVideos: true,
      nextVideoDelay: Duration(seconds: 3),
    );
  }

  setupData() async {
    for (var i = 0; i < _videoList.videos!.length; i++) {
      _dataSourceList.add(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          _videoList.videos![i].videoHls!,
          placeholder: Image.network(
            _videoList.videos![i].videoThumbnail!,
            fit: BoxFit.cover,
          ),
        ),
      );
      print(_videoList.videos![i].videoHls!);
    }
    print("finished setupdata");

    setState(() {
      SelectedIndex = widget.selectedIndex;
      _isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setupData();
    Timer(Duration(seconds: 0), () {
      _betterPlayerPlaylistController!.setupDataSource(SelectedIndex);
      print("finished Timer");
      setState(() {
        InitialIndex = SelectedIndex;
      });
    });

    _controller = YoutubePlayerController(
      initialVideoId: _videoList.videos![SelectedIndex].videoVideoid!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _playerState = PlayerState.unknown;
    // Services.getbookmarking(
    //         userid: userData.userid,
    //         type: "videos",
    //         contentid: _videoList.videos[SelectedIndex].videoId.toString())
    //     .then((bookmarks) {
    //   if (bookmarks.type == "success") {
    //     setState(() {
    //       _isBookmarked = true;
    //     });
    //   } else {
    //     setState(() {
    //       _isBookmarked = false;
    //     });
    //   }
    // }).catchError((onError) {});
    addActivityTimeline();
  }

  void addActivityTimeline() {
    UserSubscriptionsServices().insertTimelineActivity(
      contentId: _videoList.videos![SelectedIndex].videoId.toString(),
      type: "videos",
      userId: userData.userid,
    );
  }

  // void addActivityTimeline() {
  //   Services.insertTimelineActivity(
  //       userid: userData.userid,
  //       contentid: _videoList.videos[SelectedIndex].videoId.toString(),
  //       type: "videos");
  // }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _betterPlayerPlaylistController?.dispose();
    super.dispose();
  }

  Widget GetYoutubePlayer() {
    return SafeArea(
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
        builder: (context, player) => Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              TitleHead(),
              Playlist(),
            ],
          ),
        ),
      ),
    );
  }

  Widget TitleHead() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              //
              _videoList.videos![SelectedIndex].videoName.toString(),
              // style: KHeading3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
          _isBookmarked
              ? InkWell(
                  onTap: () {
                    // Services.bookmarking(
                    //         userid: userData.userid,
                    //         type: "videos",
                    //         contentid: _videoList.videos[SelectedIndex].videoId
                    //             .toString())
                    //     .then((bookmarks) {
                    //   if (bookmarks.type == "success") {
                    //     setState(() {
                    //       _isBookmarked = true;
                    //     });
                    //   } else {
                    //     setState(() {
                    //       _isBookmarked = false;
                    //     });
                    //   }
                    // }).catchError((onError) {});
                  },
                  child: const Icon(Icons.bookmark),
                )
              : InkWell(
                  onTap: () {
                    // Services.bookmarking(
                    //         userid: userData.userid,
                    //         type: "videos",
                    //         contentid: _videoList.videos[SelectedIndex].videoId
                    //             .toString())
                    //     .then((bookmarks) {
                    //   if (bookmarks.type == "success") {
                    //     setState(() {
                    //       _isBookmarked = true;
                    //     });
                    //   } else {
                    //     setState(() {
                    //       _isBookmarked = false;
                    //     });
                    //   }
                    // }).catchError((onError) {});
                  },
                  child: const Icon(Icons.bookmark_border),
                ),
        ],
      ),
    );
  }

  Widget Playlist() {
    return Expanded(
      child: Container(
        height: double.maxFinite,
        child: ListView.builder(
          itemCount: _videoList.videos?.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (_videoList.videos![index].videoSource == "1") {
                  setState(() {
                    SelectedIndex = index;
                    InitialIndex = index;
                  });
                  _controller.load(_videoList.videos![index].videoVideoid!);
                } else {
                  setState(() {
                    SelectedIndex = index;
                    InitialIndex = index;
                  });
                  _betterPlayerPlaylistController!
                      .setupDataSource(SelectedIndex);
                }
                addActivityTimeline();
              },
              child: VideoListCardWidget(
                title: _videoList.videos![index].videoName.toString(),
                duration: _videoList.videos![index].videoDuration.toString(),
                source: _videoList.videos![index].videoSource.toString(),
                thumbnail: _videoList.videos![index].videoThumbnail.toString(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget GetBetterPlayer() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayerPlaylist(
                key: _betterPlayerPlaylistStateKey,
                betterPlayerConfiguration: _betterPlayerConfiguration,
                betterPlayerPlaylistConfiguration:
                    _betterPlayerPlaylistConfiguration,
                betterPlayerDataSourceList: _dataSourceList,
              ),
            ),
            TitleHead(),
            Playlist(),
          ],
        ),
      ),
    );
  }

  int get currentDataSourceIndex => SelectedIndex;

  BetterPlayerPlaylistController? get _betterPlayerPlaylistController =>
      _betterPlayerPlaylistStateKey
          .currentState!.betterPlayerPlaylistController;

  @override
  Widget build(BuildContext context) {
    debugPrint("SelectedIndex: $SelectedIndex");
    debugPrint("SelectedIndex: ${_videoList.videos![SelectedIndex].videoHls}");
    debugPrint(
        "SelectedIndex: ${_videoList.videos![SelectedIndex].videoVideoid}");
    return SafeArea(
      child: Scaffold(
        body: _isloading
            ? const Center(
                child: LargeLoading(),
              )
            : _videoList.videos![SelectedIndex].videoSource! == "1"
                ? GetYoutubePlayer()
                : GetBetterPlayer(),
      ),
    );
  }
}
