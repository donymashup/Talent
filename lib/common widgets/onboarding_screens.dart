// import 'package:flutter/material.dart';
// import 'package:swipeable_button_view/swipeable_button_view.dart';
// import 'package:talent_app/common%20widgets/welcome_screen.dart';
// import 'package:talent_app/constants/app_constants.dart';
// import 'package:talent_app/features/auth/screen/login.dart'; // Adjust this import as needed

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int currentIndex = 0;

//   final List<OnboardingPageModel> pages = [
//     OnboardingPageModel(
//       imagePath: 'assets/images/onboardingA.jpeg',
//       title: 'A COMPLETE LEARNING APP FOR CLASS 6 - 12 STUDENTS',
//       description:
//           'Comprehensive coverage for all boards and competitive exams',
//     ),
//     OnboardingPageModel(
//       imagePath: 'assets/images/onboardingB.jpeg',
//       title: 'Comprehensive Course Library',
//       description:
//           'Access a Wide Range of Courses Description: Explore a vast collection of courses across various domains, designed by industry experts to help you grow.',
//     ),
//     OnboardingPageModel(
//       imagePath: 'assets/images/onboardingD.jpeg',
//       title: 'Interactive Learning Experience',
//       description:
//           'Engage with Advanced Features Description: Enjoy video lessons, live sessions, quizzes, and gamified learning to make education fun and effective',
//     ),
//     OnboardingPageModel(
//       imagePath: 'assets/images/onboardingE.jpeg',
//       title: 'Smart Progress Tracking',
//       description:
//           'Stay on Top of Your Learning Description: Track your progress with AI-driven insights, personalized recommendations, and automated reminders to keep you motivated.',
//     ),
//   ];

//   bool isFinished = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppConstant.backgroundColor,
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: (index) {
//               setState(() {
//                 currentIndex = index;
//               });
//             },
//             itemCount: pages.length + 1, // Add one for the WelcomePage
//             itemBuilder: (context, index) {
//               if (index == pages.length) {
//                 return WelcomePage(
//                   currentIndex: currentIndex,
//                   totalPages: pages.length + 1,
//                 );
//               } else {
//                 return OnboardingPage(
//                   page: pages[index],
//                   currentIndex: currentIndex,
//                   totalPages: pages.length + 1,
//                 );
//               }
//             },
//           ),
//           currentIndex < pages.length
//               ? Positioned(
//                   bottom: 20,
//                   right: 20,
//                   child: TextButton(
//                     onPressed: () {
//                       _pageController.jumpToPage(pages.length);
//                     },
//                     child: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: SwipeableButtonView(
//                         buttonText: 'Login with Phone',
//                         buttonWidget: const Icon(
//                           Icons.phone,
//                           color: Color.fromARGB(255, 86, 90, 216),
//                         ),
//                         activeColor: AppConstant.primaryColor2,
//                         isFinished: isFinished,
//                         onWaitingProcess: () {
//                           Future.delayed(const Duration(seconds: 1), () {
//                             setState(() {
//                               isFinished = true;
//                             });
//                           });
//                         },
//                         onFinish: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => Login(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: 100),
//                   ],
//                 ),
//         ],
//       ),
//     );
//   }
// }

// class OnboardingPageModel {
//   final String imagePath;
//   final String title;
//   final String description;

//   OnboardingPageModel({
//     required this.imagePath,
//     required this.title,
//     required this.description,
//   });
// }

// class OnboardingPage extends StatelessWidget {
//   final OnboardingPageModel page;
//   final int currentIndex;
//   final int totalPages;

//   const OnboardingPage({
//     required this.page,
//     required this.currentIndex,
//     required this.totalPages,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 2,
//           child: Container(
//             color: AppConstant.backgroundColor,
//             child: ClipPath(
//               clipper: BottomRoundedClipper(),
//               child: Center(
//                 child: Image.asset(
//                   page.imagePath,
//                   height: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             color: AppConstant.backgroundColor,
//             child: Column(
//               children: [
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(
//                     totalPages,
//                     (index) => AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       width: currentIndex == index ? 12 : 8,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color:
//                             currentIndex == index ? Colors.blue : Colors.grey,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         page.title,
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: AppConstant.titlecolor,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         page.description,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: AppConstant.subtitlecolor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BottomRoundedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, size.height - 150);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height,
//       size.width,
//       size.height - 150,
//     );
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:talent_app/common%20widgets/welcome_screen.dart';
import 'package:talent_app/constants/app_constants.dart';
import 'package:talent_app/features/auth/screen/login.dart'; // Adjust this import as needed

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      imagePath: 'assets/images/O1.png',
      title: 'Enter the World of E-Learning',
      description:
          'Begin Your Educational Journey With Access To A Diverse Range Of Courses.',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/O2.png',
      title: 'Personalize Your Learning Path',
      description:
          'Customize Your Learning With Progress Tracking, And Interactive Activities.',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/O3.png',
      title: 'Engage with Expert Instructors',
      description:
          'Connect With Knowledgeable Tutors For Personalized Guidance.',
    ),
    OnboardingPageModel(
      imagePath: 'assets/images/O4.png',
      title: 'Embark on Your Learning Adventure',
      description:
          'Explore Interactive Lessons, Quizzes, And Multimedia Content To Enhance Your Understanding.',
    ),
  ];

  bool isFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: pages.length + 1, // Add one for the WelcomePage
            itemBuilder: (context, index) {
              if (index == pages.length) {
                return WelcomePage(
                  currentIndex: currentIndex,
                  totalPages: pages.length + 1,
                );
              } else {
                return ModernOnboardingPage(
                  page: pages[index],
                  currentIndex: currentIndex,
                  totalPages: pages.length,
                  pageIndex: index,
                );
              }
            },
          ),
          currentIndex < pages.length
              ? Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (currentIndex < pages.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _pageController.jumpToPage(pages.length);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstant.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          _pageController.jumpToPage(pages.length);
                        },
                        child: Text(
                          'SKIP',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SwipeableButtonView(
                        buttonText: 'Login with Phone',
                        buttonWidget: const Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 86, 90, 216),
                        ),
                        activeColor: AppConstant.primaryColor2,
                        isFinished: isFinished,
                        onWaitingProcess: () {
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              isFinished = true;
                            });
                          });
                        },
                        onFinish: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
        ],
      ),
    );
  }
}

class OnboardingPageModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

class ModernOnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;
  final int currentIndex;
  final int totalPages;
  final int pageIndex;

  const ModernOnboardingPage({
    required this.page,
    required this.currentIndex,
    required this.totalPages,
    required this.pageIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    page.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  page.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppConstant.secondaryColorLight,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  page.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pageIndex == index
                            ? Color(0xFF0B9573)
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel page;
  final int currentIndex;
  final int totalPages;

  const OnboardingPage({
    required this.page,
    required this.currentIndex,
    required this.totalPages,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: AppConstant.backgroundColor,
            child: ClipPath(
              clipper: BottomRoundedClipper(),
              child: Center(
                child: Image.asset(
                  page.imagePath,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: AppConstant.backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        page.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppConstant.titlecolor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppConstant.subtitlecolor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomRoundedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 150);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 150,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
