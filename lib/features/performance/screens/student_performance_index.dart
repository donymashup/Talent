import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:talent_app/constants/app_constants.dart';

class StudentPerformanceIndex extends StatefulWidget {
  const StudentPerformanceIndex({super.key});

  @override
  _StudentPerformanceIndexState createState() =>
      _StudentPerformanceIndexState();
}

class _StudentPerformanceIndexState extends State<StudentPerformanceIndex> {
  int _selectedIndex = 0; // Track selected button index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: AppConstant.backgroundColor,
        elevation: 0,
        title: const Text("Student Performance Index",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppConstant.titlecolor,
          ),
        ),
      ),
      backgroundColor: AppConstant.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 10),

          // Tab Button Row with Horizontal Scrolling
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildTabButton("Mental Ability", 0),
                  const SizedBox(width: 10),
                  _buildTabButton("English", 1),
                  const SizedBox(width: 10),
                  _buildTabButton("Malayalam", 2),
                  const SizedBox(width: 10),
                  _buildTabButton("Biology", 3),
                  const SizedBox(width: 10),
                  _buildTabButton("Social Science", 4),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Dynamic Content
          Expanded(
            child: _selectedIndex == 0 ? _buildMentalAbilityTab() : _buildEnglishTab(),
          ),
        ],
      ),
    );
  }

  // Custom Tab Button
  Widget _buildTabButton(String text, int index) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedIndex == index ? AppConstant.primaryColor2 : Colors.grey.shade400,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMentalAbilityTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Learning Dynamics",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18),
          ),
          const Text(
            "Mental Ability",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 20),

          // Circular Progress Indicator
          SizedBox(
            height: 280,
            width: 280,
            child: CustomPaint(
              painter: ProgressRingPainter(percentage: 52),
              child: const Center(
                child: Text(
                  "50%",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatistic("Score", "40/80", Colors.blue),
                  _buildStatistic("%Cent", "50", Colors.green),
                  _buildStatistic("Grade", "F", Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            "Performance Graph Over Tests",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Performance Graph
          Container(
            height: 250,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
            ),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt().toString(), style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text((value + 1).toInt().toString(), style: const TextStyle(fontSize: 12));
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(1, 90),
                      const FlSpot(2, 90),
                    ],
                    isCurved: false,
                    color: Colors.green,
                    barWidth: 3,
                  ),
                  LineChartBarData(
                    spots: [
                      const FlSpot(1, 60),
                      const FlSpot(2, 40),
                    ],
                    isCurved: false,
                    color: Colors.orange,
                    barWidth: 3,
                  ),
                  LineChartBarData(
                    spots: [
                      const FlSpot(1, 80),
                      const FlSpot(2, 0),
                    ],
                    isCurved: false,
                    color: Colors.blue,
                    barWidth: 3,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildEnglishTab() {
    return Center(
      child: Text(
        "English content goes here",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem("Topper", Colors.green),
        const SizedBox(width: 10),
        _buildLegendItem("Average", Colors.orange),
        const SizedBox(width: 10),
        _buildLegendItem("Self", Colors.blue),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(width: 4),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildStatistic(String title, String value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 12, color: color),
            const SizedBox(width: 6),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }
}

// Custom Circular Progress Indicator
class ProgressRingPainter extends CustomPainter {
  final double percentage;
  ProgressRingPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 30;
    double radius = (size.width / 2) - (strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);

    // Background paint
    Paint backgroundPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Progress paint
    Paint progressPaint = Paint()
      ..color = AppConstant.primaryColor2
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Angle and sweep for the progress arc
    double startAngle = -pi / 2;
    double sweepAngle = (2 * pi) * (percentage / 100);

    // Draw background circle
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, 2 * pi, false, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
