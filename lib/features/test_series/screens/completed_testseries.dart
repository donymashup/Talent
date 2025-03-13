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
      backgroundColor: AppConstant.backgroundColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: completedTestSeries.length,
                  itemBuilder: (context, index) {
                    var test = completedTestSeries[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.green],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12), // Reduced padding
                        // Removed isDense parameter as it is not valid for ListTile
                        leading: const Icon(Icons.check_circle,
                            size: 40, color: Colors.white),
                        title: Flexible(
                          child: Text(
                            test.name ?? "Unnamed Test",
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
                            _infoText(
                                'Start Time', formatDate(test.start!), Colors.white70),
                            _infoText(
                                'End Time', formatDate(test.subTime!), Colors.white70),
                            _infoText(
                                'Duration', test.duration ?? "N/A", Colors.white),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainPerformanceScreen(testid: test.testid!)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Review"),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _infoText(String label, String value, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.access_time, size: 14, color: textColor),
          const SizedBox(width: 4),
          Expanded( // Ensures text stays within screen boundaries
            child: Text(
              "$label: $value",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String inputDateTimeString) {
    DateTime dateTime = DateTime.parse(inputDateTimeString);
    final format = DateFormat('dd/MM/yy hh:mm:ss a');
    return format.format(dateTime);
  }
}
