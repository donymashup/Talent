import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/subscribed_courses/services/user_subscriptions_services.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfId;
  final String pdfPath;
  final String materialName;

  const PDFViewerPage(
      {super.key,
      required this.pdfPath,
      required this.materialName,
      required this.pdfId});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  void initState() {
    super.initState();
    addActivityTimeline();
  }

  void addActivityTimeline() {
    UserSubscriptionsServices().insertTimelineActivity(
      contentId: widget.pdfId,
      type: "materials",
      userId: userData.userid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.materialName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: SfPdfViewer.network(widget.pdfPath),
    );
  }
}
