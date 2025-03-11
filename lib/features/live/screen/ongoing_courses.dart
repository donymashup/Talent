import 'package:alpha/features/live/services/live_service.dart';
import 'package:alpha/models/live_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class OngoingClasses extends StatefulWidget {
  const OngoingClasses({super.key});

  @override
  State<OngoingClasses> createState() => _OngoingClassesState();
}

class _OngoingClassesState extends State<OngoingClasses> {
  final LiveService _liveService = LiveService(); // Initialize LiveService

  Future<LiveModel?>? _liveClassFuture; // Future to hold API response

  @override
  void initState() {
    super.initState();
    _fetchLiveClasses();
  }

  void _fetchLiveClasses() {
    setState(() {
      _liveClassFuture = _liveService.getLiveClass(
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: FutureBuilder<LiveModel?>(
          future: _liveClassFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator()); // Show loading
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                  child: Text("Failed to load upcoming classes"));
            } else if (snapshot.data! == null ||
                snapshot.data!.ongoing!.isEmpty) {
              return const Center(child: Text("No upcoming classes available"));
            }

            // Extract upcoming classes
            List<Ongoing> upcomingClasses = snapshot.data!.ongoing!;

            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: upcomingClasses.length,
              itemBuilder: (context, index) {
                final classData = upcomingClasses[index];

                return ClassCard(
                  title: classData.title ?? "No Title",
                  tutor: classData.faculty ?? "No Faculty",
                  imageUrl:
                      classData.avatar ?? "assets/images/ongoingcourse.png",
                  date: classData.end != null
                      ? DateFormat("MMM dd, yyyy")
                          .format(DateTime.parse(classData.start!))
                      : "No Date",
                  startTime: classData.end != null
                      ? DateFormat("h:mm a")
                          .format(DateTime.parse(classData.start!))
                      : "No Time",
                  url: classData.url ?? "No URL",
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final String title;
  final String tutor;
  final String imageUrl;
  final String date;
  final String startTime;
  final String url;

  const ClassCard({
    required this.title,
    required this.tutor,
    required this.imageUrl,
    required this.date,
    required this.startTime,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        debugPrint("Tapped on class card ${url}");
        // Handle card tap, e.g., navigate to a detailed page or open a URL
        if (url.isNotEmpty) {
          try {
            await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication);
          } catch (e) {
            // Handle the error.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: $e")),
            );
          }
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
           // mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
            children: [
              /// Image section - 1/3 of the row
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                imageUrl: imageUrl, // URL of the image
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.broken_image, size: 40, color: Colors.grey),
              ),
              ),
              const SizedBox(width: 12),

              /// Text section - 2/3 of the row
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tutor,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 8),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ensures equal spacing
                    children: [
                      /// Date Section
                      Row(
                        children: [
                          Icon(FluentIcons.calendar_ltr_24_regular, size: 18, color: Colors.blue),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      /// Time Section
                      Row(
                        children: [
                          Icon(FluentIcons.clock_24_regular, size: 18, color: Colors.green),
                          const SizedBox(width: 4),
                          Text(
                            startTime,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      /// Live Indicator
                      Row(
                        children: const [
                          Icon(Icons.fiber_manual_record, color: Colors.red, size: 12),
                          SizedBox(width: 4),
                          Text("Live", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ],
                  )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
