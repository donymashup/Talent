import 'package:flutter/material.dart';
import 'package:talent_app/common%20widgets/color_dot.dart';
import 'package:talent_app/constants/app_constants.dart';

class WelcomePage extends StatefulWidget {
  final int currentIndex;
  final int totalPages;

  const WelcomePage({
    required this.currentIndex,
    required this.totalPages,
    super.key,
  });

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          color: AppConstant.backgroundColor,
        ),
        child: Stack(
          children: [
            // Background dots
            const colorDot(
                top: 30.0,
                right: -40.0,
                width: 150.0,
                height: 150.0,
                Color: AppConstant.bluedot),
            const colorDot(
                top: 20.0,
                left: -20.0,
                width: 100.0,
                height: 100.0,
                Color: AppConstant.orangedot),
            const colorDot(
                top: 150.0,
                right: 350.0,
                width: 30.0,
                height: 30.0,
                Color: AppConstant.bluedot),
            colorDot(
              top: MediaQuery.of(context).size.height / 3,
              right: 220.0,
              width: 150.0,
              height: 150.0,
              Color: AppConstant.reddot,
            ),
            colorDot(
              top: MediaQuery.of(context).size.height / 2,
              right: 80.0,
              width: 20.0,
              height: 20.0,
              Color: Colors.lightBlue,
            ),

            // Main content inside SingleChildScrollView
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                  // Image
                  Center(
                    child: Image.asset(
                      'assets/images/woman.png',
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.totalPages,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: widget.currentIndex == index ? 12.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: widget.currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Welcome To Alpha',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'Learn something new every day. Start your learning journey with Alpha Academy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: SwipeableButtonView(
                  //     buttonText: 'Login with Phone',
                  //     buttonWidget: const Icon(
                  //       Icons.phone,
                  //       color: Color.fromARGB(255, 86, 90, 216),
                  //     ),
                  //     activeColor: AppConstant.primaryColor2,
                  //     isFinished: isFinished,
                  //     onWaitingProcess: () {
                  //       Future.delayed(const Duration(seconds: 1), () {
                  //         setState(() {
                  //           isFinished = true;
                  //         });
                  //       });
                  //     },
                  //     onFinish: () {
                  //       Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => PhoneNumberVerificationPage(),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
