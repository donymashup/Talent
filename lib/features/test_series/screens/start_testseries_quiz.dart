import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/test_series/screens/attend_main_test_screen.dart';

class StartQuizSeriesInfo extends StatelessWidget {
  final String quizTitle;
  final String testid;
  final int totalQuestions; // Changed from String to int
  final String duration;

  const StartQuizSeriesInfo({
    super.key,
    required this.quizTitle,
    required this.testid,
    required this.totalQuestions,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppConstant.redDarkeGradient,
        ),
        child: Column(
          children: [
            // Header Section
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        quizTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quiz Info Section
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Center(
                                child: Text(
                                  "Quiz Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Quiz Details
                              IconText(
                                iconName: Icons.question_mark_outlined,
                                title: "$totalQuestions questions",
                                subtitle:
                                    "points for each correct answer is mentioned for each question",
                              ),
                              const SizedBox(height: 20),
                              IconText(
                                iconName: Icons.timer_outlined,
                                title: "$duration minutes",
                                subtitle: "Total duration of the quiz",
                              ),
                              // const SizedBox(height: 10),
                              // const IconText(
                              //   iconName: Icons.star,
                              //   title: "Win All Stars",
                              //   subtitle: "Answer all questions correctly",
                              // ),
                              const SizedBox(height: 20),

                              // Instructions Section
                              const Text(
                                "Please read the following instructions carefully",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Instructions(
                                  instruction:
                                      "Correct and incorrect marks are shown for each and every question"),
                              const SizedBox(height: 20),
                              const Instructions(
                                  instruction:
                                      "Tap on options to select the correct answers"),
                              const SizedBox(height: 20),
                              const Instructions(
                                  instruction:
                                      "Save each answers before submitting(Press the Save button)"),
                              const SizedBox(height: 20),
                              const Instructions(
                                  instruction:
                                      "Once you submit the exam, you cannot change the answers."),
                              const SizedBox(height: 20),
                              const Instructions(
                                  instruction:
                                      "Press submit after saving answers to complete the exam (Press Submit and End button)"),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Start Quiz Button
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttendMainTestScreen(
                                    testid: testid, // Pass test ID here
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstant.buttonupdate,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.9, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Start Test",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Instructions Widget
class Instructions extends StatelessWidget {
  final String instruction;
  const Instructions({required this.instruction, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.arrow_forward_ios, size: 16),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            instruction,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}

// Icon and Text Widget
class IconText extends StatelessWidget {
  final IconData iconName;
  final String title;
  final String subtitle;
  const IconText({
    required this.iconName,
    required this.subtitle,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppConstant.titlecolor,
          child: Icon(iconName, size: 24, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppConstant.hindColor),
            ),
          ],
        ),
      ],
    );
  }
}
