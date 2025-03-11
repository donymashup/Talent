import 'package:flutter/material.dart';
import 'package:talent_app/constants/app_constants.dart';

class QuizInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppConstant.redDarkeGradient,
        ),
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    SizedBox(width: 20),
                    Text(
                      "Algebra practice quiz",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
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
                    const Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "Quiz Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              IconText(
                                iconName: Icons.question_mark_outlined,
                                title: "10 Questions",
                                subtitle: "10 points for each correct answer",
                              ),
                              SizedBox(height: 10),
                              IconText(
                                iconName: Icons.timer_outlined,
                                title: "1 hour 15 min",
                                subtitle: "Total duration of the quiz",
                              ),
                              SizedBox(height: 10),
                              IconText(
                                iconName: Icons.star,
                                title: "Win All stars",
                                subtitle: "Answer all question correctly",
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Please read the following instructions carefully",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              instructions(
                                  instruction:
                                      "Correct and incorrect marks are shown for each and every questions"),
                              SizedBox(height: 15),
                              instructions(
                                  instruction:
                                      "Tap on options to select the correct answer"),
                              SizedBox(height: 15),
                              instructions(
                                  instruction:
                                      "Save each exam answers before submitting (Press the save button)"),
                              SizedBox(height: 15),
                              instructions(
                                  instruction:
                                      "Once you submit the exam, you cannot change the answers"),
                              SizedBox(height: 15),
                              instructions(
                                  instruction:
                                      "Press submit after saving the answers to complete exam (Press submit and end button)"),
                              SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Button at the bottom
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/quiz');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstant.buttonupdate,
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.9, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Start Quiz",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
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

class instructions extends StatelessWidget {
  final String instruction;
  const instructions({
    required this.instruction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(

      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.circle,
          size: 10,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(instruction,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
              softWrap: true),
        )
      ],
    );
  }
}

class IconText extends StatelessWidget {
  final dynamic iconName;
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppConstant.titlecolor,
          child: Icon(
            iconName,
            size: 24,
            color: Colors.white,
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,

              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: const TextStyle(

                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                  color: AppConstant.hindColor),
            ),
          ],

        )
      ],
    );
  }
}