import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:talent_app/constants/app_constants.dart';

class OverviewTab extends StatelessWidget {
  final String description;

  const OverviewTab({super.key, required this.description});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppConstant.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: HtmlWidget(description),
          ),
        ),
      ),
    );
  }
}
