import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/features/test_series/screens/start_testseries_quiz.dart';
import 'package:alpha/features/test_series/services/ongoing_testseries_services.dart';
import 'package:alpha/models/ongoing_testseries_model.dart';
import 'package:intl/intl.dart';

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

              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 4, // Adds a subtle shadow
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.assignment,
                            size: 30, color: Colors.green),
                        title: Text(
                          test.mainTestsName ?? "Unknown Test",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StartQuizSeriesInfo(
                                  quizTitle:
                                      test.mainTestsName ?? "Unknown Test",
                                  totalQuestions: int.tryParse(
                                          test.mainTestsQuestions ?? "0") ??
                                      0, // ✅ Fix applied
                                  duration: test.mainTestsDuration ?? "N/A",
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          child: const Text("Start"),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _infoText('Start Time',
                              formatDate(test.mainTestsStart ?? "")),
                          _infoText(
                              'End Time', formatDate(test.mainTestsEnd ?? "")),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _infoText('Duration', test.mainTestsDuration ?? "N/A"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _infoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
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
