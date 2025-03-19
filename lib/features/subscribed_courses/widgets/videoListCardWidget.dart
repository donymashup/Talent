import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VideoListCardWidget extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String duration;
  final String source;

  const VideoListCardWidget(
      {Key? key,
      required this.thumbnail,
      required this.title,
      required this.duration,
      required this.source})
      : super(key: key);

  @override
  State<VideoListCardWidget> createState() => _VideoListCardWidgetState();
}

class _VideoListCardWidgetState extends State<VideoListCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2, top: 4, bottom: 4, left: 2),
      child: Card(
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
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        // width: MediaQuery.of(context).size.width * .25,
                        imageUrl: widget.thumbnail,
                        placeholder: (context, url) => const Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      // Image.network(widget.thumbnail,
                      //     width: MediaQuery.of(context).size.width * .35),
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
                                getDuration(minutesString: widget.duration),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  widget.title.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
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
