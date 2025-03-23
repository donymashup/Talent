import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/test_series/screens/start_testseries_quiz.dart';
import 'package:talent_app/features/test_series/services/ongoing_testseries_services.dart';
import 'package:talent_app/models/ongoing_testseries_model.dart';

class OngoingTestSeries extends StatefulWidget {
  @override
  _OngoingTestSeriesState createState() => _OngoingTestSeriesState();
}

class _OngoingTestSeriesState extends State<OngoingTestSeries> {
  late Future<OngoingTestsModel?> _ongoingTestsFuture;

  @override
  void initState() {
    super.initState();
    _ongoingTestsFuture = OngoingTestseriesServices().getOngoingTests(
      userId: userData.userid,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      body: FutureBuilder<OngoingTestsModel?>(
        future: _ongoingTestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError ||
              snapshot.data?.ongoing == null ||
              snapshot.data!.ongoing!.isEmpty) {
            return const Center(
              child: Text(
                "No ongoing test series available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          return _buildTestSeriesList(snapshot.data!.ongoing!);
        },
      ),
    );
  }

  Widget _buildTestSeriesList(List<Ongoing> testSeries) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: testSeries.length,
      itemBuilder: (context, index) {
        var test = testSeries[index];
        return _buildTestSeriesItem(test);
      },
    );
  }

  Widget _buildTestSeriesItem(Ongoing test) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppConstant.primaryColor3, AppConstant.secondaryColorLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                test.mainTestsName ?? "Unknown Test",
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.assignment, size: 40, color: Colors.white),
              title: _buildTestSeriesInfo(test),
              // subtitle: _buildTestSeriesInfo(test),
              trailing: _buildStartButton(test),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestSeriesInfo(Ongoing test) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _infoText('Start Time', formatDate(test.mainTestsStart ?? ""),
            Colors.white70),
        _infoText(
            'End Time', formatDate(test.mainTestsEnd ?? ""), Colors.white70),
        _DurationinfoText(
            'Duration', test.mainTestsDuration ?? "N/A", Colors.white),
      ],
    );
  }

  Widget _buildStartButton(Ongoing test) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StartQuizSeriesInfo(
              testid: test.mainTestsId ?? "0",
              quizTitle: test.mainTestsName ?? "Unknown Test",
              totalQuestions: int.tryParse(test.mainTestsQuestions ?? "0") ?? 0,
              duration: test.mainTestsDuration ?? "N/A",
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppConstant.secondaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text("Start"),
    );
  }

  Widget _infoText(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Icon(Icons.access_time, size: 14, color: textColor),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$label: ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 14, color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _DurationinfoText(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Icon(Icons.access_time, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            "$label: ",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, color: textColor),
          ),
        ],
      ),
    );
  }

  String formatDate(String inputDateTimeString) {
    if (inputDateTimeString.isEmpty) return "N/A";
    try {
      DateTime dateTime = DateTime.parse(inputDateTimeString);
      final format = DateFormat('dd/MM/yy hh:mm:ss a');
      return format.format(dateTime);
    } catch (e) {
      return "Invalid Date";
    }
  }
}
