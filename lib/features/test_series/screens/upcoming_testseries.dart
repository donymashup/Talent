import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/test_series/services/upcoming_testseries_services.dart';
import 'package:talent_app/models/upcoming_testseries_model.dart';

class UpcomingTestSeriesScreen extends StatefulWidget {
  @override
  _UpcomingTestSeriesScreenState createState() =>
      _UpcomingTestSeriesScreenState();
}

class _UpcomingTestSeriesScreenState extends State<UpcomingTestSeriesScreen> {
  UpcomingTestseriesServices testSeriesService = UpcomingTestseriesServices();
  List<Upcoming> upcomingTests = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUpcomingTests();
  }

  Future<void> fetchUpcomingTests() async {
    var response = await testSeriesService.getUpcomingTests(
      userId: userData.userid,
      context: context,
    );

    if (response != null && response.upcoming != null) {
      setState(() {
        upcomingTests = response.upcoming!;
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = "Failed to fetch upcoming test series.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor, // Matches Completed Test UI
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child:
                      Text(errorMessage!, style: TextStyle(color: Colors.red)))
              : upcomingTests.isEmpty
                  ? const Center(child: Text("No upcoming tests available"))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: upcomingTests.length,
                      itemBuilder: (context, index) {
                        final test = upcomingTests[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4, // Adds shadow for depth
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.access_time,
                                      size: 30, color: Colors.deepPurple),
                                  title: Text(
                                    test.mainTestsName ?? "Unnamed Test",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoText('Start Time',
                                        formatDate(test.mainTestsStart!)),
                                    _infoText('End Time',
                                        formatDate(test.mainTestsEnd!)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _infoText('Duration',
                                        test.mainTestsDuration ?? "N/A"),
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

  Widget _infoText(String label, String value) {
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

  String formatDate(String inputDateTimeString) {
    DateTime dateTime = DateTime.parse(inputDateTimeString);
    final format = DateFormat('dd/MM/yy hh:mm:ss a');
    return format.format(dateTime);
  }
}