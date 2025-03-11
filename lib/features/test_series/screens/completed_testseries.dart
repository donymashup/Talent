import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/test_series/screens/main_performance_screen.dart';
import 'package:talent_app/features/test_series/services/completed_testseries_services.dart';
import 'package:talent_app/models/completed_testseries_model.dart';

class CompletedTestSeriesScreen extends StatefulWidget {
  @override
  _CompletedTestSeriesScreenState createState() =>
      _CompletedTestSeriesScreenState();
}

class _CompletedTestSeriesScreenState extends State<CompletedTestSeriesScreen> {
  List<Attended> completedTestSeries = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchCompletedTests();
  }

  Future<void> fetchCompletedTests() async {
    CompletedTestseriesServices service = CompletedTestseriesServices();
    var response = await service.getAttendedTests(
        userId: userData.userid, context: context);

    if (response != null && response.attended != null) {
      setState(() {
        completedTestSeries = response.attended!;
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = "Failed to fetch completed test series.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor, // 🔹 Added background color
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader
          : errorMessage != null
              ? Center(
                  child:
                      Text(errorMessage!, style: TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: completedTestSeries.length,
                  itemBuilder: (context, index) {
                    var test = completedTestSeries[index];

                    return Card(
                      //color: Colors.white, // Ensures good contrast with background
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4, // Adds slight shadow for depth
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.check_circle,
                                  size: 30, color: Colors.blue),
                              title: Text(
                                test.name ?? "Unnamed Test",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainPerformanceScreen(
                                                testid: test.testid!)),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange),
                                child: const Text("Review"),
                              ),
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoRightText(
                                    'Start Time', formatDate(test.start!)),
                                _infoLeftText(
                                    'End Time', formatDate(test.subTime!)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _infoRightText(
                                    'Duration', test.duration ?? "N/A"),
                                _infoLeftText(
                                    'Total Marks', "N/A"), // Adjust as per API
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _infoRightText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _infoLeftText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  String formatDate(String inputDateTimeString) {
    DateTime dateTime = DateTime.parse(inputDateTimeString);
    final format = DateFormat('dd/MM/yy hh:mm:ss a');
    return format.format(dateTime);
  }
}
