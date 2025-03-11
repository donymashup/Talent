import 'package:alpha/features/test_series/screens/attent_practice_test_screen.dart';
import 'package:alpha/models/practice_test_model.dart';
import 'package:flutter/material.dart';

class PracticeTestSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Future<PracticeTestModel?> fetchFunction;

  const PracticeTestSection({
    super.key,
    required this.icon,
    required this.title,
    required this.fetchFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(),
            FutureBuilder<PracticeTestModel?>(
              future: fetchFunction,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data!.practices!.isEmpty) {
                  return const Text("No Data Available",
                      style: TextStyle(color: Colors.grey));
                }

                return _buildPracticeTestList(snapshot.data!.practices!);
              },
            ),
            const SizedBox(height: 12), // Space after section
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Icon(icon, color: Colors.red),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPracticeTestList(List<Practices> practices) {
    return ListView.builder(
      shrinkWrap: true, // so that it takes minimal space
      physics:
          const NeverScrollableScrollPhysics(), // disable scrolling inside Column
      itemCount: practices.length,
      itemBuilder: (context, index) {
        final practice = practices[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AttendPracticeTestScreen(testid: practice.practiceTestsId!),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            practice.practiceTestsName ?? "Practice Test",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${practice.practiceTestsDuration ?? '0'} min",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
