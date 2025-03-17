
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:talent_app/models/miscellaneous_folder_model.dart';

class MiscellaneousFolderScreen extends StatefulWidget {
  final String courseId;
  const MiscellaneousFolderScreen({required this.courseId, super.key});

  @override
  State<MiscellaneousFolderScreen> createState() =>
      _MiscellaneousFolderScreenState();
}

class _MiscellaneousFolderScreenState extends State<MiscellaneousFolderScreen> {
  late Future<MiscellaneousFoldersModel?> folders;
  MiscellaneousFoldersModel? currentFolder;
  List<MiscellaneousFoldersModel> folderStack =
      []; // Stack to track folder history

  @override
  void initState() {
    super.initState();
    fetchInitialFolders();
  }

  void fetchInitialFolders() {
    setState(() {
      folders = UserSubscriptionsServices().getMiscellaneousFolders(
        context: context,
        courseId: widget.courseId,
        userId: userData.userid,
      );
    });
  }

  void updateFolder(MiscellaneousFoldersModel selectedFolder) {
    setState(() {
      if (currentFolder != null) {
        folderStack.add(currentFolder!); // Push current folder to stack
      }
      currentFolder = selectedFolder;
    });
  }

  void playVideo(BuildContext context, String videoUrl, String videoName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(
          videoUrl: videoUrl,
          videoName: videoName,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (folderStack.isNotEmpty) {
      setState(() {
        currentFolder = folderStack.removeLast(); // Pop the last folder
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppConstant.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppConstant.backgroundColor,
          title: Text(
            currentFolder == null
                ? "Extras Lessons"
                : currentFolder!.title ?? "Subfolder",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 16),
            onPressed: () {
              if (folderStack.isNotEmpty) {
                setState(() {
                  currentFolder = folderStack.removeLast();
                });
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: FutureBuilder<MiscellaneousFoldersModel?>(
          future: folders,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData ||
                snapshot.data!.list == null ||
                snapshot.data!.list!.isEmpty) {
              return const Center(child: Text("No Lessons found"));
            }

            List<MiscellaneousFoldersModel> displayList =
                currentFolder?.list ?? snapshot.data!.list!;

            return ListView.builder(
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                var folder = displayList[index];
                bool isFolder = folder.list != null && folder.list!.isNotEmpty;
                bool isVideo = folder.type == "video";

                return Card(
                  color: AppConstant.cardBackground,
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(folder.title ?? "No Title"),
                    leading: isFolder
                        ? Icon(Icons.folder,
                            size: 50, color: AppConstant.primaryColor2)
                        : isVideo
                            ? CachedNetworkImage(
                                imageUrl: folder.thumbnail ?? '',
                                width: 70,
                                height: 50,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 70,
                                    height: 50,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.broken_image, size: 50),
                              )
                            : Icon(Icons.play_circle_fill,
                                size: 50, color: Colors.red),
                    trailing: isFolder
                        ? Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey,
                          )
                        : null,
                    onTap: () {
                      if (isFolder) {
                        updateFolder(folder);
                      } else if (isVideo && folder.link != null) {
                        playVideo(context, folder.link!, folder.title!);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;
  final String videoName;
  const VideoPlayerScreen(
      {Key? key, required this.videoUrl, required this.videoName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 16),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            videoName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BetterPlayer.network(
            videoUrl,
            betterPlayerConfiguration: BetterPlayerConfiguration(
              autoPlay: true,
              looping: false,
              controlsConfiguration: BetterPlayerControlsConfiguration(
                enableProgressText: true,
                enablePlayPause: true,
                enablePlaybackSpeed: true,
                enableSkips: true,
                enableFullscreen: true,
                enablePip: true,
                enableRetry: true,
                enableMute: true,
                showControlsOnInitialize: true,
              ),
            ),
          ),
          //  SizedBox(height: 15,),
          //  Padding(
          //    padding: const EdgeInsets.all(8.0),
          //    child: Text(videoName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
          //  )
        ],
      ),
    );
  }
}
