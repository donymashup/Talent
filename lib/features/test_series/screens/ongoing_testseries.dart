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
                "No ongoing test series available.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          List<Ongoing> testSeries = snapshot.data!.ongoing!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: testSeries.length,
            itemBuilder: (context, index) {
              var test = testSeries[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppConstant.secondaryColorLight, AppConstant.secondaryColorLight],
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
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12), // Reduced padding
                  // isDense: true, // Helps prevent overflow
                  leading: const Icon(Icons.assignment, size: 40, color: Colors.white),
                  title: Flexible(
                    child: Text(
                      test.mainTestsName ?? "Unknown Test",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      _infoText('Start Time', formatDate(test.mainTestsStart ?? ""), Colors.white70),
                      _infoText('End Time', formatDate(test.mainTestsEnd ?? ""), Colors.white70),
                      _infoText('Duration', test.mainTestsDuration ?? "N/A", Colors.white),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartQuizSeriesInfo(
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
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoText(String label, String value, Color textColor) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.access_time, size: 14, color: textColor),
        const SizedBox(width: 4),
        Text(
          "$label: ",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
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
